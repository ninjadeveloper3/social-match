# social-match
# Flutter AI Chatbot with Personalized User Profile Creation

[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.png?v=103)](https://github.com/ellerbrock/open-source-badges/)
[![Flutter](https://img.shields.io/badge/Platform-Flutter-blue.svg)](https://www.flutter.dev/)
[![Dart](https://img.shields.io/badge/Language-Dart-purple.svg)](https://dart.dev/)

![Intro](https://media.giphy.com/media/du3J3cXyzhj75IOgvA/giphy.gif)

## Overview
This is an open-source Flutter application that leverages the power of AI to provide a unique user experience. The app features an AI chatbot which users can interact with, similar to ChatGPT. The backbone of this interaction is built using Natural Language Processing (NLP) provided by Google's ML Kit.

The unique feature of this app is its ability to create a personalized profile for each user. The user profile is fully maintained within the user device, with strict measures taken to ensure that no information is sent to any external server via APIs.

## Features
### Personalized User Profile
The app collects a variety of information to create a comprehensive user profile. This includes:
* User's location
* Physical activity (using Health Connect)
* Preferred playlist genre (extracted from the user's audio files)
* Most used social media application (based on time spent)

All these data points work together to create a highly personalized user profile that is securely stored on the user's device.

### AI Chatbot
Our AI chatbot, powered by NLP, can extract key details from user's inputs, such as events, time and location. For example, if a user types "I want to play football at 9pm tonight at XYZ place", the chatbot will identify "football" as the event, "9pm" as the time, and "XYZ place" as the location.

### Matrix Server
The app includes a Matrix server for showing chatrooms. The purpose of the Matrix server is to connect users with similar interests. When a user interacts with the AI chatbot, event details are sent to the Matrix server. Users with matching profiles can then see and join relevant chatrooms. 

## Screenshots/Videos

https://drive.google.com/file/d/1bGlUNazBUnyc4rVVqQypZfoANraYMMZP/view?usp=sharing


## Installation & Setup
_Follow these steps to build and run the project._

* Clone this repository and navigate into the cloned directory.
* Run `flutter pub get` to fetch the necessary Dart packages.
* Run `flutter run` to start the application in Debug Mode.

## Contributing
Contributions are what make the open source community such an amazing place to be, learn, inspire, and create. Any contributions you make are **greatly appreciated**. 

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Security
User privacy and data security is our utmost priority. The personalized user profile is created and stored solely on the user's device. None of the information is sent to any external server through APIs.

## License
This project is licensed under the terms of the MIT license.

## Acknowledgments
Thanks to the open-source community for providing inspiration and code snippets for this project. Special thanks to Google's ML Kit and Matrix Server for powering our core features.

For any queries, feel free to open an issue, or reach out. Enjoy using the app!
