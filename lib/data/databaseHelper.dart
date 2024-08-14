import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('v12.gts.sqlite3.db');
    return _database!;
  }

  //*
  Future<List<Map<String, dynamic>>> getAllMadde() async {
    final db = await instance.database;
    return await db.query('madde');
  }

  //*
  Future<List<Map<String, dynamic>>> getMaddesNotInAtasozu() async {
    final db = await instance.database;
    return await db.rawQuery('''
    
  ''');
  }

  Future<List<Map<String, dynamic>>> getMaddesWithAnlamNotInAtasozu() async {
    final db = await instance.database;
    return await db.rawQuery('''
    SELECT m.*, a.*
    FROM madde m
    LEFT JOIN anlam a ON m.madde_id = a.madde_id
    WHERE m.madde_id NOT IN (SELECT madde_id FROM atasozu)
  ''');
  }

  Future<List<Map<String, dynamic>>>
      getMaddesWithAnlamNotInAtasozuonly() async {
    final db = await instance.database;
    return await db.rawQuery('''
      SELECT m.*, a.anlam
    FROM madde m
    LEFT JOIN anlam a ON m.madde_id = a.madde_id
    WHERE m.madde_id NOT IN (SELECT madde_id FROM atasozu)
    GROUP BY m.madde_id
  ''');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Check if the database exists
    final exists = await databaseExists(path);

    if (!exists) {
      // Copy from asset
      try {
        await Directory(dirname(path)).create(recursive: true);

        ByteData data = await rootBundle.load(join('assets', filePath));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        await File(path).writeAsBytes(bytes, flush: true);
      } catch (e) {
        print('Error copying database: $e');
      }
    }
    return await openDatabase(path);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  //!----------------------------------------------------------------------------------------------------------------
  static Future<Map<String, dynamic>> getWord(int id) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT 
      madde.madde, 
      GROUP_CONCAT(anlam.anlam, ' | ') AS anlamlar
    FROM 
      madde
    LEFT JOIN 
      anlam ON madde.madde_id = anlam.madde_id
    WHERE 
      madde.madde_id = ? 
    GROUP BY 
      madde.madde;
  ''', [id]);

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  static Future<Map<String, dynamic>> getWordLenght(int length) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT 
      madde.madde,      
      GROUP_CONCAT(anlam.anlam, ' | ') AS anlamlar
    FROM 
      madde
    LEFT JOIN 
      anlam ON madde.madde_id = anlam.madde_id
    WHERE 
      LENGTH(madde.madde) = ?
    GROUP BY madde.madde
    ORDER BY RANDOM()
    LIMIT 1;
  ''', [length]);

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  static Future<List<Map<String, dynamic>>> getWordDetails(String word) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT 
          madde.madde, 
          madde.birlesikler,
          madde.lisan,   
          madde.telaffuz,
          anlam.anlam, 
          anlam.anlam_sira,  
          ozellik.tam_adi AS ozellik_tam_adi,
          GROUP_CONCAT(ornek.ornek, ' | ') AS ornekler
      FROM 
          madde
      LEFT JOIN 
          anlam ON madde.madde_id = anlam.madde_id
      LEFT JOIN 
          anlam_ozellik ON anlam.anlam_id = anlam_ozellik.anlam_id
      LEFT JOIN 
          ozellik ON anlam_ozellik.ozellik_id = ozellik.ozellik_id
      LEFT JOIN 
          yazar ON anlam_ozellik.ozellik_id = yazar.yazar_id
      LEFT JOIN 
          ornek ON anlam.anlam_id = ornek.anlam_id
      WHERE 
          madde.madde COLLATE NOCASE = ?
      GROUP BY 
          madde.madde, 
          madde.birlesikler,
          madde.lisan,   
          madde.telaffuz,
          anlam.anlam, 
          anlam.anlam_sira,  
          ozellik.tam_adi
      ORDER BY 
          anlam.anlam_sira ASC
    ''', [word]);

    return result;
  }
}
