import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:slip_paper/model/shape.dart';
import 'package:sqflite/sqflite.dart';
import 'package:slip_paper/model/card.dart' as card_model;
import 'package:uuid/uuid.dart';

const sqliteTableName = 'papers';

class CardData {
  // WidgetsFlutterBinding.ensureInitialized();
  Future<Database> createDatabase() async {
    print(join(await getDatabasesPath(), 'slip_paper.db'));
    return await openDatabase(
      join(await getDatabasesPath(), sqliteTableName),
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE papers(id TEXT PRIMARY KEY, color TEXT, type INTEGER, content TEXT, shape INTEGER, pos_x REAL, pos_y REAL,  create_dt INTEGER, update_dt INTEGER)');
      },
    );
  }

  Future<card_model.CardModel> addTask(card_model.CardModel card) async {
    final db = await createDatabase();
    card.createDt = Timeline.now;
    card.id = Uuid().v4();

    await db.insert(sqliteTableName, card.toJson());
    return card;
  }

  Future<card_model.CardModel> getTask(String id) async {
    final db = await createDatabase();
    final cards =
        await db.query(sqliteTableName, where: 'id = ?', whereArgs: [id]);
    return card_model.CardModel.fromJson(cards.first);
  }

  Future deleteCard(card_model.CardModel card) async {
    final db = await createDatabase();
    await db.delete(
      sqliteTableName,
      where: 'id = ?',
      whereArgs: [card.id],
    );
  }

  Future<List<card_model.CardModel>> getCards(PaperType type) async {
    final db = await createDatabase();
    final cards = await db
        .query(sqliteTableName, where: 'type = ?', whereArgs: [type.index]);
    List<card_model.CardModel> rst = List.generate(
        cards.length, (index) => card_model.CardModel.fromJson(cards[index]));
    return rst;
  }

  Future<card_model.CardModel> updateCard(card_model.CardModel card) async {
    final db = await createDatabase();
    card.updateDt = Timeline.now;
    await db.update(
      sqliteTableName,
      card.toJson(),
      where: 'id = ?',
      whereArgs: [card.id],
    );
    return card;
  }
}
