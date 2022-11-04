import 'package:flutter/cupertino.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';
import 'package:nosso_primeiro_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  ///Criando tabela no banco de dados
  static const String criandoTabelaTask = '''
  CREATE TABLE $_nomeTabela(
    $_nome TEXT,
    $_dificuldade INTEGER,
    $_imagem TEXT,
  )
  ''';

  static const String _nomeTabela = 'tabelaTask';
  static const String _nome = 'nome';
  static const String _dificuldade = 'dificuldade';
  static const String _imagem = 'imagem';

  ///Método que salva uma tarefa task no banco de dados
  Future<int> salvar(Task salvarTarefaTask) async {
    debugPrint("Salvando tarefa task");
    final Database bancoDeDados = await pegandoDatabase();
    List<Task> tarefaPega = await buscandoTarefaTask(salvarTarefaTask.nome);
    Map<String, dynamic> mapaDeTask = toMap(salvarTarefaTask);
    debugPrint(mapaDeTask.toString());
    if (tarefaPega.isEmpty) {
      debugPrint("A tarefa não existia");
      return await bancoDeDados.insert(_nomeTabela, mapaDeTask);
    } else {
      debugPrint("A tarefa já existia");
      return await bancoDeDados.update(
        _nomeTabela,
        mapaDeTask,
        where: '$_nome = ?',
        whereArgs: [salvarTarefaTask.nome],
      );
    }
  }

  Map<String, dynamic> toMap(Task task) {
    Map<String, dynamic> mapTask = {};
    mapTask[_nome] = task.nome;
    mapTask[_dificuldade] = task.dificuldade;
    mapTask[_imagem] = task.foto;
    return mapTask;
  }

  ///Método que carrega a lista das tarefas task do db
  Future<List<Task>> listaTask() async {
    debugPrint("Lista de tasks");

    ///Pegando o banco de dados
    final Database bancoDeDados = await pegandoDatabase();

    ///Pegando os dados do banco de dados e colocando em um map
    ///.query(nome da tabela). este método está pegando toda a tabela do banco de
    ///dados que foi criado
    final List<Map<String, dynamic>> mapDeTaks =
        await bancoDeDados.query(_nomeTabela);
    debugPrint(
        "Procurando banco de dados... Banco de dados encontrado: $mapDeTaks");

    return convertendoMapEmListTask(mapDeTaks);
  }

  ///Metodo que converte uma lista de map para uma lista de task, passando
  ///todos os seus elementos.
  List<Task> convertendoMapEmListTask(List<Map<String, dynamic>> mapTaskPego) {
    debugPrint("Convertendo lista");
    List<Task> listaTaskc = [];
    for (Map<String, dynamic> elemento in mapTaskPego) {
      final Task task = Task(
        nome: elemento[_nome],
        foto: elemento[_imagem],
        dificuldade: elemento[_dificuldade],
      );
      listaTaskc.add(task);
    }
    debugPrint("Lista de task ${listaTaskc.toString()}");
    return listaTaskc;
  }

  ///Método que pega uma unica tarefa do banco de dados
  Future<List<Task>> buscandoTarefaTask(String nomeTarefaTask) async {
    debugPrint("Buscando tarefa");
    final Database bancoDeDados = await pegandoDatabase();
    final List<Map<String, dynamic>> resultado = await bancoDeDados.query(
      ///Nome da tabela pega
      _nomeTabela,

      ///Where procura o nome para fazer a verificação
      where: '$_nome = ?',

      ///whereArgs pega o nome para verificar com o parametro where
      whereArgs: [nomeTarefaTask],
    );
    debugPrint("Tarefa encontrada: ${convertendoMapEmListTask(resultado)}");
    return convertendoMapEmListTask(resultado);
  }

  ///Método que deleta uma tarefa do banco de dados
  Future<void> deletar(String tarefaTask) async {
    debugPrint("Deletando tarefa pega");
    Database bancoDeDados = await pegandoDatabase();
    await bancoDeDados.delete(
      _nomeTabela,
      where: '$_nome = ?',
      whereArgs: [tarefaTask],
    );
  }
}
