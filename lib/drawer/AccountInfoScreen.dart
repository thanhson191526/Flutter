// màn hình thông tin tài khoản
import 'package:flutter/material.dart';
import '../UserDataManager.dart';

class AccountInfoScreen extends StatelessWidget {
  final String loggedInUsername;

  AccountInfoScreen(this.loggedInUsername);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Thông tin tài khoản'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 60.0,
              child: Text(
                loggedInUsername.isNotEmpty ? loggedInUsername[0] : '',
                style: const TextStyle(fontSize: 40.0, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Tên đăng nhập:',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              loggedInUsername,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _showChangePasswordDialog(context);
              },
              child: const Text('Đổi mật khẩu'),
              style: ElevatedButton.styleFrom(primary: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    String currentPassword = ''; // Mật khẩu hiện tại
    String newPassword = ''; // Mật khẩu mới

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Đổi mật khẩu'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu hiện tại',
                ),
                onChanged: (value) {
                  currentPassword =
                      value; // Lưu mật khẩu hiện tại từ người dùng nhập vào
                },
                obscureText: true,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu mới',
                ),
                onChanged: (value) {
                  newPassword =
                      value; // Lưu mật khẩu mới từ người dùng nhập vào
                },
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Đóng hộp thoại
              },
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                List<UserAccount> accounts =
                    await UserDataManager.getUserData();
                int index = accounts.indexWhere(
                  (account) => account.username == loggedInUsername,
                );

                if (index != -1 &&
                    accounts[index].password == currentPassword) {
                  accounts[index].password = newPassword;
                  await UserDataManager.saveUserData(accounts);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đổi mật khẩu thành công'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Mật khẩu hiện tại không chính xác'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text('Đổi mật khẩu'),
              style: ElevatedButton.styleFrom(primary: Colors.black),
            ),
          ],
        );
      },
    );
  }
}
