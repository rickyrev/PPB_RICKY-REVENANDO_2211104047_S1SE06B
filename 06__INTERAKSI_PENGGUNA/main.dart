import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  // Controller untuk form Nama dan Email
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Function untuk menampilkan hasil input dari form
  void _submitForm() {
    String name = _nameController.text;
    String email = _emailController.text;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Data Dikirim'),
          content: Text('Nama: $name\nEmail: $email'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Ini Halaman Wisata', style: TextStyle(fontSize: 24)),
    Text('Ini Halaman Profile', style: TextStyle(fontSize: 24)),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latihan BottomNavigationBar',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Latihan BottomNavigationBar'),
        ),
        body: Center(
          // Menampilkan halaman Beranda dengan form input
          child: _selectedIndex == 0
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Masukkan Nama',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Masukkan Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 202, 0, 0),
                        ),
                      ),
                    ],
                  ),
                )
              : _widgetOptions.elementAt(_selectedIndex - 1),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.place),
              label: 'Wisata',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
