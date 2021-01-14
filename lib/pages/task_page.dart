import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_list/bloc/shared_preferences_bloc.dart';
import 'package:todo_list/models/item_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemPage extends StatefulWidget {
  // Cria a lista de item
  List<Item> items;
  SharedBloc bloc;
  ItemPage({this.items, this.bloc});
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  var newTaskCtrl = TextEditingController();

  void add() {
    setState(() {
      if (!newTaskCtrl.text.isEmpty) {
        widget.items.add(
          Item(title: newTaskCtrl.text, done: false),
        );
        newTaskCtrl.text = "";
        widget.bloc.save(widget.items);
      }
    });
  }

  void remove(int index) {
    widget.items.removeAt(index);
    widget.bloc.save(widget.items);
  }

  // save() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('data', jsonEncode(widget.items));
  // }

  // Le os itens do shared_prefenrences
  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
      setState(() {
        widget.items = result;
      });
    }
  }

  _HomePageState() {
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            labelText: "Nova Tarefa",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index) {
          final data = widget.items[index];
          return Dismissible(
            child: CheckboxListTile(
              autofocus: false,
              title: Text(data.title),
              value: data.done,
              onChanged: (value) {
                // Altera o valor do checkBox
                setState(() {
                  data.done = value;
                  widget.bloc.save(widget.items);
                });
              },
            ),
            key: Key(data.title),
            background: Container(
              color: Colors.red.withOpacity(0.2),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                remove(index);
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }
}
