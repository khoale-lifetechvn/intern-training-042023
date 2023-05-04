## How to setup and config?
- With the child table, you must create `seftId` for each to query faster. By using **collectionGroup** you read more at [stackOverfollow](https://stackoverflow.com/questions/68433976/firestore-collection-group-query-on-document-id)
- Structure database
```
 --- users (collection)
   |     |
   |     --- uid (documents)
   |          |
   |          --- name: "User Name"
   |          |
   |          --- email: "email@email.com"
   |          |
   |          --- dob: "19900515"
   |          |
   |          --- createdAt: March 24, 2022 at 9:00:00 PM UTC+7
   |          |
   |          --- updatedAt: March 24, 2022 at 10:15:00 PM UTC+7
   |
	--- emoji (collection)
   |     |
   |     --- emojiId (documents)
   |          |
   |          --- image: "abc.png"
   |          |
   |          --- number: 1
   |          |
   |          --- title: "Like" 
   |          |
   |          --- createdAt: March 24, 2022 at 9:00:00 PM UTC+7
   |          |
   |          --- updatedAt: March 24, 2022 at 10:15:00 PM UTC+7
   |
   
   --- reaction (collection)
   |     |
   |     --- uid (documents)
   |           |
   |           --- emojiPost (collection)
   |                 |
   |                 ---postId (documents)
   | 				 | 	   |
   |                 |     --- emojiRef: "emoji/wgm5PO0R2rjLmYHmAVqj"
   |                 |     |
   |                 |     --- createdAt: March 24, 2022 at 9:00:00 PM UTC+7
   |                 |
   |                 ---postId (documents)
   | 				 | 	   |
   |                 |     --- emojiRef: "emoji/wgm5PO0R2rjLmYHmAVqj"
   |                 |     |
   |                 |     --- createdAt: March 24, 2022 at 9:00:00 PM UTC+7
   |                 |     |
   |
   |           --- emojiComment (collection)
   |                 |
   |                 ---commentId (documents)
   | 				 | 	   |
   |                 |     --- emojiRef: "emoji/wgm5PO0R2rjLmYHmAVqj"
   |                 |     |
   |                 |     --- createdAt: March 24, 2022 at 9:00:00 PM UTC+7
   |                 |
   |                 ---commentId (documents)
   | 				 | 	   |
   |                 |     --- emojiRef: "emoji/wgm5PO0R2rjLmYHmAVqj"
   |                 |     |
   |                 |     --- createdAt: March 24, 2022 at 9:00:00 PM UTC+7
   |                 |     |
   |
   --- following (collection)
   |      |
   |      --- uid (document)
   |           |
   |           --- userFollowing (collection)
   |                 |
   |                 --- uid (documents)
   |                 |
   |                 --- uid (documents)
   --- block (collection)
   |      |
   |      --- uid (document)
   |           |
   |           --- userBlock (collection)
   |                 |
   |                 --- uid (documents)
   |                 |
   |                 --- uid (documents)
   |
   --- posts (collection)
   |      |
   |      --- uid (documents)
   |           |
   |           --- userPosts (collection)
   |                 |
   |                 --- postId (documents)
   |                 |     |
   |                 |     --- title: "Post Title"
   |                 |     |
   |                 |     --- content: "post content"
   |                 |     |
   |                 |     --- createdAt: March 24, 2022 at 9:00:00 PM UTC+7
   |                 |     |
   |                 |     --- updatedAt: March 24, 2022 at 10:15:00 PM UTC+7
   |                 |
   |                 --- postId (documents)
   |                       |
   |                       --- title: "Second Post Title"
   |                       |
   |                       --- content: "second post content"
   |                       |
   |                       --- createdAt: September 03, 2018 at 6:16:58 PM UTC+7
   |                       |
   |                       --- updatedAt: September 03, 2018 at 6:16:58 PM UTC+7
   
   |        
   ---comments (collection)
          |
          ---postId (documents)
            |
            --postComments (collection)
            |      |
            |     --commentId (documents)
            |     |     |
            |     |     --userRef : "users/wgm5PO0R2rjLmYHmAVqj"
            |     |     |
            |     |     --content: "first comment of user 2"
            |     |     |
            |     |     -- createdAt: September 12, 2013 at 6:16:58 PM UTC+7
            |     |
            |     |--commentId (documents)
            |           |
            |           --userRef : "user/JZlP4lYxRfas7yymAmpP"
            |           |
            |            --content: "second comment of user 2"
            |           |
            |           -- createdAt: September 12, 2013 at 6:16:58 PM UTC+7
				
```
- Setup flutter
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
