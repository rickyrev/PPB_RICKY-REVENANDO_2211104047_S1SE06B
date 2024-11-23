import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'biodata_model.dart';
import 'add_biodata_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Biodata Mahasiswa',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Biodata> _biodataList = [];

  void _loadBiodataList() async {
    final data = await DatabaseHelper().getBiodataList();
    setState(() {
      _biodataList = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadBiodataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SQLite Biodata Mahasiswa')),
      body: ListView.builder(
        itemCount: _biodataList.length,
        itemBuilder: (context, index) {
          final biodata = _biodataList[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(biodata.nama),
              subtitle: Text('NIM: ${biodata.nim}\nAlamat: ${biodata.alamat}\nHobi: ${biodata.hobi}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBiodataPage(onSaved: _loadBiodataList),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
