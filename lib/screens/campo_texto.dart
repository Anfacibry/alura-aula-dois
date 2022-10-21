import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/task_dados.dart';

class CampoTexto extends StatefulWidget {
  final BuildContext contextoPego;
  const CampoTexto({
    required this.contextoPego,
    Key? key,
  }) : super(key: key);

  @override
  State<CampoTexto> createState() => _CampoTextoState();
}

class _CampoTextoState extends State<CampoTexto> {
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerDificuldade = TextEditingController();
  final TextEditingController _controllerImage = TextEditingController();

  bool condicao(String? temNome) {
    if (temNome != null && temNome.isEmpty) {
      return false;
    }
    return true;
  }

  ///Este é a chave Global do Widget Form
  final _keyGlobal = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double altura = MediaQuery.of(context).size.height;
    final double largura = MediaQuery.of(context).size.width;
    return Form(
      key: _keyGlobal,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Criando tarefa"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: altura * .88,
              width: largura * .95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 4,
                ),
                color: Colors.grey,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _controllerNome,
                      keyboardType: TextInputType.name,
                      validator: (temNome) {
                        if (condicao(temNome)) {
                          return "Digite um nome";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Nome",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        ///fillcolor dar uma cor de fundo da caixa de texto
                        fillColor: Colors.white70,

                        ///filled ativa a cor de fundo
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _controllerDificuldade,
                      keyboardType: TextInputType.number,

                      ///validação lógica do TextFormField
                      validator: (dificuldade) {
                        if (condicao(dificuldade) ||
                            int.parse(_controllerDificuldade.text) < 1 ||
                            int.parse(_controllerDificuldade.text) > 5) {
                          return "Digite uma dificuldade entre 1 e 5";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Dificuldade",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        ///fillcolor dar uma cor de fundo da caixa de texto
                        fillColor: Colors.white70,

                        ///filled ativa a cor de fundo
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _controllerImage,
                      onChanged: (imagemPega) {
                        setState(() {});
                      },
                      validator: (url) {
                        if (condicao(url)) {
                          return "Digite uma URL válida";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        hintText: "Imagem",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        ///fillcolor dar uma cor de fundo da caixa de texto
                        fillColor: Colors.white70,

                        ///filled ativa a cor de fundo
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        _controllerImage.text,
                        errorBuilder: (context, objeto, stackTrac) {
                          return Image.asset("assets/images/flutter_logo.png");
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  ///Botão para fazer a validação do TextFormField
                  ElevatedButton(
                    onPressed: () {
                      if (_keyGlobal.currentState!.validate()) {
                        TaskDados.of(widget.contextoPego)!.novoTask(
                          _controllerNome.text,
                          _controllerImage.text,
                          int.parse(_controllerDificuldade.text),
                        );
                        SnackBar snackBar = const SnackBar(
                          content: Text(
                            "Salvando foto",
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          duration: Duration(seconds: 5),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Salvar"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
