import 'package:flutter/material.dart';
import 'package:note_app/database/note_database.dart'; // Import DatabaseCatatan
import 'package:note_app/models/note.dart'; // Import Folder model
import 'package:note_app/pages/halaman_catatan.dart'; // Import MahasiswaDetailPage

class CatatanPage extends StatefulWidget {
  final VoidCallback? refreshCallback;

  CatatanPage({this.refreshCallback});

  @override
  _CatatanPageState createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage> {
  late List<Folder>? _folders;
  var _isLoading = false;

  Future<void> _refreshFolders() async {
    setState(() {
      _isLoading = true;
    });

    _folders = await DatabaseCatatan.instance.getAllFolders();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshFolders();
  }

  _showAddDialog(BuildContext context, Folder folder) {
    TextEditingController _folderNameController = TextEditingController(text: folder.namaFolder);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF35374B),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: 400,
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
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Edit Folder            ',
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
                            hintText: "Nama Folder",
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Color(0xFF50727B),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                if (folder.folderId != null) {
                                  await DatabaseCatatan.instance.deleteFolder(folder.folderId!);
                                  widget.refreshCallback?.call();
                                  Navigator.of(context).pop();
                                  _refreshFolders();
                                }
                              },
                              child: Text('Hapus'),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              ),
                            ),
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () async {
                                String updatedFolderName = _folderNameController.text;
                                if (folder.folderId != null) {
                                  await DatabaseCatatan.instance.updateFolder(folder.folderId!, updatedFolderName);
                                  widget.refreshCallback?.call();
                                  Navigator.of(context).pop();
                                  _refreshFolders();
                                }
                              },
                              child: Text('Selesai'),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF50727B)),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF35374B),
      body: RefreshIndicator(
        onRefresh: _refreshFolders,
        child: Container(
          width: 430,
          height: 932,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFF35374B)),
          child: Stack(
            children: [
              Positioned(
                left: -4,
                top: 0,
                child: Container(
                  width: 437,
                  height: 58,
                  decoration: BoxDecoration(color: Color(0xFF344955)),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 391.94,
                        top: 22.85,
                        child: Container(
                          width: 28.35,
                          height: 14.94,
                          child: Stack(
                            children: [
                              // Child stack content here
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 140,
                top: 85,
                child: SizedBox(
                  width: 125,
                  height: 28,
                  child: Text(
                    'Folder',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF78A083),
                      fontSize: 30,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0.02,
                      letterSpacing: -0.24,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 80,
                right: 20,
                bottom: 20,
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _folders == null || _folders!.isEmpty
                        ? Center(child: Text('Data Folder Kosong!'))
                        : ListView.builder(
                            itemCount: _folders!.length,
                            itemBuilder: (context, index) {
                              final folder = _folders![index];
                              return GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HalamanCatatan(folder: folder),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 50,
                                  height: 86,
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF344955),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ' ${folder.namaFolder}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF78A083),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            FutureBuilder<int>(
                                              future: DatabaseCatatan.instance.countNotesInFolder(folder.folderId!),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.done) {
                                                  if (snapshot.hasError) {
                                                    return Text(
                                                      'Error',
                                                      style: TextStyle(color: Colors.red),
                                                    );
                                                  } else {
                                                    return Text(
                                                      '${snapshot.data} Catatan',
                                                      style: TextStyle(color: Colors.grey),
                                                    );
                                                  }
                                                } else {
                                                  return CircularProgressIndicator();
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.menu, color: Color(0xFF78A083)),
                                        onPressed: () {
                                          _showAddDialog(context, folder);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
