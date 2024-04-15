import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:note_app/models/note.dart';

class DatabaseCatatan {
  static final DatabaseCatatan instance = DatabaseCatatan._init();

  static Database? _database;

  DatabaseCatatan._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('catatan.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    final String sqlFolders = '''
      CREATE TABLE folders(
        folder_id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_folder TEXT NOT NULL
      )
    ''';
    await db.execute(sqlFolders);

    final String sqlNotes = '''
      CREATE TABLE notes(
        note_id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT NOT NULL,
        isi TEXT NOT NULL,
        time TEXT NOT NULL,
        folder_id INTEGER,
        FOREIGN KEY (folder_id) REFERENCES folders(folder_id)
      )
    ''';
    await db.execute(sqlNotes);
  }

  Future<int> createFolder(String namaFolder) async {
  try {
    final db = await database;
    final id = await db.insert('folders', {'nama_folder': namaFolder});
    print('ID Folder yang disimpan: $id');  // Log ID folder yang berhasil disimpan
    return id;
  } catch (e) {
    print('Error createFolder: $e');  // Log error jika terjadi kesalahan
    throw e;
  }
}


  Future<int> createNote(String judul, String isi, String time, int folderId) async {
    final db = await database;
    final id = await db.insert('notes', {
      'judul': judul,
      'isi': isi,
      'time': time,
      'folder_id': folderId
    });
    return id;
  }

Future<List<Folder>> getAllFolders() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(tableFolders);
  return List.generate(maps.length, (i) {
    return Folder(
      folderId: maps[i]['folder_id'],
      namaFolder: maps[i]['nama_folder'],
    );
  });
}



  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await database;
    final result = await db.query('notes');
    return result;
  }

  
  Future<int> updateFolder(int folderId, String namaFolder) async {
    final db = await database;
    return await db.update(
      'folders',
      {'nama_folder': namaFolder},
      where: 'folder_id = ?',
      whereArgs: [folderId],
    );
  }

  Future<int> updateNote(int noteId, String judul, String isi, String time, int folderId) async {
    final db = await database;
    return await db.update(
      'notes',
      {
        'judul': judul,
        'isi': isi,
        'time': time,
        'folder_id': folderId
      },
      where: 'note_id = ?',
      whereArgs: [noteId],
    );
  }

  Future<void> deleteFolder(int folderId) async {
    final db = await database;
    await db.delete('folders', where: 'folder_id = ?', whereArgs: [folderId]);
  }

  Future<void> deleteNote(int noteId) async {
    final db = await database;
    await db.delete('notes', where: 'note_id = ?', whereArgs: [noteId]);
  }
  Future<int> getNoteCountInFolder(int folderId) async {
  final db = await instance.database;
  final result = await db.rawQuery('''
    SELECT COUNT(*) FROM notes WHERE folder_id = ?
  ''', [folderId]);
  return Sqflite.firstIntValue(result) ?? 0;
}
Future<int> countNotesInFolder(int folderId) async {
  try {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT COUNT(*) FROM notes WHERE folder_id = ?
    ''', [folderId]);
    return Sqflite.firstIntValue(result) ?? 0;
  } catch (e) {
    print('Error countNotesInFolder: $e');
    throw e;
  }
}
Future<List<Note>> getNotesByFolder(int folderId) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('notes',
      where: 'folder_id = ?',
      whereArgs: [folderId]);

  return List.generate(maps.length, (i) {
    return Note(
      noteId: maps[i][NoteFields.noteId],
      judul: maps[i][NoteFields.judul],
      isi: maps[i][NoteFields.isi],
      time: DateTime.parse(maps[i][NoteFields.time]),
      folderId: maps[i][NoteFields.folderId],
    );
  });
}
   Future<int> _addNote(String title, String description, int folderId) async {
    final currentTime = DateTime.now().toIso8601String(); // Menggunakan waktu saat ini sebagai waktu catatan
    final newNoteId = await createNote(
      title,
      description,
      currentTime,
      folderId,
    );
    print('Catatan baru ditambahkan dengan ID: $newNoteId');
    return newNoteId;
  }

  Future<void> _updateNote(
      int noteId, String title, String description, int folderId) async {
    final currentTime = DateTime.now().toIso8601String(); // Menggunakan waktu saat ini sebagai waktu catatan
    await updateNote(
      noteId,
      title,
      description,
      currentTime,
      folderId,
    );
  }

}
