import 'dart:io';

import 'package:flutter/material.dart';
import 'package:listadecontatosapp/model/contato_model.dart';
import 'package:listadecontatosapp/repository/contato_repository.dart';

class ContatosScreen extends StatefulWidget {
  ContatosScreen(this.contatoRepository, {super.key});

  ContatoRepository contatoRepository;

  @override
  State<ContatosScreen> createState() => _ContatosScreenState();
}

class _ContatosScreenState extends State<ContatosScreen> {
  ListaContatosModel _contatosBack4App = ListaContatosModel([]);
  bool carregando = false;

  void loadContatos() async {
    setState(() {
      carregando = true;
    });
    _contatosBack4App = await widget.contatoRepository.obterContatos();
    setState(() {
      carregando = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadContatos();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Contatos Salvos")),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: carregando
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _contatosBack4App.listaContatos.length,
                  itemBuilder: (BuildContext bc, int index) {
                    var contato = _contatosBack4App.listaContatos[index];
                    return Dismissible(
                      key: Key(contato.objectId),
                      onDismissed: (DismissDirection dismissDirection) async {
                        await widget.contatoRepository
                            .removeContato(contato.objectId);
                      },
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Column(
                          children: [
                            Text(
                              "Contato ${index + 1}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const SizedBox(width: 15),
                                Container(
                                  width: 70,
                                  height: 70,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 2),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(File(contato.foto))),
                                ),
                                const SizedBox(width: 30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(contato.nome),
                                    Text("${contato.numero}"),
                                    Text(contato.email),
                                    const SizedBox(height: 20),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
