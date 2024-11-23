import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'biodata_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'biodata.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE biodata (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            nim TEXT,
            alamat TEXT,
            hobi TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertBiodata(Biodata biodata) async {
    final db = await database;
    return await db.insert('biodata', biodata.toMap());
  }

  Future<List<Biodata>> getBiodataList() async {
    final db = await database;
    final maps = await db.query('biodata');
    return List.generate(maps.length, (i) => Biodata.fromMap(maps[i]));
  }
}
