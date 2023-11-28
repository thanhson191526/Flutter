import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Cài đặt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Ngôn ngữ'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ứng dụng chỉ sử dụng Tiếng Việt'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: isNotificationEnabled
                  ? const Icon(Icons.notifications)
                  : const Icon(Icons.notifications_off),
              title: Text(isNotificationEnabled
                  ? 'Thông báo: Đang bật'
                  : 'Thông báo: Đã tắt'),
              onTap: () {
                setState(() {
                  isNotificationEnabled = !isNotificationEnabled;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: isNotificationEnabled
                        ? const Text('Thông báo đã được bật')
                        : const Text('Thông báo đã được tắt'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Bảo mật'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tính năng bảo mật đang được nâng cấp '),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
