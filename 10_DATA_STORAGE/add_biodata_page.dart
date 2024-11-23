import 'package:flutter/material.dart';
import 'biodata_model.dart';
import 'database_helper.dart';

class AddBiodataPage extends StatefulWidget {
  final VoidCallback onSaved;

  AddBiodataPage({required this.onSaved});

  @override
  _AddBiodataPageState createState() => _AddBiodataPageState();
}

class _AddBiodataPageState extends State<AddBiodataPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _alamatController = TextEditingController();
  final _hobiController = TextEditingController();

  void _saveBiodata() async {
    if (_formKey.currentState!.validate()) {
      final biodata = Biodata(
        nama: _namaController.text,
        nim: _nimController.text,
        alamat: _alamatController.text,
        hobi: _hobiController.text,
      );
      await DatabaseHelper().insertBiodata(biodata);
      widget.onSaved();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Biodata Mahasiswa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) => value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _nimController,
                decoration: InputDecoration(labelText: 'NIM'),
                validator: (value) => value!.isEmpty ? 'NIM tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) => value!.isEmpty ? 'Alamat tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _hobiController,
                decoration: InputDecoration(labelText: 'Hobi'),
                validator: (value) => value!.isEmpty ? 'Hobi tidak boleh kosong' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveBiodata,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
