import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView Dialog Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Map<String, String>> apps = [
    {
      'title': 'Gacor App',
      'detail': 'Android, iOS\nJava, Swift'
    },
    {
      'title': 'Hybrid App',
      'detail': 'Android, iOS, Web\nJavascript, Dart'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView with Dialog'),
      ),
      body: ListView.builder(
        itemCount: apps.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              Icons.circle,
              color: index == 0 ? const Color.fromARGB(255, 158, 10, 146) : const Color.fromARGB(255, 4, 247, 255),
              size: 40,
            ),
            title: Text(
              apps[index]['title']!,
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Detail'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          apps[index]['title']!,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 11, 75, 128)),
                        ),
                        SizedBox(height: 10),
                        Text(
                          apps[index]['detail']!,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
