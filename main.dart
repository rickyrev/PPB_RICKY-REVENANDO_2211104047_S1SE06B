import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biodata Ricky Revenando',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Biodata Ricky'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Variabel yang dapat diedit
  String _nama = "Ricky Revenando";
  String _nim = "2211104047";
  String _alamat = "Jl. Merdeka No. 123, Jakarta";
  String _deskripsi =
      "Saya adalah seorang mahasiswa jurusan Teknik Software Engineering yang berfokus pada pengembangan aplikasi mobile menggunakan Flutter.";
  bool _statusMahasiswaAktif = true;
  double _progressBelajar = 0.6;

  List<String> hobbies = ['Membaca', 'Olahraga', 'Menonton film'];
  List<bool> selectedHobbies = [false, false, false];

  // Fungsi untuk mengedit biodata
  void _editBiodata() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Controller untuk TextField input
        TextEditingController namaController = TextEditingController(text: _nama);
        TextEditingController nimController = TextEditingController(text: _nim);
        TextEditingController alamatController = TextEditingController(text: _alamat);
        TextEditingController deskripsiController = TextEditingController(text: _deskripsi);

        return AlertDialog(
          title: const Text('Edit Biodata'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                ),
                TextField(
                  controller: nimController,
                  decoration: const InputDecoration(labelText: 'NIM'),
                ),
                TextField(
                  controller: alamatController,
                  decoration: const InputDecoration(labelText: 'Alamat'),
                ),
                TextField(
                  controller: deskripsiController,
                  decoration: const InputDecoration(labelText: 'Deskripsi'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _nama = namaController.text;
                  _nim = nimController.text;
                  _alamat = alamatController.text;
                  _deskripsi = deskripsiController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Widget Gambar Profil
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile.png'), // Ganti dengan path gambar kalian
                ),
              ),
              const SizedBox(height: 20),

              // Widget Nama
              const Text(
                'Nama:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(_nama, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),

              // Widget NIM
              const Text(
                'NIM:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(_nim, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),

              // Widget Alamat
              const Text(
                'Alamat:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(_alamat, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),

              // Widget Deskripsi
              const Text(
                'Deskripsi:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                _deskripsi,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),

              // Widget Status Mahasiswa
              const Text(
                'Status Mahasiswa:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                children: [
                  const Text('Aktif', style: TextStyle(fontSize: 18)),
                  Switch(
                    value: _statusMahasiswaAktif,
                    onChanged: (bool newValue) {
                      setState(() {
                        _statusMahasiswaAktif = newValue;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Widget Progress Belajar
              const Text(
                'Progress Belajar:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Slider(
                value: _progressBelajar,
                onChanged: (double newValue) {
                  setState(() {
                    _progressBelajar = newValue;
                  });
                },
                min: 0,
                max: 1,
                divisions: 10,
                label: '${(_progressBelajar * 100).round()}%',
              ),
              const SizedBox(height: 20),

              // Widget Hobi
              const Text(
                'Hobi:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Column(
                children: hobbies.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String hobby = entry.value;
                  return CheckboxListTile(
                    title: Text(hobby),
                    value: selectedHobbies[idx],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedHobbies[idx] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _editBiodata, // Memungkinkan untuk mengedit biodata
        tooltip: 'Edit Biodata',
        child: const Icon(Icons.edit),
      ),
    );
  }
}
