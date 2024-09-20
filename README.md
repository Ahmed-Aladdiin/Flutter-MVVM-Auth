# Flutter MVVM Authentication

Is a complete authentication feature that can be used for any application.

## Application Features:
- Online Authentication in case of internet connection
- Offline Authentication using previously cashed user Data
- Persistent Login: stay logged in as long as you didn't log out
    - Fetches and caches user data in case of internet connection to stay up to data
    - Uses cached data if no internet connection is possible
- Use of NoSQL local data base to store cached user data and access tokens
- Complete and Comprehensive error handling for all possible cases
- Use of real API calls to authenticate and fetch user data
- Build on a clean MVVM architectural pattern

## Used Technologies:
- Flutter for UI
  - Flutter Riverpod state management
  - Hive NoSQL local database
- Node.js and Express.js for server
- MongoDB
- JWT
- Bcrypt

## How to Run
1. clone the repository
2. navigate to the server directory
3. create a '.env' file similar the provided '.template.env' file
4. install the packages 'npm i'
5. run the server 'npm run dev'
6. navigate to the client director from the root directory of the project
1. open in your preferred editor (vs code)
1. in the 'lib/core/constant/server_constants.dart' file, add the ip address of your machine
1. in terminal, use 'flatter pub get' command
1. run the application 