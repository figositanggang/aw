import 'package:database_/main.dart';
import 'package:database_/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = "";

  @override
  Widget build(BuildContext context) {
    dbHelper.getNote().then(
      (value) {
        setState(() {
          result = value.toString();
        });
      },
    );

    return Scaffold(
      appBar: AppBar(title: Text("My Database")),
      body: SingleChildScrollView(
        child: Text(result),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddNoteDIalog(),
          );
        },
      ),
    );
  }
}

// Note Dialog
class AddNoteDIalog extends StatefulWidget {
  const AddNoteDIalog({Key? key}) : super(key: key);

  @override
  State<AddNoteDIalog> createState() => _AddNoteDIalogState();
}

class _AddNoteDIalogState extends State<AddNoteDIalog> {
  @override
  Widget build(BuildContext context) {
    final noteProv = Provider.of<NoteProvider>(context);

    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: noteProv.id,
                decoration: InputDecoration(hintText: "Masukkan id..."),
                onChanged: (val) {
                  noteProv.id = val;
                },
              ),
              TextField(
                controller: noteProv.note,
                decoration: InputDecoration(hintText: "Masukkan note..."),
                onChanged: (val) {
                  noteProv.note = val;
                },
              ),
              ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Tambahkan"),
                ),
                onPressed: () async {
                  await dbHelper.insertNote(
                    Note(int.parse(noteProv.id.text),
                        noteProv.note.text.toString()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    dbHelper.closeDB();
  }
}

class NoteProvider extends ChangeNotifier {
  TextEditingController _id = TextEditingController();
  TextEditingController get id => this._id;

  set id(value) {
    this._id.text = value;
    notifyListeners();
  }

  TextEditingController _note = TextEditingController();
  TextEditingController get note => this._note;

  set note(value) {
    this._note.text = value;
    notifyListeners();
  }
}
