// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/add', page: () => AddNotePage()),
      ],
    );
  }
}

class NoteController extends GetxController {
  var notes = <Map<String, String>>[].obs;

  void addNote(Map<String, String> note) {
    notes.add(note);
  }

  void removeNoteAt(int index) {
    notes.removeAt(index);
  }
}

class HomePage extends StatelessWidget {
  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Saya'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: noteController.notes.length,
          itemBuilder: (context, index) {
            final note = noteController.notes[index];
            return ListTile(
              title: Text(note['judul'] ?? ''),
              subtitle: Text(note['deskripsi'] ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  noteController.removeNoteAt(index);
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddNotePage extends StatelessWidget {
  final NoteController noteController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Catatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Judul',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final String title = titleController.text.trim();
                final String description = descriptionController.text.trim();

                if (title.isNotEmpty && description.isNotEmpty) {
                  noteController.addNote({
                    'judul': title,
                    'deskripsi': description,
                  });
                  Get.back();
                } else {
                  Get.snackbar('Error', 'Judul dan Deskripsi tidak boleh kosong',
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
