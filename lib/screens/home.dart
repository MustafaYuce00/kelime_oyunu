import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dynamic_background/dynamic_background.dart';
import 'package:flutter/material.dart';
import 'package:kelime_oyunu/const/consts.dart';
import 'package:kelime_oyunu/screens/deneme/gameScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //   {"label": "Kelimeler Dünyası", "image": "assets/harfs.gif"},
  /**
    {
      'label': 'İkili İksir',
      'image': 'assets/2.gif',
      'label2': '2 Harfli Kelimeler',
      "oyunTuru": "2",
    }, 
   
   */
  final List<Map<String, dynamic>> items = [
    {
      'label': 'Üçün Gücü',
      'image': 'assets/3.gif',
      'label2': '3 Harfli Kelimeler',
      "oyunTuru": "3",
    },
    {
      'label': '4 4’lük',
      'image': 'assets/4.gif',
      'label2': '4 Harfli Kelimeler',
      "oyunTuru": "4",
    },
    {
      'label': 'Beşer Beşer',
      'image': 'assets/5.gif',
      'label2': '5 Harfli Kelimeler',
      "oyunTuru": "5",
    },
    {
      'label': 'Altı Üstü Altı',
      'image': 'assets/6.gif',
      'label2': '6 Harfli Kelimeler',
      "oyunTuru": "6",
    },
    {
      'label': 'Yedi Yıldız',
      'image': 'assets/7.gif',
      'label2': '7 Harfli Kelimeler',
      "oyunTuru": "7",
    },
    {
      'label': 'Sekiz Sihir',
      'image': 'assets/8.gif',
      'label2': '8 Harfli Kelimeler',
      "oyunTuru": "8",
    },
    {
      'label': 'Dokuz Nokta',
      'image': 'assets/9.gif',
      'label2': '9 Harfli Kelimeler',
      "oyunTuru": "9",
    },
    {
      'label': 'On Numara',
      'image': 'assets/10.gif',
      'label2': '10 Harfli Kelimeler',
      "oyunTuru": "10",
    },
  ];
  double tempHeight = 0.0;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          setState(() {
            tempHeight = 0.0;
            isExpanded = false;
          });
        },
        child: Scaffold(
          body: DynamicBg(
            duration: const Duration(seconds: 120),
            painterData: PrebuiltPainters.sprite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: CircleAvatar(
                            backgroundImage:
                                const AssetImage('assets/profil.png'),
                            radius: 50,
                          ),
                        ),
                      ),
                      const Text(
                        'Harflerin Gezegeni',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                Consts.selectedIndex.value = 1;
                                print(Consts.selectedIndex);
                              },
                              icon: const Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GameScreen(
                                    oyunTuru: "mix",
                                  )));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.035),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.45,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                  image: AssetImage('assets/harfs.gif'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Oyun ismi
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Kelimeler Dünyası',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //! genel açıklama
                                  Text(
                                    "Kelimelerle\ndolu bir maceraya\nçıkın!",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.0125,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    child: Text(
                                      "Kelimelerin büyülü dünyasını keşfedin!",
                                      maxLines: 4,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25 + tempHeight,
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.008,
                right: MediaQuery.of(context).size.height * 0.008,
                top: MediaQuery.of(context).size.height * 0.01),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Oyunlar',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    isExpanded == false
                        ? TextButton(
                            onPressed: () {
                              setState(() {
                                tempHeight =
                                    MediaQuery.of(context).size.height * 0.4;
                                isExpanded = true;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Tümünü Gör',
                                  style: TextStyle(
                                    color: Colors.orange[700],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.0250,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange[700],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_right_alt,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              setState(() {
                                tempHeight = 0.0;
                                isExpanded = false;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Küçült',
                                  style: TextStyle(
                                    color: Colors.orange[700],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.0250,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange[700],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          )
                  ],
                ),
                // yatayda kaydırma işlemi yapılacak kare kartlar oluşturulacak

                isExpanded == false
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(items.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GameScreen(
                                              oyunTuru: items[index]
                                                  ['oyunTuru'],
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height:
                                      MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                    // random color verilecek buraya
                                    color: Colors.orange[700],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: AnimatedTextKit(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        GameScreen(
                                                          oyunTuru: items[index]
                                                              ['oyunTuru'],
                                                        )));
                                          },
                                          pause: Duration(seconds: index),
                                          totalRepeatCount: 1,
                                          animatedTexts: [
                                            ScaleAnimatedText(
                                              items[index]['oyunTuru']
                                                  .toString(),
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            ScaleAnimatedText(
                                              items[index]['label2']
                                                  .toString()
                                                  .substring(1, 8),
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            ScaleAnimatedText(
                                              items[index]['label2']
                                                  .toString()
                                                  .substring(8, 18),
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TyperAnimatedText(
                                              speed: const Duration(
                                                  milliseconds: 100),
                                              items[index]['label2'],
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 28,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            mainAxisExtent:
                                MediaQuery.of(context).size.width * 0.38,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GameScreen(
                                              oyunTuru: items[index]
                                                  ['oyunTuru'],
                                            )));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.orange[700],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: AnimatedTextKit(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        GameScreen(
                                                          oyunTuru: items[index]
                                                              ['oyunTuru'],
                                                        )));
                                          },
                                          totalRepeatCount: 1,
                                          animatedTexts: [
                                            TyperAnimatedText(
                                              speed: const Duration(
                                                  milliseconds: 100),
                                              items[index]['label2'],
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                /* Row(
                          children: List.generate(items.length, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      color: Colors.orange[700],
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: AssetImage(items[index]['image']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    items[index]['label'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                    */
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/** 
 AnimatedTextKit(
                                        pause: Duration(seconds: index),
                                        animatedTexts: [
                                          ScaleAnimatedText(
                                            (index + 2).toString(),
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ScaleAnimatedText(
                                            items[index]['label2']
                                                .toString()
                                                .substring(1, 8),
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ScaleAnimatedText(
                                            items[index]['label2']
                                                .toString()
                                                .substring(8, 18),
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TyperAnimatedText(
                                            speed: const Duration(
                                                milliseconds: 100),
                                            items[index]['label2'],
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ]),
                                 

 */