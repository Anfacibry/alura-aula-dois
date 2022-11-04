import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';
import 'package:nosso_primeiro_projeto/data/task_dao.dart';

import 'campo_texto.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
          ///O parametro future está pegando uma lista da memória que é
          ///futura
          future: TaskDao().listaTask(),
          builder: (futureContext, snapshot) {
            List<Task>? itensPego = snapshot.data;
            switch (snapshot.connectionState) {

              ///none = nenhum, talvez com alguns dados iniciais.
              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text("Carregando"),
                    ],
                  ),
                );
              // break;

              ///waiting = esperando, indicando que a operação assíncronia
              ///começou, tipicamente com os dados sendo nulos.
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text("Carregando")
                    ],
                  ),
                );
              // break;

              ///active = ativos, com dados não nulos, e
              ///possíveis alterações ao longo do tempo.
              case ConnectionState.active:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text("Carregando")
                    ],
                  ),
                );
              // break;

              ///done = feito, com os dados sendo não-nulos.
              case ConnectionState.done:
                if (snapshot.hasData && itensPego != null) {
                  if (itensPego.isNotEmpty) {
                    return ListView.builder(
                      itemCount: itensPego.length,
                      itemBuilder: (listConstext, index) {
                        final Task taskPego = itensPego[index];
                        return taskPego;
                      },
                    );
                  }
                  return const Text("Erro ao carregar tarefas");
                }
                return Center(
                  child: Column(
                    children: const [
                      Icon(
                        Icons.error_outline,
                        size: 128,
                      ),
                      Text("Nenhuma tarefa foi encontrada"),
                    ],
                  ),
                );

              // break;
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (novoContext) => CampoTexto(
                contextoPego: context,
              ),
            ),
          ).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
