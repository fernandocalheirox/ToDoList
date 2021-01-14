import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list/models/lista_models.dart';
import 'package:todo_list/pages/task_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListPage extends StatefulWidget {
  List<Lista> lista = List<Lista>();
  // ListPage() {
  //   lista.add(Lista(nome: "Faculdade"));
  //   lista.add(Lista(nome: "Faculdade"));
  //   lista.add(Lista(nome: "Faculdade"));
  //   lista.add(Lista(nome: "Faculdade"));
  // }
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var newListCtrl = TextEditingController();

  _ListPageState() {
    load();
  }

  void add() {
    setState(() {
      if (!newListCtrl.text.isEmpty) {
        widget.lista.add(
          Lista(nome: newListCtrl.text),
        );
        newListCtrl.text = "";
        // save();
      }
    });
  }

  void remove(int index) {
    widget.lista.removeAt(index);
    save();
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.lista));
  }

  // Le os itens do shared_prefenrences
  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Lista> result = decoded.map((x) => Lista.fromJson(x)).toList();
      setState(() {
        widget.lista = result;
      });
    }
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
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ItemPage(items: widget.lista[index].items),
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
                        widget.lista[index].nome,
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
