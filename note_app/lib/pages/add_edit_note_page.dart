import 'package:flutter/material.dart';
import 'package:note_app/database/note_database.dart';

class AddEditNotePage extends StatefulWidget {
  final int folderId;

  AddEditNotePage({required this.folderId});

  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'), // Judul AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title'), // Label untuk judul
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter title',
              ),
            ),
            SizedBox(height: 16),
            Text('Description'), // Label untuk deskripsi
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter description',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk menyimpan catatan
                _saveNote();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

 void _saveNote() async {
  final title = _titleController.text.trim();
  final description = _descriptionController.text.trim();

  // Pastikan judul dan deskripsi tidak kosong sebelum menyimpan
  if (title.isNotEmpty && description.isNotEmpty) {
    try {
      // Memanggil method createNote dari DatabaseCatatan untuk menyimpan catatan
      await DatabaseCatatan.instance.createNote(title, description, DateTime.now().toIso8601String(), widget.folderId);
      
      // Menampilkan pesan berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Note saved successfully')),
      );

      // Kembali ke halaman sebelumnya setelah menyimpan catatan
      Navigator.pop(context);
    } catch (e) {
      // Menampilkan pesan kesalahan jika gagal menyimpan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save note')),
      );
    }
  } else {
    // Tampilkan pesan kesalahan jika judul atau deskripsi kosong
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Title and description cannot be empty')),
    );
  }
}

}
