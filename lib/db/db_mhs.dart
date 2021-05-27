import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts_akb/models/mahasiswa.dart';

class MhsDatabase {
  static final MhsDatabase instance = MhsDatabase._init();

  static Database _database;

  MhsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('mhs.db');
    return _database;
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
    CREATE TABLE $tableMahasiswa (
      ${MahasiswaFields.id} $idType,
      ${MahasiswaFields.nim} $textType,
      ${MahasiswaFields.namaLengkap} $textType,
      ${MahasiswaFields.kelas} $textType,
      ${MahasiswaFields.prodi} $textType
    )
    ''');
  }

  Future<Mahasiswa> create(Mahasiswa mhs) async {
    final db = await instance.database;

    final id = await db.insert(tableMahasiswa, mhs.toJson());
    return mhs.copy(id: id);
  }

  Future<Mahasiswa> readMahasiswa(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMahasiswa,
      columns: MahasiswaFields.values,
      where: '${MahasiswaFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Mahasiswa.fromJson(maps.first);
    } else {
      throw Exception('ID $id Tidak Ditemukan');
    }
  }

  Future<List<Mahasiswa>> readAllMahasiswa() async {
    final db = await instance.database;
    final orderBy = '${MahasiswaFields.id} ASC';
    final result = await db.query(tableMahasiswa, orderBy: orderBy);
    return result.map((json) => Mahasiswa.fromJson(json)).toList();
  }

  Future<int> update(Mahasiswa mhs) async {
    final db = await instance.database;

    return db.update(
      tableMahasiswa,
      mhs.toJson(),
      where: '${MahasiswaFields.id} = ?',
      whereArgs: [mhs.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(tableMahasiswa,
        where: '${MahasiswaFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
