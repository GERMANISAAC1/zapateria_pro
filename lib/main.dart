import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zapatería PRO',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int ventas = 0;
  int stock = 10;

  void vender() {
    if (stock > 0) {
      setState(() {
        stock--;
        ventas++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ZAPATERÍA PRO"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text("Ventas"),
                trailing: Text("$ventas"),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Stock"),
                trailing: Text("$stock"),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: vender,
              child: const Text("VENDER"),
            )
          ],
        ),
      ),
    );
  }
}}
