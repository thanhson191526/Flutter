import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataManager {
  static final String _accountsKey = 'accounts';

  static Future<void> saveUserData(List<UserAccount> accounts) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> accountsJson = accounts
        .map((account) => {
              'username': account.username,
              'password': account.password,
              'marks': account.marks,
            })
        .toList();
    String encodedAccounts = jsonEncode(accountsJson);
    await prefs.setString(_accountsKey, encodedAccounts);
    print('Data saved!');
  }

  static Future<List<UserAccount>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountsJson = prefs.getString(_accountsKey);

    if (accountsJson != null && accountsJson.isNotEmpty) {
      List<dynamic> decodedAccounts = jsonDecode(accountsJson);
      List<UserAccount> accounts = decodedAccounts.map((account) {
        return UserAccount(
          username: account['username'],
          password: account['password'],
          marks: List<double>.from(account['marks']),
        );
      }).toList();
      return accounts;
    }

    return [];
  }
}

//trường dữ liệu mới cho từng tài khoản để lưu thông tin điểm số
class UserAccount {
  String username;
  String password;
  List<double> marks; //  trường lưu điểm số

  UserAccount({
    required this.username,
    required this.password,
    this.marks = const [], // Khởi tạo trường điểm số là một mảng rỗng
  });
}
