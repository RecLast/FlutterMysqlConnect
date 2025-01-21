# Flutter MySQL Connect

A secure authentication application using Flutter with MySQL database
connection.

## 📑 Contents

-   [Features](#features)
-   [Setup](#setup)
-   [Database Configuration](#database-configuration)
-   [Authentication Structure](#authentication-structure)
-   [Theme Structure](#theme-structure)
-   [Language Management](#language-management)
-   [Error Handling](#error-handling)
-   [Security](#security)
-   [Architecture](#architecture)
-   [Folder Structure](#folder-structure)

## ✨Features

-   🔐 Secure MySQL connection
-   🔐 Encryption MYSQL Information
-   🔐 Authentication (Login/Register)
-   🔐 NetworkControl/DatabaseControl/Login Control (Splash Screen)
-   🔒 Password encryption with BCrypt
-   🌍 TR/EN language support
-   🎨 Customizable theme
-   📱 Responsive design
-   ⚡ Performance optimization

## ⚙️Setup

### Requirements

    • Flutter SDK (>=3.2.3)
    • MySQL Server
    • MySQL Workbench (recommended)

### Steps

1.  Clone the project:

        git clone https://github.com/RecLast/FlutterMysqlConnect.git

2.  Install dependencies:

        flutter pub get

## 💾Database Configuration

### 1. Create Database

    CREATE DATABASE flutter_mysql_connect;

### 2. Table Structure

    CREATE TABLE users (
        id INT PRIMARY KEY AUTO_INCREMENT,
        username VARCHAR(50) UNIQUE NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        password VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

### 3. Secure Connection Configuration

To configure MySQL connection information securely:

1.  Edit `lib/core/utils/config_generator.dart` file:

        final config = {
            'host': 'localhost',
            'port': '3306',
            'user': 'your_username',
            'password': 'your_password',
            'db': 'your_database'
        };

2.  Run the config generator:

        dart run lib/core/utils/config_generator.dart

3.  Generated encrypted config file: `assets/config/db_config.enc`

::: info
**🔐 Security:** Connection information is protected with XOR encryption
and SHA-256.
:::

## 🔑Authentication Structure

The authentication system is configured under `features/auth` with MVVM
architecture:

    features/auth/
    ├── model/
    │   └── user_model.dart          # User data model
    ├── view/
    │   ├── sign_view.dart           # Login/Register screen
    │   └── splash_view.dart         # Splash screen
    └── viewmodel/
        └── auth_view_model.dart     # Authentication business logic

### Authentication Flow

1.  Session check in splash screen
2.  Login/Register form validation
3.  Password hashing with BCrypt
4.  JWT token management

## 🎨Theme Structure

Theme management is centrally configured under `core/theme`:

    core/theme/
    ├── app_colors.dart      # Color palettes
    ├── app_text_styles.dart # Typography styles
    └── app_theme.dart       # Theme configuration

::: info
**💡 Customization:** All colors and styles can be managed from a single
point.
:::

### Theme Usage

    // Color usage
    color: AppColors.darkBlue['primary']

    // Text style usage
    style: AppTextStyles.ubuntuBold.copyWith(
        fontSize: 24,
        color: Colors.white,
    )

## 🌍Language Management

Multi-language support is configured under `core/init/lang`:

    core/init/lang/
    ├── locale_keys.dart    # Language keys
    ├── locale_manager.dart # Language manager
    └── translations/       # Language files
        ├── tr.json
        └── en.json

### Language Usage

    // Change language
    LocaleManager.instance.setLocale(const Locale('en', 'US'));

    // Text translation
    Text(LocaleKeys.welcome.tr())

## ⚠️Error Handling

Central error management is configured under `core/base`:

    core/base/
    ├── error/
    │   ├── base_error.dart      # Base error class
    │   ├── network_error.dart   # Network errors
    │   └── database_error.dart  # Database errors
    └── result/
        └── result_model.dart    # Result model

### Error Handling Usage

    try {
      await operation();
    } on NetworkError catch (e) {
      showErrorDialog(e.message);
    } on DatabaseError catch (e) {
      logError(e);
      showErrorSnackbar(e.message);
    }

::: warning
**🔍 Error Tracking:** All errors are centrally logged and appropriate
messages are shown to the user.
:::

## 🔒Security

### Encryption

-   Secure password hashing with BCrypt
-   Sensitive data encryption with AES-256
-   Secure connection with SSL/TLS

### SQL Injection Protection

    // Unsafe Usage ❌
    "SELECT * FROM users WHERE username = '$username'"

    // Safe Usage ✅
    "SELECT * FROM users WHERE username = ?"

## 🏗️ Architecture

The project is developed using MVVM (Model-View-ViewModel) architecture:

-   **Model:** Data structures and database operations
-   **View:** UI components
-   **ViewModel:** Business logic and state management

## 📁Folder Structure

    lib/
    ├── core/
    │   ├── init/
    │   │   ├── database/      # MySQL connection management
    │   │   ├── encryption/    # Encryption services
    │   │   └── lang/         # Language management
    │   ├── services/         # General services
    │   ├── theme/           # Theme configuration
    │   └── utils/           # Helper utilities
    └── features/
        ├── auth/            # Authentication
        │   ├── model/
        │   ├── view/
        │   └── viewmodel/
        └── home/            # Home page
            ├── model/
            ├── view/
            └── viewmodel/

::: info
**💡 Tip:** Visit our [Wiki
page](https://github.com/RecLast/FlutterMysqlConnect/wiki) for detailed
code examples and API documentation.
:::

## 📞 Contact

For questions and suggestions: <by_reclast@hotmail.com>

© 2025 Flutter MySQL Connect. Developed by [Ümit
Eski](www.umiteski.com.tr). Licensed under MIT License.