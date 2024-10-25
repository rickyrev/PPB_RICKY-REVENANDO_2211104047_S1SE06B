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
  PageController _pageController = PageController();

  // Controller untuk form Nama dan Email
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange, // Menggunakan MaterialColor yang valid
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('SafeArea & PageView'),
          backgroundColor: Colors.orange, // Warna yang benar
        ),
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: <Widget>[
              // Halaman Home
              Container(
                alignment: Alignment.topCenter,
                child: Text('Home page', style: TextStyle(fontSize: 24)),
              ),
              // Halaman Form Email
              Padding(
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
                        backgroundColor: Colors.orange, // Warna yang benar
                      ),
                    ),
                  ],
                ),
              ),
              // Halaman Profile
              Center(
                child: Text('Profile page', style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.email),
              label: 'Email',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange, // Menggunakan warna yang benar
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
