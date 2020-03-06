import 'package:flutter/material.dart';
import 'package:sembast_flutter_example/main.dart';
import 'package:sembast_flutter_example/model/model.dart';
import 'package:sembast_flutter_example/page/edit_page.dart';
import 'package:sembast_flutter_example/page/note_page.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';

class NoteListPage extends StatefulWidget {
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'NotePad',
      )),
      body: StreamBuilder<List<DbNote>>(
        stream: noteProvider.onNotes(),
        builder: (context, snapshot) {
          var notes = snapshot.data;
          if (notes == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: notes?.length,
              itemBuilder: (context, index) {
                var note = notes[index];
                return ListTile(
                  title: Text(note.title?.v ?? ''),
                  subtitle: note.content.v?.isNotEmpty ?? false
                      ? Text(LineSplitter.split(note.content.v).first)
                      : null,
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return NotePage(
                        noteId: note.id.v,
                      );
                    }));
                  },
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return EditNotePage(
              initialNote: null,
            );
          }));
        },
      ),
    );
  }
}
