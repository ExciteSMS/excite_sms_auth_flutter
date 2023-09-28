# Flutter OTP Verification App with Excite SMS API

This is a Flutter mobile application that demonstrates OTP (One-Time Password) generation, SMS delivery using the Excite SMS API, and OTP verification. The app consists of three screens: Phone Number Selection, OTP Verification, and Welcome Screen.

![Flutter OTP Verification App](screenshot.png)

## Features

- Select a country code and enter your phone number to receive an OTP via SMS.
- Generate a random 6-digit OTP for verification.
- Send the OTP via the Excite SMS API.
- Verify the entered OTP with the generated OTP.
- Navigate between screens based on successful verification.

## Technologies Used

- Flutter: For building the mobile app.
- HTTP Package: For making API requests to the Excite SMS API.
- Country Code Picker: For selecting the country code.

## Getting Started

To get started with this application, follow these steps:

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/your-username/flutter-otp-verification.git
   cd flutter-otp-verification
    ```

2. Open the project in your Flutter development environment.

3. Replace `'YOUR_API_KEY_HERE'` in the `lib/main.dart` file of the `PhoneNumberScreen` class with your actual Excite SMS API key.

4. Run the Flutter app on a simulator or connected device:

   ```bash
   flutter run
   ```

5. Use the app to go through the phone number selection, OTP verification, and welcome screens.

## API Configuration

To use the Excite SMS API, replace `'YOUR_API_KEY_HERE'` in the `lib/main.dart` file of the `PhoneNumberScreen` class with your actual Excite SMS API key.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Excite SMS for providing the SMS gateway API.

---

Experience secure OTP generation, SMS delivery, and verification with the Flutter OTP Verification App!
