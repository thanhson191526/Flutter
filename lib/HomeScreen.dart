import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'SubjectDetailScreen.dart';
import 'ShowSavedMarksScreen.dart';
import 'drawer/AccountInfoScreen.dart';
import 'drawer/HelpScreen.dart';
import 'drawer/SettingsScreen.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> subjects = [
    'Toán',
    'Vật Lý',
    'Hóa',
    'Ngữ Văn',
    'Lịch Sử',
    'Địa Lí',
    'Sinh học',
    'Tiếng Anh',
    'Giáo dục công dân',
    'Công nghệ',
    'Giáo dục quốc phòng',
    'Giáo dục thể chất',
    'Tin học',
    'Môn tự chọn'
  ];
  final List<Color> subjectColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.cyan,
    Colors.amber,
    Colors.deepOrange,
    Colors.lightGreen,
    Colors.deepPurple,
  ];
  final List<IconData> bookIcons = [
    Icons.functions,
    Icons.lightbulb,
    Icons.science,
    Icons.library_books,
    Icons.chrome_reader_mode,
    Icons.nature,
    Icons.assignment,
    Icons.language,
    Icons.gavel,
    Icons.devices_other,
    Icons.security,
    Icons.directions_run,
    Icons.computer,
    Icons.library_add,
  ];

  final String
      loggedInUsername; // Thêm biến để lưu thông tin người dùng đăng nhập

  HomeScreen(this.loggedInUsername); // Constructor nhận thông tin người dùng

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String loggedInUsername = ''; // Biến lưu tên người dùng đăng nhập

  @override
  void initState() {
    super.initState();
    loggedInUsername =
        widget.loggedInUsername; // Lấy tên người dùng từ constructor
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey, // Sử dụng key từ widget
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Trang chủ'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            widget._scaffoldKey.currentState!
                .openDrawer(); // Sử dụng key từ widget
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpScreen()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.6,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                loggedInUsername, // Hiển thị tên người dùng đã đăng nhập
                style: const TextStyle(color: Colors.white, fontSize: 35.0),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  loggedInUsername.isNotEmpty ? loggedInUsername[0] : '',
                  style: const TextStyle(fontSize: 40.0, color: Colors.grey),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.grey, // Màu của AppBar
              ),
              accountEmail: null,
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Thông tin tài khoản'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountInfoScreen(loggedInUsername),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Trợ giúp'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Cài đặt'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Đăng xuất'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Xác nhận đăng xuất'),
                      content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Đóng hộp thoại
                          },
                          child: const Text(
                            'Không',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Đăng xuất tài khoản thành công'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Text('Đồng ý'),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: widget.subjects.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            color: widget.subjectColors[index % widget.subjectColors.length],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubjectDetailScreen(
                      widget.subjects[index],
                      widget.loggedInUsername,
                    ),
                  ),
                );
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.bookIcons[index % widget.bookIcons.length],
                      size: 50.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.subjects[index],
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.list), // Icon cho nút
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ShowSavedMarksScreen(widget.loggedInUsername),
            ),
          );
        },
      ),
    );
  }
}
