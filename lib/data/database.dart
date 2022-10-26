import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> pegandoDatabase() async {
  const String tabela = "Comando SQL para criação de tabela";
  final String caminhoPego = join(await getDatabasesPath(), "task.db");
  return openDatabase(caminhoPego, onCreate: (db, versao) {
    db.execute(tabela);
  }, version: 1);
}

const String talebaTask = """
CREATE TABLE $_nomeTabela(
  $_nome TEXT,
  $_dificuldade INTEGER,
  $_imagem TEXT,
)""";

const String _nomeTabela = "tabelaTask";
const String _nome = "nome";
const String _dificuldade = "dificuldade";
const String _imagem = "imagem";
