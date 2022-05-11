import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Ic3peak', votes: 5),
    Band(id: '2', name: 'Vikingos Del Norte', votes: 5),
    Band(id: '3', name: 'Nortec Collective', votes: 4),
    Band(id: '4', name: 'Sentidos Apuestos', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            const Text('Votaciones', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, int i) => _bandTile(bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction');
        print('id: ${band.id},name:${band.name}');
      },
      background: Container(
        color: Colors.redAccent,
        padding: const EdgeInsets.only(left: 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: const [
              Icon(Icons.delete, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Eliminar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: const TextStyle(fontSize: 20)),
        onTap: () {
          //print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();
    //* Para Android
    return showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: const Text('Agregue una nueva Banda'),
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.grey[100],
              child: const Text('Agregar'),
              elevation: 1,
              textColor: Colors.blue,
              onPressed: () => addBandToList(textController.text),
            ),
            MaterialButton(
              color: Colors.grey[100],
              child: const Text('Cancelar'),
              elevation: 1,
              textColor: Colors.red,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void addBandToList(String name) {
    //print(name);
    if (name.length > 1) {
      bands.add(
        Band(id: DateTime.now().toString(), name: name, votes: 0),
      );
      setState(() {});
    }
    Navigator.pop(context);
  }
}
