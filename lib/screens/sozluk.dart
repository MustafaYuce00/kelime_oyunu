import 'package:dynamic_background/dynamic_background.dart';
import 'package:flutter/material.dart';
import 'package:kelime_oyunu/data/databaseHelper.dart';

class Sozluk extends StatefulWidget {
  const Sozluk({super.key});

  @override
  State<Sozluk> createState() => _SozlukState();
}

class _SozlukState extends State<Sozluk> {
  TextEditingController controllerText = TextEditingController();
  List<Map<String, dynamic>> wordDetails = [];

  @override
  void initState() {
    super.initState();
    wordDetails = [];
  }

  kelimeAra() async {
    wordDetails.clear();
    var str = controllerText.text.trimRight().trimLeft();
    var temp = await DatabaseHelper.getWordDetails(str);

    setState(() {
      wordDetails = List<Map<String, dynamic>>.from(temp);
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: DynamicBg(
        duration: const Duration(seconds: 120),
        painterData: PrebuiltPainters.sprite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Card(
              elevation: 5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    // merak ettiğin kelimeyi ara
                    const Text(
                      'Merak Ettiğin Kelimeyi Ara',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: TextField(
                        controller: controllerText,
                        onEditingComplete: kelimeAra,
                        decoration: InputDecoration(
                          hintText: 'Sözlükte Ara',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () async {
                              kelimeAra();
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    wordDetails.isNotEmpty
                        ? Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 8.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: (wordDetails.first['madde'] ??
                                                " ") +
                                            "\n",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 34,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: (wordDetails.first['telaffuz'] ??
                                                " ") +
                                            "\t",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      TextSpan(
                                        text: (wordDetails.first['lisan'] ??
                                                " ") +
                                            "\n",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),

            // Word details listtile
            Divider(
              thickness: 2,
            ),
            Expanded(
              child: FutureBuilder(
                  future: DatabaseHelper.getWordDetails(
                      controllerText.text.trimLeft().trimRight()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      print(snapshot.data);
                      return Center(child: Text('Kelime Bulunamadı'));
                    } else {
                      return ListView.builder(
                        itemCount: wordDetails.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${index + 1}. ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: (wordDetails[index]
                                                ["ozellik_tam_adi"] ??
                                            " ") +
                                        " ",
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  TextSpan(
                                    text: wordDetails[index]['anlam'],
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Text(
                              wordDetails[index]["ornekler"]
                                      .toString()
                                      .contains("|")
                                  ? wordDetails[index]["ornekler"]
                                      .toString()
                                      .replaceAll("|", "\n")
                                  : wordDetails[index]["ornekler"] ?? " ",
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
