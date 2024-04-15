import 'package:flutter/material.dart';
import 'package:note_app/database/note_database.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/pages/add_edit_note_page.dart';  // Import halaman AddEditNotePage

class HalamanCatatan extends StatelessWidget {
  final Folder folder;

  HalamanCatatan({required this.folder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(folder.namaFolder)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditNotePage(folderId: folder.folderId!),
                ),
              ).then((_) {
                // Refresh page after adding or updating note
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HalamanCatatan(folder: folder),
                  ),
                );
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Note>>(
        future: DatabaseCatatan.instance.getNotesByFolder(folder.folderId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error',
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              final notes = snapshot.data ?? [];
              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Card(
                    elevation: 2.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                     
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time: ${note.time.toString()}',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                        note.judul,
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                          SizedBox(height: 4.0),
                          Text(
                            note.isi,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
