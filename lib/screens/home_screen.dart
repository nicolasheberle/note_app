import 'package:flutter/material.dart';
import '../models/note_model.dart';
import 'create_note.dart';
import 'widgets/note_card.dart';
import '../utils/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Notes'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return NoteCard(
            note: notes[index],
            index: index,
            onNoteDeleted: onNoteDeleted,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreateNote(
              onNewNoteCreated: onNewNoteCreated,
              onNoteUpdated: () {
                // Atualiza a lista de notas na tela atual
                fetchNotes();
              },
            ),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void onNewNoteCreated(Note note) async {
    await DatabaseHelper.insert(note);
    fetchNotes();
  }

  void onNoteDeleted(int index) async {
    final noteId = notes[index].id;
    await DatabaseHelper.delete(noteId!);
    fetchNotes();
  }

  void fetchNotes() async {
    final notesFromDB = await DatabaseHelper.getAllNotes();
    setState(() {
      notes = notesFromDB;
    });
  }
}