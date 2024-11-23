import 'package:flutter/material.dart';
import 'package:praktikum_10/design_system/styles/color_scheme.dart'; // Import design system
import 'package:praktikum_10/helper/db_helper.dart';

class MyDbView extends StatefulWidget {
  @override
  _MyDbViewState createState() => _MyDbViewState();
}

class _MyDbViewState extends State<MyDbView> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<Map<String, dynamic>> _dataList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    final data = await _dbHelper.queryAllRows();
    setState(() {
      _dataList = data;
    });
  }

  Future<void> _insertData() async {
    final row = {
      'title': _titleController.text,
      'description': _descriptionController.text,
    };
    await _dbHelper.insert(row);
    _titleController.clear();
    _descriptionController.clear();
    _fetchData();
  }

  Future<void> _deleteData(int id) async {
    await _dbHelper.delete(id);
    _fetchData();
  }

  Future<void> _updateData(int id) async {
    final row = {
      'id': id,
      'title': _titleController.text,
      'description': _descriptionController.text,
    };
    await _dbHelper.update(row);
    _titleController.clear();
    _descriptionController.clear();
    _fetchData();
  }

  void _showEditDialog(Map<String, dynamic> item) {
    _titleController.text = item['title'];
    _descriptionController.text = item['description'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Data'),
          content: SingleChildScrollView(
            // Membungkus konten dalam SingleChildScrollView
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: null, // Mengatur agar dapat menampung banyak teks
                  keyboardType: TextInputType.multiline,
                ),
              ],
            ),
          ),
          actions: [
            Container(
              // Memisahkan tombol dalam container
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _titleController.clear();
                      _descriptionController.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      _updateData(item['id']);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
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
        title: Text(
          'Database Input Form',
          style: TextStyle(
              color: ColorSchemesView.lightGreen), // Mengubah warna judul
        ),
        backgroundColor: ColorSchemesView
            .darkBlue, // Menggunakan warna dari ColorSchemesView
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _insertData,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorSchemesView
                    .mediumGreen, // Menggunakan warna dari ColorSchemesView
              ),
              child: const Text('Add Data'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _dataList.length,
                itemBuilder: (context, index) {
                  final item = _dataList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(item['title']),
                      subtitle: Text(item['description']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showEditDialog(item),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteData(item['id']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
