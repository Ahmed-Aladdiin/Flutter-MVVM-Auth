# Flutter MVVM Authentication

A complete authentication feature that can be integrated into any Flutter application.

## Features:
- **Online Authentication**: Works when there is an internet connection.
- **Offline Authentication**: Uses cached user data when offline.
- **Persistent Login**: Stays logged in until the user logs out.
    - Fetches and caches user data when online, keeping it up-to-date.
    - Uses cached data if no internet is available.
- **NoSQL Local Database**: Stores cached user data and access tokens.
- **Comprehensive Error Handling**: Handles all possible error cases.
- **Real API Integration**: Authenticates and fetches user data through real API calls.
- Built on a **Clean MVVM Architectural Pattern**.

## Technologies Used:
- **Flutter** for UI
  - **Riverpod** for state management
  - **Hive** for local NoSQL storage
- **Node.js** and **Express.js** for backend server
- **MongoDB** for database
- **JWT** for authentication
- **Bcrypt** for password hashing

## How to Run the Project

### Backend (Node.js Server)
1. Clone the repository:
    ```bash
    git clone git@github.com:Ahmed-Aladdiin/Flutter-MVVM-Auth.git
    ```
2. Navigate to the server directory:
    ```bash
    cd server
    ```
3. Create a `.env` file based on the provided `.template.env` file:
    ```bash
    cp .template.env .env
    ```
4. Install the necessary Node.js packages:
    ```bash
    npm install
    ```
5. Start the server in development mode:
    ```bash
    npm run dev
    ```

### Flutter Client
1. Navigate to the client directory from the root of the project:
    ```bash
    cd client
    ```
2. Open the project in your preferred editor (e.g., VS Code):
    ```bash
    code .
    ```
3. In the `lib/core/constant/server_constants.dart` file, update the IP address to match your machine's IP.
4. In the terminal, get Flutter dependencies:
    ```bash
    flutter pub get
    ```
5. Run the Flutter application:
    ```bash
    flutter run
    ```

Now, you're all set to run both the backend server and the Flutter client!