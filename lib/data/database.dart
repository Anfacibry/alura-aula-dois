import 'package:nosso_primeiro_projeto/data/task_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> pegandoDatabase() async {
  final String caminhoPego = join(await getDatabasesPath(), 'task.db');
  return await openDatabase(caminhoPego, onCreate: (db, versao) {
    return db.execute(TaskDao.criandoTabelaTask);
  }, version: 1);
}
