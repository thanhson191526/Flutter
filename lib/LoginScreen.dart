import 'package:flutter/material.dart';
import 'UserDataManager.dart';
import 'RegisterScreen.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Ứng dụng quản lý điểm'),
      ),
      body: Center(
        child: Padding(
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
                      Icons.login,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Đăng nhập hệ thống',
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
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Tên đăng nhập',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Nhập mật khẩu',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Mật khẩu',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                obscureText: true,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  String enteredUsername = usernameController.text;
                  String enteredPassword = passwordController.text;

                  if (enteredUsername.isNotEmpty &&
                      enteredPassword.isNotEmpty) {
                    List<UserAccount> accounts =
                        await UserDataManager.getUserData();
                    bool isLoggedIn = accounts.any((account) =>
                        account.username == enteredUsername &&
                        account.password == enteredPassword);

                    if (isLoggedIn) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(enteredUsername),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đăng nhập tài khoản thành công'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Sai tài khoản hoặc mật khẩu. Xin thử lại!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Vui lòng điền đầy đủ thông tin đăng nhập'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
              TextButton(
                style: TextButton.styleFrom(primary: Colors.black),
                child: const Text(
                  'Chưa có tài khoản? Đăng ký ngay',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
