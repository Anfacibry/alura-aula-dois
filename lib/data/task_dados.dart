import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';

class TaskDados extends InheritedWidget {
  TaskDados({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> listaTask = [
    const Task('Aprender Flutter', 'assets/images/dash.png', 3),
    const Task('Andar de Bike', 'assets/images/bike.webp', 2),
    const Task('Meditar', 'assets/images/meditar.jpeg', 5),
    const Task('Ler', 'assets/images/livro.jpg', 4),
    const Task('Jogar', 'assets/images/jogar.jpg', 1),
  ];

  void novoTask(String nome, String imagem, int dificuldade) {
    listaTask.add(Task(nome, imagem, dificuldade));
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
