// màn hình Trợ giúp
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Trợ giúp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.contact_support),
              title: const Text('Liên hệ hỗ trợ'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thông tin hỗ trợ'),
                      content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email hỗ trợ: support15@gmail.com'),
                          SizedBox(height: 10),
                          Text('Hotline hỗ trợ: 1900 0206'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Đóng',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Câu hỏi thường gặp'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const SimpleDialog(
                      title: Text('Câu hỏi thường gặp'),
                      children: [
                        ListTile(
                          title: Text(
                              '1. Làm thế nào để đổi mật khẩu của tài khoản?'),
                          subtitle: Text(
                              'Để đổi mật khẩu, hãy vào màn hình "Thông tin tài khoản".\nNhấn vào nút "Đổi mật khẩu" và nhập đúng mật khẩu hiện tại sau đó nhập mật khẩu mới vào hộp thoại hiện ra.'),
                        ),
                        ListTile(
                          title: Text(
                              '2. Tôi làm thế nào để xem điểm trung bình của một môn học?'),
                          subtitle: Text(
                              'Mở màn hình "Chi tiết môn học".\nNhập điểm số cho các phần khác nhau như miệng, giữa kỳ, cuối kỳ.\nHệ thống sẽ tính tự động và hiển thị điểm trung bình của môn.'),
                        ),
                        ListTile(
                          title: Text(
                              '3. Làm thế nào để đăng xuất khỏi tài khoản?'),
                          subtitle: Text(
                              'Trên màn hình chính, vào menu hoặc góc trên cùng.\nChọn "Đăng xuất"'),
                        ),
                        ListTile(
                          title: Text(
                              '4. Tôi cần hỗ trợ kỹ thuật, làm thế nào để liên hệ với bộ phận hỗ trợ?'),
                          subtitle: Text(
                              'Truy cập màn hình "Trợ giúp" trong menu.\nChọn phương thức liên hệ như gọi điện, gửi email.'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            const Divider(),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('Hướng dẫn sử dụng'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Hướng dẫn sử dụng'),
                      content: const Text(
                          'Ứng dụng Quản lý Điểm giúp bạn quản lý và tính điểm môn học dễ dàng.\n\n1. Đăng nhập hoặc Đăng ký tài khoản.\n2. Truy cập thông tin tài khoản và cài đặt qua menu Drawer.\n3. Chọn một môn học từ danh sách để nhập và tính điểm.\n4. Dữ liệu điểm số sẽ tự động lưu khi bạn nhập điểm.\n5. Để đăng xuất, chọn "Đăng xuất" từ menu Drawer.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Đóng',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            // Thêm các mục thông tin khác tại đây nếu cần
          ],
        ),
      ),
    );
  }
}
