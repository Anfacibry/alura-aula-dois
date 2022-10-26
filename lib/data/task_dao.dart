class TaskDao {
  ///Criando tabela no banco de dados
  static const String talebaTask = """
CREATE TABLE $nomeTabela(
  $_nome TEXT,
  $_dificuldade INTEGER,
  $_imagem TEXT,
  )""";

  static const String nomeTabela = "tabelaTask";
  static const String _nome = "nome";
  static const String _dificuldade = "dificuldade";
  static const String _imagem = "imagem";
}
