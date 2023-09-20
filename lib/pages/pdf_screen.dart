import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:read_pdf_text/read_pdf_text.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      // String initialDirectory =
      //     await FilePicker.getPlatform().getDirectoryPath();

      // String initialDirectory = await FilePicker.platform.pickFiles().toString();
      // print('${initialDirectory.characters} initialDirectory');
      result = await FilePicker.platform.pickFiles();

      if (result != null) {
        fileName = result!.files.first.name;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());

        print('file name $fileToDisplay');
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
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'AI PDF SUMMARIZER',
        style: TextStyle(fontSize: 19, letterSpacing: 3),
      )),
      body: isLoading
          ? const Loading()
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
                    child:
                        // child: Image.file(fileToDisplay!),
                        // SfPdfViewer.file(fileToDisplay!),
                        FutureBuilder<String>(
                      future: getPDFtext(pickedFile!.path.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data.toString());
                        } else if (snapshot.hasError) {
                          return Text('');
                        }
                        return const Loading();
                      },
                    ),
                  ),
              ],
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: pickFile,
        child: const Icon(Icons.add),
      ),
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
      child: CircularProgressIndicator(),
    );
  }
}

Future<String> getPDFtext(String path) async {
  String text = "";
  try {
    text = await ReadPdfText.getPDFtext(path);
  } on PlatformException {
    print('Failed to get PDF text.');
  }
  return text;
}
