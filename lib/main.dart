import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(Final());

class Final extends StatelessWidget {
  const Final({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'examen final',
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key? key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  Future<List<Model>> getdata() async {
    var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/comments"),
        headers: {"Accept": "Application/json"});
    var data = json.decode(response.body);
    print(data);
    List<Model> models = [];
    for (var m in data) {
      Model model = Model(m["id"], m["name"], m["email"]);
      models.add(model);
    }
    print(models.length);
    return models;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          children: [
            Text('Fabian Alonso Aguilera Quevedo'),
            Image.network("https://i.postimg.cc/zBQZWfHp/P7070528.jpg")
          ],
        )),
        body:
            //Image.network("https://i.postimg.cc/zBQZWfHp/P7070528.jpg"),
            FutureBuilder(
                future: getdata(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text('cargando....'),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int id) {
                          return ListTile(
                            title: Text(snapshot.data[id].name),
                            subtitle: Text(snapshot.data[id].email),
                          );
                        });
                  }
                }));
  }
}

class Model {
  final int id;
  final String name;
  final String email;
  Model(this.id, this.name, this.email);
}
