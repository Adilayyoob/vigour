// ignore_for_file: file_names,

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vigour/models/doctorVisitReminderModel.dart';
import 'package:vigour/models/documentUploadAreaModel.dart';
import 'package:vigour/models/medicineReminderModel.dart';

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

    return await openDatabase(path, version: 3, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    await db.execute('''
    CREATE TABLE $tableDocument (
      ${documentField.id} $idType,
      ${documentField.title} $textType,
      ${documentField.date} $textType,
      ${documentField.imgURL} $textType
    )
    
    ''');

    await db.execute('''
    CREATE TABLE $tableDoctor (
      ${doctorField.id} $idType,
      ${doctorField.name} $textType,
      ${doctorField.date} $textType,
      ${doctorField.time} $textType,
      ${doctorField.location} $textType,
      ${doctorField.status} $boolType
    )
    
    ''');

    await db.execute('''
    CREATE TABLE $tableMedicine (
      ${medicineField.id} $idType,
      ${medicineField.medicineName} $textType,
      ${medicineField.genericName} $textType,
      ${medicineField.brandName} $textType,
      ${medicineField.medicineType} $textType,
      ${medicineField.unit} $textType,
      ${medicineField.dose} $textType,
      ${medicineField.date} $textType,
      ${medicineField.time} $textType,
      ${medicineField.colour} $textType,
      ${medicineField.status} $boolType
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

//for DoctorVisitReminder
  Future<DoctorVisitReminderModel> createDoctor(
      DoctorVisitReminderModel doctor) async {
    final db = await instance.database;

    final id = await db.insert(tableDoctor, doctor.toJson());
    return doctor.copy(id: id);
  }

  Future<DoctorVisitReminderModel> readDoctor(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableDoctor,
      columns: doctorField.values,
      where: '${doctorField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DoctorVisitReminderModel.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<DoctorVisitReminderModel>> readAllDoctor() async {
    final db = await instance.database;
    final orderBy = '${doctorField.date} ASC';
    final result = await db.query(tableDoctor, orderBy: orderBy);
    return result
        .map((json) => DoctorVisitReminderModel.fromJson(json))
        .toList();
  }

  Future<int> updateDoctor(DoctorVisitReminderModel doctor) async {
    final db = await instance.database;

    return db.update(tableDoctor, doctor.toJson(),
        where: '${doctorField.id} = ?', whereArgs: [doctor.id]);
  }

  Future<int> deleteDoctor(int id) async {
    final db = await instance.database;
    return await db
        .delete(tableDoctor, where: '${doctorField.id} = ?', whereArgs: [id]);
  }

  Future closeDoctor() async {
    final db = await instance.database;

    db.close();
  }


//for medicineReminder
  Future<medicineReminderModel> createMedicine(
      medicineReminderModel medicine) async {
    final db = await instance.database;

    final id = await db.insert(tableMedicine, medicine.toJson());
    return medicine.copy(id: id);
  }

  Future<medicineReminderModel> readMedicine(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMedicine,
      columns: medicineField.values,
      where: '${medicineField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return medicineReminderModel.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<medicineReminderModel>> readAllMedicine() async {
    final db = await instance.database;
    final orderBy = '${medicineField.date} ASC';
    final result = await db.query(tableMedicine, orderBy: orderBy);
    return result
        .map((json) => medicineReminderModel.fromJson(json))
        .toList();
  }

  Future<int> updateMedicine(medicineReminderModel medicine) async {
    final db = await instance.database;

    return db.update(tableMedicine, medicine.toJson(),
        where: '${medicineField.id} = ?', whereArgs: [medicine.id]);
  }

  Future<int> deleteMedicine(int id) async {
    final db = await instance.database;
    return await db
        .delete(tableMedicine, where: '${medicineField.id} = ?', whereArgs: [id]);
  }

  Future closeMedicine() async {
    final db = await instance.database;

    db.close();
  }
}
