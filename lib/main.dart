import 'dart:math';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excite OTP Welcome Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhoneNumberScreen(),
    );
  }
}

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  String selectedCountryCode = '+260';
  final TextEditingController phoneNumberController = TextEditingController();
  String generatedOTP = ''; // Store the generated OTP here

  Future<void> sendOTP() async {
    final apiUrl = Uri.parse('https://gateway.excitesms.tech/api/v3/sms/send');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 1|3aOFpH9uOQjQx5s1Z1niX2mjpuJXXDGITj6r2V8m',
    };

    generatedOTP = generateOTP(); // Generate the OTP

    final payload = {
      'recipient': '$selectedCountryCode${phoneNumberController.text}',
      'sender_id': 'ExciteSMS',
      'message': 'Your OTP is: $generatedOTP', // Use the generated OTP
    };

    final response =
        await http.post(apiUrl, headers: headers, body: jsonEncode(payload));

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OTPVerificationScreen(generatedOTP: generatedOTP),
        ),
      );
    } else {
      // Handle error
    }
  }

  String generateOTP() {
    // Generate a 6-digit OTP
    return (100000 + Random().nextInt(900000)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excite Phone Number Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CountryCodePicker(
              onChanged: (countryCode) {
                setState(() {
                  selectedCountryCode = countryCode.dialCode!;
                });
              },
              initialSelection: 'ZM',
              favorite: ['+260'],
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Enter Phone Number',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                sendOTP();
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class OTPVerificationScreen extends StatefulWidget {
  final String
      generatedOTP; // Pass the generated OTP to the verification screen

  OTPVerificationScreen({required this.generatedOTP});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController otpController = TextEditingController();

  Future<void> verifyOTP(String enteredOTP) async {
    final expectedOTP = widget.generatedOTP; // Use the generated OTP from props

    if (enteredOTP == expectedOTP) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );
    } else {
      // Handle OTP verification failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EXciteOTP Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                verifyOTP(otpController.text);
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome ExciteSMS!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(
                    context,
                    ModalRoute.withName(
                        '/')); // Go back to the phone number selection screen
              },
              child: Text('Back to Phone Number Selection'),
            ),
          ],
        ),
      ),
    );
  }
}
