
import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encryption;
import 'package:flutter/material.dart';
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
  late SharedPreferences sharedPreferences;
  static const String privateKey = "gonroyxbblhqiapkpbxdmktprrrueqsc";
  String resultText = "";
  String plainText = "";

  @override
  void initState() {
    super.initState();
  }

  void encrypt(String plainText) async {
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

  void decrypt(String encryptedText) {
    final key = encryption.Key.fromUtf8(privateKey);
    final iv = encryption.IV.fromLength(16);

    final encrypter = encryption.Encrypter(encryption.AES(key));
    final encrypted = encryption.Encrypted.from64(encryptedText);

    setState(() {
      resultText = encrypter.decrypt(encrypted, iv: iv);
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
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide()
                  )
                ),
                maxLines: 1,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    plainText = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      encrypt(plainText);
                    },
                    child: const Text("Encrypt"),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final String? encryptedText = sharedPreferences.getString("EncryptedText");

                      if (encryptedText == null) return;

                      print("Hello Decrypt: $encryptedText");

                      decrypt(encryptedText);
                    }, 
                    child: const Text("Decrypt")
                  )
                ],
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