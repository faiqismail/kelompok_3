import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/database/note_database.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
class EditNotePage extends StatefulWidget {
  const EditNotePage({Key? key, required this.note}) : super(key: key);
  final Note? note;

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.judul ?? '');
    _descriptionController =
        TextEditingController(text: widget.note?.isi ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF78A083),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 20,
      ),
      body: Container(
        color: themeProvider.isDarkMode ? Color.fromARGB(255, 30, 30, 30) : Colors.white,

       
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color(0xFF78A083),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      '            Edit Catatan',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF78A083),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: _saveNote,
                      icon: Icon(
                        Icons.check,
                        color: Color(0xFF78A083),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                color: Color(0xFF78A083),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
  controller: _titleController,
  style: TextStyle(
    color: Colors.white, // Tetapkan warna teks putih
  ),
  decoration: InputDecoration(
    hintText: 'Enter title',
    hintStyle: TextStyle(
      color: Colors.white, // Tetapkan warna teks putih
    ),
    border: InputBorder.none,
  ),
),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(
                color: Color.fromARGB(255, 160, 200, 172),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 5,
                        style: TextStyle(
    color: Colors.white, // Tetapkan warna teks putih
  ),
                        decoration: InputDecoration(
                          hintText: 'Enter description',
                          hintStyle: TextStyle(
                               color: Colors.white,),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _saveNote() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final folderId = widget.note!.folderId;

    if (title.isNotEmpty && description.isNotEmpty) {
      try {
        await DatabaseCatatan.instance.updateNote(
          widget.note!.noteId!,
          title,
          description,
          folderId,
        );

        Navigator.pop(context);

        // Tampilkan notifikasi bahwa catatan berhasil diedit
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Catatan berhasil diedit'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        print('Failed to update note: $e');
      }
    } else {
      print('Title and description cannot be empty');
    }
  }

  void _deleteNote() async {
    try {
      await DatabaseCatatan.instance
          .deleteNotePermanently(widget.note!.noteId!);

      Navigator.pop(context);

      // Tampilkan notifikasi bahwa catatan berhasil dihapus
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Catatan berhasil dihapus'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print('Failed to delete note: $e');
    }
  }
}
