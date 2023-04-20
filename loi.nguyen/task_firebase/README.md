## How to setup and config?
- Setup
    1. Clone project from my branch
        ```
        git clone -b loi.nguyen https://github.com/khoale-lifetechvn/intern-training-042023.git
        ```
    2. Open terminal and cd to `task_firebase`
    3. Install dependencies
        ```
        flutter pub get
        ```
    4. Run
        ```
        + Web: flutter run -d chrome
        + Android: flutter run -d android
        + Ios: flutter run -d ios
        ```
- Config (.env)
    - Current status api support for web: because the setup values for each platform (web, android, and iOS) is different in this code.
    - You can read file [.env](https://github.com/khoale-lifetechvn/intern-training-042023/blob/loi.nguyen/loi.nguyen/task_firebase/.env)
# Feautures
- You can read demo: [demo](https://firestore-root.web.app/#/)
- Status complete:
    - [ ] Realtime database
    - [ ] Notification 
    - [x] Hosting firebase
    - [x] Authenication (Email, password)
    - [x] Authenication (Facebook)
    - [x] Authenication (Google)
    - [x] Authenication (Github)
    - [x] CRUD (firestorage)
- You can read here

|                             | Web  | Android | IOS  |
| --------------------------- | :--: | :-----: | :--: |
| .env                        |  ✅   |    👌    |  👌   |
| Upload file (image, pdf,..) |  ❌   |    ✅    |  🤣   |
| Authenication facebook      |  ❌   |    ✅    |  👌   |
| Authenication github        |  ❌   |    ✅    |  👌   |
| Authenication google        |  ❌   |    ✅    |  👌   |
| CRUD Firestore              |  ✅   |    ✅    |  ✅   |
| Build                       |  ✅   |    ✅    |  👌   |

- ✅ Completed and test
- ❌ Uncompleted and need have many time (Can fix)
- 👌Can fix EZ if required
- 🤣Completed but not checked yet



## Build
1. How to setup firebase [link](https://github.com/loinguyen-lifetechvn/Task_Firebase/issues/1)
2. SignIn
    - [Google](https://github.com/loinguyen-lifetechvn/Task_Firebase/issues/2)
    - [Facebook](https://github.com/loinguyen-lifetechvn/Task_Firebase/issues/3)
    - [Github](https://github.com/loinguyen-lifetechvn/Task_Firebase/issues/4)
3. Hosting:[Medium](https://levelup.gitconnected.com/how-to-host-your-flutter-web-app-with-firebase-hosting-67d3e4657002) 
