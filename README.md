<div align="center">
<h1 align="center">
<img src="assets/images/logo.png" width="100" />
<br>Notify.AI
</h1>
<h3>◦ Keeps you ahead!</h3>
<h3>◦ Developed with the software and tools below.</h3>

<p align="center">

<img src="https://img.shields.io/badge/FLUTTER-000000.svg?style&logo=FLUTTER" alt="JSON" />
</p>

</div>


---

## 📖 Table of Contents
- [📖 Table of Contents](#-table-of-contents)
- [📍 Overview](#-overview)
- [📦 Features](#-features)
- [📂 Repository Structure](#-repository-structure)
- [⚙️ Modules](#modules)
- [🚀 Getting Started](#-getting-started)
    - [🔧 Installation](#-installation)
    - [🤖 Running Notify AI](#-running-notify-ai)
    - [🧪 Tests](#-tests)
- [🛣 Roadmap](#-roadmap)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)
- [👏 Acknowledgments](#-acknowledgments)

---


## 📍 Overview


Our project involved getting familiar with the Android Development environment and thus developing an application to solve the following problem.
In today's busy world, we often lose track of time. As students ourselves, we often struggle with wasting our time in learning things that do not produce any outcome. We wanted to do something about this by addressing the issue and providing an innovative solution. As a result, we came up with the idea of creating a mobile application that helps us keep track of time and assist in learning by filtering key points using generative AI.
So what our app does is fairly simple, you enter the topic you want to learn and our generative AI model gives the most filtered-out key points for you which makes the learning process fast and simple. Insert the PDFs you want to summarise, our AI model summarises the content and results in the summary in 1-2 lines. And in your app, you can ask questions to the fine-tuned AI model and get a response in a brief

---

## 📦 Features

- Smart learning through Generative AI
- PDF summarising using AI
- Customized Message Notifier


---


## 📂 Repository Structure



---

## ⚙️ Modules

<details closed><summary>Lib</summary>

| File                                                                                  | Summary                                                                                                                                                                                                                                                                                                                          |
| ---                                                                                   | ---                                                                                                                                                                                                                                                                                                                              |
| [boxes.dart](https://github.com/aravindr001/notify2/blob/main/lib/boxes.dart)         | This code imports and initializes Hive, a lightweight and efficient local database solution. It defines two Box instances-"keywords" and "notifications"-to manage data storage, retrieval, and manipulation.                                                                                                                    |
| [main.dart](https://github.com/aravindr001/notify2/blob/main/lib/main.dart)           | This code sets up and initializes the required dependencies for a notification app. It handles requesting notifications permissions, initializes the Hive database, registers an adapter for NotificationDataModel, opens Hive boxes for keywords and notifications, and sets up the app UI with a material theme and splash screen.    |
| [app_theme.dart](https://github.com/aravindr001/notify2/blob/main/lib/app_theme.dart) | This code defines a customizable app theme for a Flutter application, including colours and text styles. It also provides a TextTheme object, which maps different text styles to specific typography elements like headings and captions. The code aims to provide a unified and consistent visual design for the app interface. |

</details>

<details closed><summary>Model</summary>

| File                                                                                                  | Summary                                                                                                                                                                                                                                                                                                                                                                 |
| ---                                                                                                   | ---                                                                                                                                                                                                                                                                                                                                                                     |
| [homelist.dart](https://github.com/aravindr001/notify2/blob/main/lib/model/homelist.dart)             | The code defines a class called HomeList that represents a list of home screen options in a Flutter application. Each option has an image path, a name, and a navigateScreen property, which determines the widget to be displayed when the option is selected. This code provides functionality for navigating to a chatbot screen, a PDF screen, and a chats screen. |
| [models_model.dart](https://github.com/aravindr001/notify2/blob/main/lib/model/models_model.dart)     | The code defines a ModelsModel class with properties like id, created, and root. It includes a constructor to initialize the model, a factory method to parse JSON and create model instances, and a static method to convert a model snapshot into a list of ModelsModel objects.                                                                                      |
| [chat_model.dart](https://github.com/aravindr001/notify2/blob/main/lib/model/chat_model.dart)         | The ChatModel class is a data model that represents a chat message. It has two properties: "msg" for the message content, and "chatIndex" for the index of the chat. With a constructor and a factory method, it can easily convert JSON data into an instance of the ChatModel class.                                                                                  |
| [notification.dart](https://github.com/aravindr001/notify2/blob/main/lib/model/notification.dart)     | This code defines a data model class for storing notification data. It uses the Hive library for serialization and deserialization. The class has fields for title, text, package name, and creation timestamp.                                                                                                                                                             |
| [notification.g.dart](https://github.com/aravindr001/notify2/blob/main/lib/model/notification.g.dart) | This code is a generated TypeAdapter for the NotificationDataModel class. It provides methods to read and write instances of this class in a binary format. It specifies how the object fields should be serialized and deserialized.                                                                                                                                   |

</details>

<details closed><summary>Constants</summary>

| File                                                                                              | Summary                                                                                                                                                                                            |
| ---                                                                                               | ---                                                                                                                                                                                                |
| [api_consts.dart](https://github.com/aravindr001/notify2/blob/main/lib/constants/api_consts.dart) | This code sets the base URL and the API key for connecting to the OpenAI API. It provides the essential information required to initialize and authenticate API calls in subsequent code segments. |

</details>

<details closed><summary>Services</summary>

| File                                                                                                             | Summary                                                                                                                                                                                                                                                                                                                                                                                            |
| ---                                                                                                              | ---                                                                                                                                                                                                                                                                                                                                                                                                |
| [assets_manager.dart](https://github.com/aravindr001/notify2/blob/main/lib/services/assets_manager.dart)         | The code defines an AssetsManager class with static variables that store paths to various image files and an animation file used for loading.                                                                                                                                                                                                                                                      |
| [local_notification.dart](https://github.com/aravindr001/notify2/blob/main/lib/services/local_notification.dart) | This code snippet defines a class called "LocalNotification" that provides functions to initialize and show local notifications using the Flutter Local Notifications plugin. The "initialize" function sets up the necessary settings for notifications on both Android and iOS platforms, while the "showBigTextNotification" function displays a notification with a given title and body text. |
| [api_service.dart](https://github.com/aravindr001/notify2/blob/main/lib/services/api_service.dart)               | The code provides functionality for making API requests to fetch models, sending messages using ChatGPT API, and sending generic messages. It also handles error cases and parses the response data into appropriate models.                                                                                                                                                                       |

</details>

<details closed><summary>Providers</summary>

| File                                                                                                        | Summary                                                                                                                                                                                                                                                                                                                       |
| ---                                                                                                         | ---                                                                                                                                                                                                                                                                                                                           |
| [models_provider.dart](https://github.com/aravindr001/notify2/blob/main/lib/providers/models_provider.dart) | The ModelsProvider class is responsible for managing the current and available AI models. It provides a method to get all the available models from an API and another method to set the current model. These functionalities are important for the overall functioning of the application.                                   |
| [chats_provider.dart](https://github.com/aravindr001/notify2/blob/main/lib/providers/chats_provider.dart)   | This code defines a ChatProvider class that manages a list of chat messages. It provides methods to add user messages and send them to an API. The API service retrieves responses based on the message and chosen model id. The code also uses the ChangeNotifier class to notify listeners of any changes in the chat list. |

</details>

<details closed><summary>Custom_drawer</summary>

| File                                                                                                                          | Summary                                                                                                                                                                                                                                                                                                           |
| ---                                                                                                                           | ---                                                                                                                                                                                                                                                                                                               |
| [drawer_user_controller.dart](https://github.com/aravindr001/notify2/blob/main/lib/custom_drawer/drawer_user_controller.dart) | The code provides a customizable drawer controller widget for Flutter apps. It supports animation, scrolling, and user interaction to open and close the drawer. It also allows users to define their own menu view and uses a side panel for navigation. The code ensures a seamless and smooth user experience. |
| [home_drawer.dart](https://github.com/aravindr001/notify2/blob/main/lib/custom_drawer/home_drawer.dart)                       | This code implements a responsive home drawer menu with multiple options. It uses Flutter's Material Design elements and allows for navigation between different screens. It also includes animations and styling for a visually appealing user interface.                                                        |

</details>

<details closed><summary>Navigator</summary>

| File                                                                                  | Summary                                                                                                                                                                                                                                                                     |
| ---                                                                                   | ---                                                                                                                                                                                                                                                                         |
| [chat.dart](https://github.com/aravindr001/notify2/blob/main/lib/navigator/chat.dart) | The code initializes a Flutter ChatBot application by providing chat functionalities. It uses providers to manage the state of chat models and chat data and implements a multi-provider setup. The code also sets up the main UI elements and themes for the application. |

</details>

<details closed><summary>Pages</summary>

| File                                                                                                                  | Summary                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| ---                                                                                                                   | ---                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| [chat_noti.dart](https://github.com/aravindr001/notify2/blob/main/lib/pages/chat_noti.dart)                           | The code represents a chat screen in a messaging app. It includes functionalities such as displaying chat messages, sending messages, and showing typing indicators. It utilizes various Flutter widgets, providers, controllers, and focus nodes to manage message input and display.                                                                                                                                                                                         |
| [message_screen.dart](https://github.com/aravindr001/notify2/blob/main/lib/pages/message_screen.dart)                 | This code defines a message screen in a Flutter app. It utilizes Hive to store and retrieve notifications. The screen displays a list of notifications in a ListView, with each item showing the notification title, text, package name, and creation time. The notifications are displayed in reverse order with a divider between them.                                                                                                                                      |
| [pdf_screen.dart](https://github.com/aravindr001/notify2/blob/main/lib/pages/pdf_screen.dart)                         | This code is a Flutter application that allows users to select and summarize PDF files using an AI model. It uses the File Picker package to select the PDF file, the SfPdfViewer package to display the file, and the ReadPdfText package to extract the text from the PDF. It also uses an API to send the extracted text to an AI model for summarization. The summarized text is then displayed to the user.                                                               |
| [navigation_home_screen.dart](https://github.com/aravindr001/notify2/blob/main/lib/pages/navigation_home_screen.dart) | The code is a Flutter app that serves as a navigation home screen. It includes a custom drawer and different screens that can be accessed through the drawer. The screens include a home screen, a keyword screen, and an about screen. The app allows users to switch between these screens based on the selected option in the drawer. The code also includes some commented-out sections that are not currently in use.                                                     |
| [about_screen.dart](https://github.com/aravindr001/notify2/blob/main/lib/pages/about_screen.dart)                     | The code defines a screen in a Flutter app called AboutScreen. It constructs a blank screen using the Placeholder widget.                                                                                                                                                                                                                                                                                                                                                      |
| [keyword_screen.dart](https://github.com/aravindr001/notify2/blob/main/lib/pages/keyword_screen.dart)                 | This code is a Flutter application that allows users to add and view a list of keywords. The app uses Hive as the database for storing the keywords. The KeyScreen widget displays the keywords in a ListView, allowing users to delete individual keywords. It also provides a FloatingActionButton for adding new keywords using a dialogue box.                                                                                                                               |
| [home_screen.dart](https://github.com/aravindr001/notify2/blob/main/lib/pages/home_screen.dart)                       | This code is for a Flutter app that listens to phone notifications and displays them in a grid view. It uses the flutter_notification_listener plugin to handle notifications and the flutter_local_notifications plugin to show local notifications. The code also includes functionalities for starting and stopping the notification listener service and handling different types of notifications. It has a responsive design and uses animations for smooth transitions. |
| [chat_screen.dart](https://github.com/aravindr001/notify2/blob/main/lib/pages/chat_screen.dart)                       | This code is a Flutter application that listens for notifications from messaging apps and displays them in a chat-like interface. It utilizes the Flutter Local Notifications plugin to show local notifications when certain keywords are mentioned in the messages. The code also includes functionality to start and stop the notification listening service. There is also a pop-up menu with options for managing synonyms, settings, and logout.                         |
| [splash_screen.dart](https://github.com/aravindr001/notify2/blob/main/lib/pages/splash_screen.dart)                   | The code defines a SplashScreen that uses the animated_splash_screen package to display a fading transition splash screen with an image. Once the splash screen finishes, it navigates to the NavigationHomeScreen using a left-to-right page transition. The splash image size is set to 200.                                                                                                                                                                                 |
| [home_drawer.dart](https://github.com/aravindr001/notify2/blob/main/lib/pages/home_drawer.dart)                       | The code is for a Flutter widget called HomeDrawer, which is a custom drawer widget for a mobile app. It provides navigation options with icons and labels, as well as a sign-out option. The drawer uses animations for visual enhancements. It allows the user to switch between different screens within the app by selecting the desired option in the drawer.                                                                                                             |

</details>

<details closed><summary>Widgets</summary>

| File                                                                                              | Summary                                                                                                                                                                                                                                                                                                                                                        |
| ---                                                                                               | ---                                                                                                                                                                                                                                                                                                                                                            |
| [text_widget.dart](https://github.com/aravindr001/notify2/blob/main/lib/widgets/text_widget.dart) | The code defines a reusable TextWidget class in Flutter that creates a text element. It allows customization of labels, font size, colour, and font-weight. It defaults to a black colour and medium font weight.                                                                                                                                                 |
| [chat_widget.dart](https://github.com/aravindr001/notify2/blob/main/lib/widgets/chat_widget.dart) | The `ChatWidget` class is a Flutter widget that displays a chat message. It can either show the message as plain text or animate it using the `AnimatedTextKit` widget. The appearance of the widget depends on the `chatIndex` and `shouldAnimate` properties. The widget also includes an image and can display icons for liking or disliking the message. |
| [backwidget.dart](https://github.com/aravindr001/notify2/blob/main/lib/widgets/backwidget.dart)   | The code defines a "Back" widget that is a button with an arrow icon. When pressed, it navigates the user back to the "NavigationHomeScreen" using Flutter's navigation functionality. The button is styled with a black colour. This widget can be used to provide a back button functionality in a Flutter application.                                       |

</details>



---

## 🚀 Getting Started

***Dependencies***

Please ensure you have the following dependencies installed on your Android phone:

`- ℹ️ Flutter`

`- ℹ️ Visual Studio Code`

`- ℹ️ Android simulator (or external Android device)`


### 🔧 Installation

1. Clone the repository:
```sh
git clone https://github.com/aravindr001/notify2
```

2. Change to the project directory:
```sh
cd notify2
```

3. Download this repository locally on your system `flutter_notification_listener` using the repository given below:<br>
   Reason: The authorized repository has some bugs, so it was necessary to fork it and fix it.
```sh
git clone https://github.com/aravindr001/flutter_notification_listener.git
```
<img width="1280" alt="Screenshot 2023-09-23 at 3 35 19 PM" src="https://github.com/aravindr001/notify2/assets/120251962/5edd3510-9b00-470d-8937-f28735b46599">

You should replace the path of the flutter_notification_listener with your path


4. You should add the path of the cloned
```sh
flutter_notification_listener:
    path: <YOUR_PATH>
```

5. Install the dependencies:
```sh
pub get
```
This should install all the dependencies of the app

### 🤖 Running NOTIFY.AI

<a name="-running-notify-ai"></a>

- Go to the lib/main.dart
- Boot your `Android emulator` or connect an `Android device`
- Run it in `Run without debug` mode








## 👏 Acknowledgments

`- ℹ️ List any resources, contributors, inspiration, etc.`

---
