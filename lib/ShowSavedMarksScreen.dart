import 'package:flutter/material.dart';
import 'UserDataManager.dart';

class ShowSavedMarksScreen extends StatefulWidget {
  final String loggedInUsername;

  ShowSavedMarksScreen(this.loggedInUsername);

  @override
  _ShowSavedMarksScreenState createState() => _ShowSavedMarksScreenState();
}

class _ShowSavedMarksScreenState extends State<ShowSavedMarksScreen> {
  List<double> savedMarks = [];

  @override
  void initState() {
    super.initState();
    getSavedMarks();
  }

  void getSavedMarks() async {
    List<UserAccount> accounts = await UserDataManager.getUserData();
    int index = accounts
        .indexWhere((account) => account.username == widget.loggedInUsername);

    if (index != -1) {
      setState(() {
        savedMarks = accounts[index].marks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Danh sách điểm đã lưu'),
      ),
      body: savedMarks.isEmpty
          ? Center(
              child: Text('Không có điểm nào được lưu'),
            )
          : ListView.builder(
              itemCount: savedMarks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Điểm ${index + 1}: ${savedMarks[index]}'),
                );
              },
            ),
    );
  }
}
