import 'package:flutter/material.dart';
import 'package:kelime_oyunu/data/databaseHelper.dart';

// ignore: use_key_in_widget_constructors
class Asdasd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('SQLite Example')),
        body: Center(
          child: FutureBuilder(
            future:DatabaseHelper.instance.getMaddesWithAnlamNotInAtasozuonly(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data!.length);
                    return ListTile(
                      title: Text(snapshot.data![index]['madde']),
                      subtitle:
                          Text(snapshot.data![index]['anlam'].toString()),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final db = await DatabaseHelper.instance.database;
    return await db.database.query('madde', orderBy: 'madde_id ASC', limit: 10);
   // return await db.query('madde');
  }
}
