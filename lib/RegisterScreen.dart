import 'package:flutter/material.dart';
import 'UserDataManager.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Hệ thống nhập điểm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.app_registration_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Đăng ký',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: 'Nhập tên đăng nhập',
                border: OutlineInputBorder(),
                labelText: 'Tên đăng nhập',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Nhập mật khẩu',
                border: OutlineInputBorder(),
                labelText: 'Mật khẩu',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                hintText: 'Xác nhận mật khẩu',
                border: OutlineInputBorder(),
                labelText: 'Xác nhận mật khẩu',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child:
                  const Text('Đăng ký', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                String username = usernameController.text;
                String password = passwordController.text;
                String confirmPassword = confirmPasswordController.text;

                if (password == confirmPassword) {
                  List<UserAccount> accounts =
                      await UserDataManager.getUserData();
                  accounts.add(UserAccount(
                    username: username,
                    password: password,
                  ));

                  await UserDataManager.saveUserData(accounts);

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đăng ký tài khoản thành công'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Mật khẩu xác nhận không khớp'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
