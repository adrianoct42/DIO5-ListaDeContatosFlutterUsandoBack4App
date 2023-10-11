import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:listadecontatosapp/model/contato_model.dart';
import 'package:listadecontatosapp/repository/contato_repository.dart';
import 'package:listadecontatosapp/screens/add_contato_screen.dart';
import 'package:listadecontatosapp/screens/contatos_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  var dio = Dio();
  ContatoRepository contatoRepository = ContatoRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Contatos com Back4App"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              const Text(
                "Clique no botão abaixo para adicionar um contato:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 48),
              OutlinedButton(
                child: const Text("Adicionar Contato"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (bc) =>
                              AddContatoScreen(contatoRepository)));
                },
              ),
              const SizedBox(height: 48),
              const Text(
                "Para visualizar os contatos salvos, clique no botão abaixo:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 48),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (bc) =>
                                  ContatosScreen(contatoRepository)));
                    });
                  },
                  child: const Text("Contatos Salvos")),
            ],
          ),
        ),
      ),
    );
  }
}
