import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';

class TaskDados extends InheritedWidget {
  TaskDados({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  ///Armazenamento de dados local com uma lista que contem
  ///nome, foto e dificuldade
  final List<Task> listaTask = [
    const Task(
      nome: 'Aprender Flutter',
      foto: 'assets/images/dash.png',
      dificuldade: 3,
    ),
    const Task(
        nome: 'Andar de Bike', foto: 'assets/images/bike.webp', dificuldade: 2),
    const Task(
        nome: 'Meditar', foto: 'assets/images/meditar.jpeg', dificuldade: 5),
    const Task(nome: 'Ler', foto: 'assets/images/livro.jpg', dificuldade: 4),
    const Task(nome: 'Jogar', foto: 'assets/images/jogar.jpg', dificuldade: 1),
  ];

  void novoTask(String nomePego, String imagem, int dificuldadePego) {
    listaTask
        .add(Task(nome: nomePego, foto: imagem, dificuldade: dificuldadePego));
  }

  static TaskDados? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskDados>();
  }

  @override
  bool updateShouldNotify(TaskDados oldWidget) {
    ///oldWidget.listaTask.length está pegando o tamanho atualizado e verificando
    ///com o tamanho atual listaTask.length;
    ///Com isso, irá notificar se o tamanho for alturado com true
    ///e se não for alturado, com false
    return oldWidget.listaTask.length != listaTask.length;
  }
}
