import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list/bloc/shared_preferences_bloc.dart';
import 'package:todo_list/models/lista_models.dart';
import 'package:todo_list/pages/task_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListPage extends StatefulWidget {
  List<Lista> lista = List<Lista>();
  SharedBloc bloc;
  ListPage() {
    bloc = SharedBloc();
  }
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var newListCtrl = TextEditingController();

  void add() {
    setState(() {
      if (!newListCtrl.text.isEmpty) {
        widget.lista.add(
          Lista(nome: newListCtrl.text),
        );
        newListCtrl.text = "";
      }
    });
  }

  void remove(int index) {
    widget.lista.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newListCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            labelText: "Nova Lista",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: add,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: widget.lista.length,
        itemBuilder: (BuildContext context, int index) {
          final data = widget.lista[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemPage(items: data.items),
                ),
              );
            },
            child: Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red.withOpacity(0.2),
              ),
              onDismissed: (direction) {
                remove(index);
              },
              child: Container(
                padding: EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        data.nome,
                        style: TextStyle(fontSize: 21),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.keyboard_arrow_right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
