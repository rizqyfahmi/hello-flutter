import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_flutter/main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.offNamed("/main");
              }, 
              child: const Text("Login")
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Note that we must use GetMaterialApp
                Get.snackbar(
                  "Hello Title", 
                  "Hello Message",
                  snackPosition: SnackPosition.BOTTOM,
                  snackStyle: SnackStyle.FLOATING,
                );
              },
              child: const Text("Open SnackBar")
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {
                    Get.defaultDialog(
                      title: "Default Dialog",
                      content: const Text("Hello from default dialog"),
                      textCancel: "Close",
                      textConfirm: "Save",
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        Get.back();
                      }
                    );
                  }, 
                  child: const Text("Default Dialog")
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: () {
                    Get.dialog(
                      const AlertDialog(
                        content: Text("Hello Dialog"),
                      )
                    );
                  }, 
                  child: const Text("Dialog")
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: () {
                    Get.generalDialog(
                      barrierLabel: "Close",
                      barrierDismissible: true,
                      pageBuilder: (_, __, ___) => const AlertDialog(
                        content: Text("Hello Dialog"),
                      )
                    );
                  }, 
                  child: const Text("General Dialog")
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}