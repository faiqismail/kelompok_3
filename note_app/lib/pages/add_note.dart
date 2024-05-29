import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/database/note_database.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';


class AddEditNotePage extends StatefulWidget {
  const AddEditNotePage({Key? key, this.note, required this.folderId})
      : super(key: key);
  final Note? note;
  final int folderId;

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF78A083),
        automaticallyImplyLeading: false,
        toolbarHeight: 20,
      ),
      body: Container(
         color: themeProvider.isDarkMode ? const Color.fromARGB(255, 30, 30, 30) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      'Tambah Catatan',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF78A083),
                      ),
                    ),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        style: TextStyle(
                          color: _titleController.text.isEmpty
                              ? Color.fromARGB(255, 255, 255, 255)
                              : Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Judul',
                          hintStyle: TextStyle(color: Color(0xFFFFFFFF)),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 7),
              Card(
                color: Color(0xFF78A083),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _descriptionController,
                        style: TextStyle(
                          color: _descriptionController.text.isEmpty
                              ? Color(0xFFFFFFFF)
                              : Colors.white,
                        ),
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Ketikan Sesuatu',
                          hintStyle: TextStyle(color: Color(0xFFFFFFFF)),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  void _saveNote() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty) {
      try {
        await DatabaseCatatan.instance.createNote(
          title,
          description,
          DateTime.now().toIso8601String(),
          widget.folderId,
        );
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Catatan berhasil ditambahkan'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        print('Failed to save note: $e');
      }
    } else {
      print('Title and description cannot be empty');
    }
  }
}
