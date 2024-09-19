# SLTC Foodie

SLTC Foodie is a food reservation app designed for users to log in, browse food items, view detailed descriptions, manage their orders, and make payments. The app integrates with Firebase for authentication, database management, and storage.

<img src="https://github.com/sahan026/images/blob/main/SLTC_app_iocn.png" alt="App Icon" width="150" height="150">

## Features

- **Login and Registration:** Users can log in or register to access the app.
- **Food Categories:** View food items by category (All, Beverages, Snacks, Main Course, Desserts).
- **Food Details:** View detailed information about a selected food item and adjust the quantity.
- **Order Management:** View and manage current orders, with options to cancel if the status is **Available**.
- **Payment:** Complete orders using credit card payment.
- **Theme Switching:** Toggle between dark and light modes.
- **Unique App Icon:** Custom-designed icon for branding.

## Folder Structure

```plaintext
lib/
├── components/
│   ├── my_button.dart
│   ├── my_drawer.dart
│   ├── my_drawer_title.dart
│   └── my_textfield.dart
├── pages/
│   ├── FoodDetails_page.dart
│   ├── home_page.dart
│   ├── login_page.dart
│   ├── my_orders_page.dart
│   ├── payment_page.dart
│   ├── privacy_policy_page.dart
│   ├── register_page.dart
│   └── setting_page.dart
├── services/
│   ├── auth/
│   │   ├── auth_gate.dart
│   │   ├── auth_services.dart
│   │   └── login_or_register.dart
│   └── database/
│       ├── database.dart
│       └── payment_service.dart
├── themes/
│   ├── dark_mode.dart
│   ├── light_mode.dart
│   └── theme_provider.dart
├── main.dart
├── firebase_options.dart
├── session_manager.dart
└── timeout_manager.dart
```

## Dependencies

```yaml
dependencies:
  firebase_core: ^3.4.1
  provider: ^6.1.2
  firebase_storage: ^12.2.0
  animated_splash_screen: ^1.3.0
  lottie: ^3.1.2
  image_picker: ^1.1.2
  fluttertoast: ^8.2.8
  firebase_auth: ^5.2.0
  cloud_firestore: ^5.4.1
  random_string: ^2.3.1
  intl: ^0.19.0
  url_launcher: ^6.3.0
  flutter_credit_card: ^4.0.1
  rename_app: ^1.6.1
  cupertino_icons: ^1.0.6
```

## How to Run

1. Clone the repository: 
   ```bash
   git clone https://github.com/<your-username>/SLTC-Foodie.git
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Configure Firebase by adding your `google-services.json` for Android and `GoogleService-Info.plist` for iOS.
4. Run the app:
   ```bash
   flutter run
   ```

## Screenshots

### Login Page

<img src="https://github.com/sahan026/images/blob/main/SLTC_login_page.jpg" alt="Login Page" width="250" height="500">

### Home Page

<img src="https://github.com/sahan026/images/blob/main/homepage.jpg" alt="Login Page" width="250" height="500">

### Food Details Page

<img src="https://github.com/sahan026/images/blob/main/SLTC_login_page.jpg" alt="Login Page" width="250" height="500">

### Payment Page

<img src="https://github.com/sahan026/images/blob/main/paymentpage.jpg" alt="Login Page" width="250" height="500">

### My order Page

<img src="https://github.com/sahan026/images/blob/main/myoderpage.jpg" alt="Login Page" width="250" height="500">

### Setting Page

<img src="https://github.com/sahan026/images/blob/main/SLTC_setting_page.jpg" alt="Login Page" width="250" height="500">



## Contact

For any inquiries, please reach out via email at: <sahanhansaja026@gmail.com>


