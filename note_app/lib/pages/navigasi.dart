import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:note_app/pages/add_page.dart';
import 'package:note_app/pages/halaman_note.dart';
import 'package:note_app/pages/riwayat_note.dart';
import 'package:note_app/database/note_database.dart'; // Import DatabaseCatatan

class NextPage extends StatefulWidget {
  final VoidCallback? refreshCallback;

  const NextPage({Key? key, this.refreshCallback}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  int _currentIndex = 0;
  String? _tempFolderName;
  final TextEditingController _folderNameController = TextEditingController();

  @override
  void dispose() {
    _folderNameController.dispose();
    super.dispose();
  }

  final List<Widget> _children = [
    CatatanPage(),
    addnote(),
    Riwayat(),
  ];

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width * 0.065;

    return Scaffold(
      backgroundColor: Color(0xFF35374B),
      body: _children[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFF35374B),
        buttonBackgroundColor: Color.fromRGBO(80, 114, 123, 1),
        color: Color.fromRGBO(80, 114, 123, 1),
        animationDuration: const Duration(milliseconds: 300),
        index: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            _showAddDialog(context);
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: <Widget>[
          Icon(Icons.text_snippet,
              size: iconSize,
              color: _currentIndex == 0 ? Color(0xFF78A083) : Color(0xFF35374B)),
          Icon(Icons.add,
              size: iconSize,
              color: _currentIndex == 1 ? Color(0xFF78A083) : Color(0xFF35374B)),
          Icon(Icons.history,
              size: iconSize,
              color: _currentIndex == 2 ? Color(0xFF78A083) : Color(0xFF35374B)),
        ],
      ),
    );
  }

  _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF35374B),
          contentPadding: EdgeInsets.zero,
          content: Container(
            decoration: BoxDecoration(
              color: Color(0xFF35374B),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF50727B),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Masukkan Nama Folder          ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF35374B),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: _folderNameController,
                          decoration: InputDecoration(
                            hintText: "",
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Color(0xFF50727B),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                _tempFolderName = _folderNameController.text;
                                print('Nama Folder: $_tempFolderName');

                                // Menyimpan folder ke database
                                await DatabaseCatatan.instance.createFolder(_tempFolderName!);

                                // Panggil callback untuk memperbarui CatatanPage
                                widget.refreshCallback?.call();

                                Navigator.of(context).pop();
                              },
                              child: Text('Simpan'),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(Color(0xFF50727B)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
