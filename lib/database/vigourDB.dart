// ignore_for_file: file_names,


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vigour/models/documentUploadAreaModel.dart';

class VigourDatabase {
  static final VigourDatabase instance = VigourDatabase._init();
  static Database? _database;

  VigourDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('vigour.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE $tableDocument (
      ${documentField.id} $idType,
      ${documentField.title} $textType,
      ${documentField.date} $textType,
      ${documentField.imgURL} $textType
    )
    
    ''');
  }

  Future<DocumentUploadAreaModel> create(
      DocumentUploadAreaModel document) async {
    final db = await instance.database;

    final id = await db.insert(tableDocument, document.toJson());
    return document.copy(id: id);
  }

  Future<DocumentUploadAreaModel> readDocument(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableDocument,
      columns: documentField.values,
      where: '${documentField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DocumentUploadAreaModel.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<DocumentUploadAreaModel>> readAllDocument() async {
    final db = await instance.database;
    final orderBy = '${documentField.date} ASC';
    final result = await db.query(tableDocument, orderBy: orderBy);
    return result
        .map((json) => DocumentUploadAreaModel.fromJson(json))
        .toList();
  }

  Future<int> update(DocumentUploadAreaModel document) async {
    final db = await instance.database;

    return db.update(tableDocument, document.toJson(),
        where: '${documentField.id} = ?', whereArgs: [document.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(tableDocument,
        where: '${documentField.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
