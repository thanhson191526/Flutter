import 'package:flutter/material.dart';
import 'UserDataManager.dart';

class SubjectDetailScreen extends StatefulWidget {
  final String subjectName;
  final String loggedInUsername;

  SubjectDetailScreen(this.subjectName, this.loggedInUsername);

  @override
  _SubjectDetailScreenState createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  List<TextEditingController> mark15Controllers = [TextEditingController()];
  List<TextEditingController> markMidTermControllers = [
    TextEditingController()
  ];
  List<TextEditingController> markFinalTermControllers = [
    TextEditingController()
  ];

  double calculateAverage() {
    double totalMarks = 0.0;
    double totalWeights = 0.0;

    for (int i = 0; i < mark15Controllers.length; i++) {
      double mark15 = double.tryParse(mark15Controllers[i].text) ?? 0.0;
      totalMarks += mark15;
      totalWeights += 1; // Hệ số điểm 15 phút: 1
    }

    for (int i = 0; i < markMidTermControllers.length; i++) {
      double markMidTerm =
          double.tryParse(markMidTermControllers[i].text) ?? 0.0;
      totalMarks += markMidTerm * 2;
      totalWeights += 2; // Hệ số điểm giữa kỳ: 2
    }

    for (int i = 0; i < markFinalTermControllers.length; i++) {
      double markFinalTerm =
          double.tryParse(markFinalTermControllers[i].text) ?? 0.0;
      totalMarks += markFinalTerm * 3;
      totalWeights += 3; // Hệ số điểm cuối kỳ: 3
    }

    return totalMarks / totalWeights;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.subjectName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Điểm miệng, 15 phút (HS1)'),
                  for (int i = 0; i < mark15Controllers.length; i++)
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: mark15Controllers[i],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Nhập điểm 15 phút lần ${i + 1}',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              mark15Controllers.removeAt(i);
                            });
                          },
                        ),
                      ],
                    ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        mark15Controllers.add(TextEditingController());
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Điểm giữa kỳ (HS2)'),
                  for (int i = 0; i < markMidTermControllers.length; i++)
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: markMidTermControllers[i],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Nhập điểm giữa kỳ lần ${i + 1}',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              markMidTermControllers.removeAt(i);
                            });
                          },
                        ),
                      ],
                    ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        markMidTermControllers.add(TextEditingController());
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Điểm cuối kỳ (HS3)'),
                  for (int i = 0; i < markFinalTermControllers.length; i++)
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: markFinalTermControllers[i],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Nhập điểm cuối kỳ lần ${i + 1}',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              markFinalTermControllers.removeAt(i);
                            });
                          },
                        ),
                      ],
                    ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        markFinalTermControllers.add(TextEditingController());
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.save),
        onPressed: () async {
          double averageMark = calculateAverage();
          List<UserAccount> accounts = await UserDataManager.getUserData();

          int index = accounts.indexWhere(
              (account) => account.username == widget.loggedInUsername);

          if (index != -1) {
            accounts[index].marks.add(averageMark);
            await UserDataManager.saveUserData(accounts);

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Điểm trung bình'),
                  content: Text(
                    'Điểm trung bình: ${averageMark.toStringAsFixed(2)}',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Đóng'),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
