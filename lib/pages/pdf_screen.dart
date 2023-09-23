import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:notify2/model/chat_model.dart';
import 'package:notify2/constants/api_consts.dart';
import 'package:notify2/widgets/backwidget.dart';
import 'package:read_pdf_text/read_pdf_text.dart';
import 'package:http/http.dart' as http;
import 'package:notify2/services/assets_manager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

String currentModel = "ft:gpt-3.5-turbo-0613:personal:noti:81T2Yydj";

class PdfScreen extends StatefulWidget {
  PdfScreen({super.key});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  FilePickerResult? result;

  String? fileName;

  PlatformFile? pickedFile;

  bool isLoading = false;

  File? fileToDisplay;

  bool summerize = false;

  @override
  void initState() {
    super.initState();
  }

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });

      summerize = false;

      result = await FilePicker.platform.pickFiles();

      if (result != null) {
        fileName = result!.files.first.name;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());

      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
            leading: const Back(),
            centerTitle: true,
            title: const Text(
              'AI PDF ASSIST',
              style: TextStyle(fontSize: 19, letterSpacing: 3),
            )),
        body: isLoading
            ? const SizedBox()
            : Column(
                children: [
                  if (result == null)
                    const Expanded(
                        child: Center(
                      child: Text(
                        'Click the icon below and add select a pdf file\n to summerise',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
                  if (result != null)
                    Expanded(
                      child: summerize
                          ? FutureBuilder<String>(
                              future: getPDFtext(pickedFile!.path.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot.data.toString(),
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          const SizedBox(
                                            width: double.infinity,
                                            height: 50,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Text('');
                                }
                                return const Loading();
                              },
                            )
                          : Column(
                              children: [
                                Expanded(
                                  flex: 10,
                                    child: SfPdfViewer.file(fileToDisplay!)),
                                Expanded(
                                  flex:  1,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                                  const Color.fromARGB(255, 233, 217, 252))
                                      // padding:,
                                    ),
                                      onPressed: () {
                                        setState(() {
                                          summerize = true;
                                        });
                                      },
                                      child: const Text(
                                        'SUMMARIZE',
                                        style: TextStyle(letterSpacing: 1,
                                        fontSize: 20
                                        ),
                                      )),
                                )
                              ],
                            ),
                      // child:FutureBuilder<String>(
                      //   future: getPDFtext(pickedFile!.path.toString()),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       return Padding(
                      //         padding: const EdgeInsets.all(20),
                      //         child: SingleChildScrollView(
                      //           child: Column(
                      //             children: [
                      //               Text(snapshot.data.toString(),
                      //                 style: const TextStyle(
                      //                   fontSize: 20
                      //                 ),),
                      //                 const SizedBox(width: double.infinity,height: 50,)
                      //             ],
                      //           ),
                      //         ),
                      //         );
                      //     } else if (snapshot.hasError) {
                      //       return const Text('');
                      //     }
                      //     return const Loading();
                      //   },
                      // ),
                    ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: pickFile,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class PdfView extends StatelessWidget {
  const PdfView({
    super.key,
    required this.fileToDisplay,
  });

  final File? fileToDisplay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SfPdfViewer.file(fileToDisplay!)),
        ElevatedButton(
            onPressed: () {},
            child: const Text(
              'SUMMARIZE',
              style: TextStyle(letterSpacing: 1),
            ))
      ],
    );
  }
}

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: LottieBuilder.asset(
      AssetsManager.loading,
      height: 200,
    ));
  }
}

Future<String> getPDFtext(String path) async {
  String text = "";

  List<ChatModel>? chat;

  try {
    text = await ReadPdfText.getPDFtext(path);

    chat = await sendMessageGPT(message: text, modelId: currentModel);
  } on PlatformException {
    print('Failed to get PDF text.');
  }

  return chat![0].msg;
}

Future<List<ChatModel>> sendMessageGPT(
    {required String message, required String modelId}) async {
  try {
    log("modelId $modelId");
    var response = await http.post(
      Uri.parse("$BASE_URL/chat/completions"),
      headers: {
        'Authorization': 'Bearer $API_KEY',
        "Content-Type": "application/json"
      },
      body: jsonEncode(
        {
          "model": modelId,
          "messages": [
            {
              "role": "user",
              "content": message,
            }
          ]
        },
      ),
    );

    Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    if (jsonResponse['error'] != null) {
      throw HttpException(jsonResponse['error']["message"]);
    }
    List<ChatModel> chatList = [];
    if (jsonResponse["choices"].length > 0) {
      chatList = List.generate(
        jsonResponse["choices"].length,
        (index) => ChatModel(
          msg: jsonResponse["choices"][index]["message"]["content"],
          chatIndex: 1,
        ),
      );
    }
    // print(chatList[0].msg);
    return chatList;
  } catch (error) {
    log("error $error");
    rethrow;
  }
}
