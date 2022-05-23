
import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encryption;
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController fieldController = TextEditingController();
  final LocalAuthentication localAuth = LocalAuthentication();
  late SharedPreferences sharedPreferences;
  static const String privateKey = "gonroyxbblhqiapkpbxdmktprrrueqsc";
  String resultText = "";
  String plainText = "";
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
  }

  void encrypt(String plainText) async {
    if (!isAuthenticated) {
      isAuthenticated = await authenticate();
    }

    if(!isAuthenticated) return;

    final key = encryption.Key.fromUtf8(privateKey);
    final iv = encryption.IV.fromLength(16);

    final encrypter = encryption.Encrypter(encryption.AES(key));
    final String result = encrypter.encrypt(plainText, iv: iv).base64;

    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("EncryptedText", result);

    setState(() {
      resultText = result;
    });
  }

  void decrypt(String encryptedText) async {

    if (!isAuthenticated) {
      isAuthenticated = await authenticate();
    }

    if (!isAuthenticated) return;

    final key = encryption.Key.fromUtf8(privateKey);
    final iv = encryption.IV.fromLength(16);

    final encrypter = encryption.Encrypter(encryption.AES(key));
    final encrypted = encryption.Encrypted.from64(encryptedText);

    setState(() {
      resultText = encrypter.decrypt(encrypted, iv: iv);
    });
  }

  Future<bool> authenticate() async {
    bool isBiometricSupported = await localAuth.isDeviceSupported();

    print("isBiometricSupported: $isBiometricSupported");

    final isAuthenticated = await localAuth.authenticate(
      localizedReason: "Authenticate with your biometrics",
      options: const AuthenticationOptions(
        biometricOnly: true,
        useErrorDialogs: true
      )
    );

    return isAuthenticated;
  }

  // Reset/logout authentication
  void reset() {
    sharedPreferences.clear();
    isAuthenticated = false;
    setState(() {
      fieldController.text = "";
      resultText = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Security"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide()
                  )
                ),
                maxLines: 1,
                controller: fieldController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: fieldController.value.text.isNotEmpty ? Colors.green : Colors.grey
                    ),
                    onPressed: () {
                      if (fieldController.value.text.isEmpty) return;
                      encrypt(fieldController.value.text);
                    },
                    child: const Text("Encrypt"),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: fieldController.value.text.isNotEmpty ? Colors.green : Colors.grey
                    ),
                    onPressed: () {
                      if (fieldController.value.text.isEmpty) return;
                      final String? encryptedText = sharedPreferences.getString("EncryptedText");

                      if (encryptedText == null) return;

                      print("Hello Decrypt: $encryptedText");

                      decrypt(encryptedText);
                    }, 
                    child: const Text("Decrypt")
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: fieldController.value.text.isNotEmpty ? Colors.green : Colors.grey
                    ),
                    onPressed: () {
                      reset();    
                    }, 
                    child: const Text("Reset")
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Result: $resultText",
                style: const TextStyle(
                  fontSize: 20
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}