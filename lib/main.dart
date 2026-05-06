import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

//////////////////////////
// BASE DE DATOS
//////////////////////////
class DB {
  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'negocio.db'),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE productos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT,
          stock INTEGER,
          precio REAL
        )
        ''');

        await db.execute('''
        CREATE TABLE ventas(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          producto TEXT,
          total REAL
        )
        ''');

        // datos iniciales
        await db.insert("productos", {
          "nombre": "Nike",
          "stock": 10,
          "precio": 150
        });

        await db.insert("productos", {
          "nombre": "Adidas",
          "stock": 8,
          "precio": 120
        });
      },
      version: 1,
    );
  }
}

//////////////////////////
// APP
//////////////////////////
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Negocio PRO",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const Home(),
    );
  }
}

//////////////////////////
// HOME
//////////////////////////
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List productos = [];
  List ventas = [];
  double total = 0;

  @override
  void initState() {
    super.initState();
    cargar();
  }

  Future cargar() async {
    final db = await DB.db();
    productos = await db.query("productos");
    ventas = await db.query("ventas");

    total = ventas.fold(0, (sum, v) => sum + (v["total"] as num));

    setState(() {});
  }

  Future vender(Map p) async {
    final db = await DB.db();

    if (p["stock"] > 0) {
      await db.update(
        "productos",
        {"stock": p["stock"] - 1},
        where: "id=?",
        whereArgs: [p["id"]],
      );

      await db.insert("ventas", {
        "producto": p["nombre"],
        "total": p["precio"],
      });

      cargar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NEGOCIO PRO")),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text("Total ventas"),
              subtitle: Text("S/ $total"),
            ),
          ),
          const Text("Productos"),
          Expanded(
            child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (_, i) {
                final p = productos[i];
                return ListTile(
                  title: Text(p["nombre"]),
                  subtitle: Text("Stock: ${p["stock"]}"),
                  trailing: Text("S/ ${p["precio"]}"),
                  onTap: () => vender(p),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
