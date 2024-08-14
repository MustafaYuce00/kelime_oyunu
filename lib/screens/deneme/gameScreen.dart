import 'dart:math';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:dynamic_background/dynamic_background.dart';
import 'package:flutter/material.dart';
import 'package:kelime_oyunu/const/consts.dart';
import 'package:kelime_oyunu/const/methods.dart';
import 'package:kelime_oyunu/data/databaseHelper.dart';
import 'package:kelime_oyunu/googleAds/reklam.dart';
import 'package:kelime_oyunu/model/userGame.dart';
import 'package:kelime_oyunu/screens/mainHome.dart';
import 'package:uuid/uuid.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.oyunTuru});
  final String oyunTuru;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  CountDownController timerController = CountDownController();
  late List<TextEditingController> controllers;
  late List<String> buttons;
  Random random = Random(DateTime.now().millisecondsSinceEpoch);
  Map<String, dynamic> kelime = {};
  List<String> enteredChars = [];
  int currentIndex = 0;
  bool isLoaded = true;

  UserGameModel userGame = UserGameModel.empty();
  int toplamSure = 60;
  int yapilanSure = 0;
  double dogruSayisi = 0;
  double denemeSayisi = 0;
  double ipucuSayisi = 0;
  double firstIpucu = 2;

  final Reklam reklam = Reklam();

  @override
  void initState() {
    super.initState();
    Consts.reklamGostermeSayisi++;
    initializeGame();
  }

  @override
  void dispose() {
    oyunKayit();
    super.dispose();
  }

  void oyunKayit() {
    String? asd = timerController.getTime();
    yapilanSure = (toplamSure - int.parse(asd!));

    userGame.id = Uuid().v4();
    userGame.userId = Consts.user!.id;
    userGame.gameId = "1"; // kelime oyunu id
    userGame.status = "";
    userGame.yapilansure = yapilanSure;
    userGame.toplamSure = toplamSure;
    userGame.dogruSayisi = dogruSayisi;
    userGame.denemeSayisi = denemeSayisi;
    userGame.ipucuSayisi = ipucuSayisi;
    userGame.sorular = Consts.kelimeListesi45678910;

    Consts.user!.kullaniciOyunlari!.add(userGame);
  }

  void reklamGoster() {
    setState(() {
      firstIpucu += 2;
    });
  }

  //! Main function
  @override
  Widget build(BuildContext context) {
    reklam.loadAdOdullu1();
    print(kelime);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: DynamicBg(
            duration: const Duration(seconds: 45),
            painterData: ScrollerPainterData(
              direction: ScrollDirection.top2Bottom,
              shape: ScrollerShape.diamonds,
              backgroundColor: ColorSchemes.icyBlueBg,
              color: ColorSchemes.icyBlueFg,
              shapeWidth: 24.0,
              spaceBetweenShapes: 24.0,
              fadeEdges: true,
              shapeOffset: ScrollerShapeOffset.shiftAndMesh,
            ),
            child: isLoaded
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text(
                          'Hazırlanıyor ...',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ))
                : SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.9,
                      // color: Colors.grey[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${kelime['madde']}'),
                          CircularCountDownTimer(
                            duration: toplamSure,
                            initialDuration: 0,
                            controller: timerController,
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.height * 0.1,
                            ringColor: Colors.grey[300]!,
                            ringGradient: null,
                            fillColor: Colors.purpleAccent[100]!,
                            fillGradient: null,
                            backgroundColor: Colors.purple[500],
                            backgroundGradient: null,
                            strokeWidth: 20.0,
                            strokeCap: StrokeCap.round,
                            textStyle: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textFormat: CountdownTextFormat.S,
                            isReverse: true,
                            isReverseAnimation: true,
                            isTimerTextShown: true,
                            autoStart: true,
                            onStart: () {
                              debugPrint('Countdown Started');
                            },
                            onComplete: () {
                              debugPrint('Countdown Ended');
                              // süre bittiğinde yapılacak işlemler
                              // ignore: void_checks
                              Methods.ustbildirimError(context, "Süre Bitti!");
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainHome()),
                                  (route) => false);
                            },
                            onChange: (String timeStamp) {
                              debugPrint('Countdown Changed $timeStamp');
                            },
                            timeFormatterFunction:
                                (defaultFormatterFunction, duration) {
                              if (duration.inSeconds == 0) {
                                return "0";
                              } else {
                                return Function.apply(
                                    defaultFormatterFunction, [duration]);
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          buildWordInput(context),

                          //! kontrol et butonu
                          /*    const SizedBox(height: 10),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Colors.deepPurple[700],
                              ),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            onPressed: checkAnswer,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.flaky_rounded,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  Spacer(),
                                  const Text(
                                    'Kontrol Et',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                       */
                        ],
                      ),
                    ),
                  ),
          ),
          // Soru sayısı doğru yanlış ve süreyi gösteren kısım
        ),
      ),
    );
  }

  //! Anlam ve madde kısmı
  Column buildWordInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Card(
            elevation: 10,
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                child: Text(kelime['anlamlar'],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Badge(
              largeSize: MediaQuery.of(context).size.width * 0.06,
              smallSize: MediaQuery.of(context).size.width * 0.05,
              padding: EdgeInsets.all(4),
              backgroundColor: Colors.red[700],
              label: Text(
                firstIpucu.toStringAsFixed(0),
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              child: IconButton(
                onPressed: () {
                  ipucuUserSor().then((value) => timerController.resume());
                },
                icon:
                    Icon(Icons.lightbulb, size: 40, color: Colors.orange[700]),
                tooltip: "Harf Al",
                splashRadius: 20,
              ),
            ),

            //! Harfleri sıfırla
            /*      ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor:
                    WidgetStateProperty.all(Colors.deepPurple[700]),
              ),
              onPressed: resetInput,
              child: const Text(
                'Harfleri Sıfırla',
                style: TextStyle(color: Colors.white),
              ),
            ),
        */
            IconButton(
              onPressed: removeLastChar,
              icon: Icon(
                Icons.backspace_outlined,
                size: 40,
                color: Colors.red,
              ),
            ),
          ],
        ),
        Text("${kelime['madde'].length} harfli bir kelime"),
        Card(
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: List.generate(kelime["madde"].length, (index) {
                if (kelime["madde"][index] == ' ') {
                  //! Boşluk varsa burası
                  return Container(
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextField(
                      enabled: false,
                      controller: controllers[index],
                      maxLength: 1,
                      decoration: const InputDecoration(
                        counterText: '',
                        hintText: "|",
                        border: InputBorder.none,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black54),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: TextField(
                        controller: controllers[index],
                        enabled: false,
                        maxLength: 1,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          counterText: '',
                          border: UnderlineInputBorder(),
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  );
                }
              }),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: buttons.map((char) {
            return ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(Colors.teal[700]),
                /*WidgetStateProperty.all(
                  Colors.primaries[random.nextInt(Colors.primaries.length)],
                ),*/
              ),
              onPressed: () => addCharToInput(char),
              child: Text(
                char,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  //! Karakter ekleme
  void addCharToInput(String char) {
    for (int i = 0; i < controllers.length; i++) {
      if (controllers[i].text.isEmpty) {
        setState(() {
          controllers[i].text = char;
          buttons.remove(char);
          enteredChars.add(char);
        });
        break;
      }
    }
    if (controllers.every((controller) => controller.text.isNotEmpty)) {
      checkAnswer();
    }
  }

  //! Son karakteri silme
  void removeLastChar() {
    if (enteredChars.isNotEmpty) {
      setState(() {
        String lastChar = enteredChars.removeLast();
        for (int i = controllers.length - 1; i >= 0; i--) {
          if (controllers[i].text == lastChar) {
            controllers[i].clear();
            buttons.add(lastChar);
            break;
          }
        }
      });
    }
  }

  //! Tüm karakterleri sıfırlama
  void resetInput() {
    setState(() {
      for (var controller in controllers) {
        controller.clear();
      }
      buttons = kelime["madde"].replaceAll(' ', '').split('')..shuffle(random);
      enteredChars.clear();
    });
  }

  //! Cevabı kontrol etme
  void checkAnswer() {
    String userAnswer = controllers.map((controller) => controller.text).join();
    if (userAnswer.replaceAll("|", "").toLowerCase() ==
        kelime["madde"].toString().replaceAll(" ", "").toLowerCase()) {
      print("Doğru!");
      dogruSayisi++;
      Methods.ustbildirimSucces(context, "Doğru!");
      nextWord();
    } else {
      print("Yanlış!");
      denemeSayisi++;
      setState(() {
        resetInput();
      });
      Methods.ustbildirimError(context, "Yanlış!");
    }
  }

  //! Harf al
  void giveHint() {
    List<int> emptyIndexes = [];
    for (int i = 0; i < controllers.length; i++) {
      if (controllers[i].text.isEmpty && kelime["madde"][i] != ' ') {
        emptyIndexes.add(i);
      }
    }

    if (emptyIndexes.isNotEmpty) {
      setState(() {
        int randomIndex = emptyIndexes[random.nextInt(emptyIndexes.length)];
        controllers[randomIndex].text = kelime["madde"][randomIndex];
        buttons.remove(kelime["madde"][randomIndex]);
        enteredChars.add(kelime["madde"][randomIndex]);
      });
      FocusScope.of(context).unfocus();
      ipucuSayisi++;
      if (firstIpucu > 0) {
        setState(() {
          firstIpucu--;
        });
      }
    }

    if (controllers.every((controller) => controller.text.isNotEmpty)) {
      checkAnswer();
    }
  }

  ipucuUserSor() {
    timerController.pause();
    return showDialog(
      barrierDismissible: false,
      //    barrierColor: Color(0xffe3fdff),
      context: context,
      builder: (BuildContext context) {
        // ignore: deprecated_member_use
        return DynamicBg(
          duration: const Duration(seconds: 45),
          painterData: ScrollerPainterData(
            direction: ScrollDirection.top2Bottom,
            shape: ScrollerShape.diamonds,
            backgroundColor: ColorSchemes.icyBlueBg,
            color: ColorSchemes.icyBlueFg,
            shapeWidth: 24.0,
            spaceBetweenShapes: 24.0,
            fadeEdges: true,
            shapeOffset: ScrollerShapeOffset.shiftAndMesh,
          ),
          child: WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Color(0xff00bfa5),
                  )),
              title: const Text('İpucu Kullanmak İstiyor Musunuz?'),
              content: Text(
                  'İpucu olarak bir harf alabilirsiniz. Kalan: ${firstIpucu.toStringAsFixed(0)}\nReklam izleyerek 2 ipucu alabilirsiniz.'),
              actions: [
                if (firstIpucu > 0)
                  TextButton(
                    onPressed: () {
                      giveHint();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Kullan',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Vazgeç',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    reklam.showRewardedAd(
                      reklamGoster,
                    );
                    // reklam izleme işlemi
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Reklam İzle',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //! Oyunu başlatma
  void initializeGame() async {
    Consts.kelimeListesi45678910.clear();
    Consts.kelimeListesi45678910 = await fetchWords();
    nextWord();
    setState(() {
      isLoaded = false;
    });
    
  }

  //! Yeni kelimeye geç
  void nextWord() {
    if (currentIndex < Consts.kelimeListesi45678910.length) {
      setState(() {
        kelime = Consts.kelimeListesi45678910[currentIndex];
        currentIndex++;

        controllers = List.generate(kelime["madde"].length, (index) {
          if (kelime["madde"][index] == ' ') {
            return TextEditingController(text: "|");
          } else {
            return TextEditingController();
          }
        });

        buttons = kelime["madde"].replaceAll(' ', '').split('')
          ..shuffle(random);
        enteredChars.clear();
      });
    } else {
      // Oyun bitti
      Methods.ustbildirimSucces(context, "Oyun bitti!");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainHome()),
          (route) => false);
    }
  }

  //! Kelimeleri fetch et
  Future<List<Map<String, dynamic>>> fetchWords() async {
    kelime = await DatabaseHelper.getWord(random.nextInt(99503) + 1);
    Map<String, dynamic> tempKelime;

    if (widget.oyunTuru == "mix") {
      tempKelime = await DatabaseHelper.getWordLenght(4);
      Consts.kelimeListesi45678910.add(tempKelime);
      tempKelime = await DatabaseHelper.getWordLenght(4);
      Consts.kelimeListesi45678910.add(tempKelime);
      tempKelime = await DatabaseHelper.getWordLenght(5);
      Consts.kelimeListesi45678910.add(tempKelime);
      tempKelime = await DatabaseHelper.getWordLenght(5);
      Consts.kelimeListesi45678910.add(tempKelime);
      tempKelime = await DatabaseHelper.getWordLenght(6);
      Consts.kelimeListesi45678910.add(tempKelime);
      tempKelime = await DatabaseHelper.getWordLenght(6);
      Consts.kelimeListesi45678910.add(tempKelime);
      tempKelime = await DatabaseHelper.getWordLenght(7);
      Consts.kelimeListesi45678910.add(tempKelime);
      tempKelime = await DatabaseHelper.getWordLenght(7);
      Consts.kelimeListesi45678910.add(tempKelime);
      /* tempKelime = await DatabaseHelper.getWordLenght(8);
    Consts.kelimeListesi45678910.add(tempKelime);
    tempKelime = await DatabaseHelper.getWordLenght(8);
    Consts.kelimeListesi45678910.add(tempKelime);
    */
    } else if (widget.oyunTuru == "2") {
      for (int i = 0; i < 10; i++) {
        tempKelime = await DatabaseHelper.getWordLenght(2);
        Consts.kelimeListesi45678910.add(tempKelime);
      }
    } else if (widget.oyunTuru == "3") {
      for (int i = 0; i < 10; i++) {
        tempKelime = await DatabaseHelper.getWordLenght(3);
        Consts.kelimeListesi45678910.add(tempKelime);
      }
    } else if (widget.oyunTuru == "4") {
      for (int i = 0; i < 10; i++) {
        tempKelime = await DatabaseHelper.getWordLenght(4);
        Consts.kelimeListesi45678910.add(tempKelime);
      }
    } else if (widget.oyunTuru == "5") {
      for (int i = 0; i < 10; i++) {
        tempKelime = await DatabaseHelper.getWordLenght(5);
        Consts.kelimeListesi45678910.add(tempKelime);
      }
    } else if (widget.oyunTuru == "6") {
      for (int i = 0; i < 10; i++) {
        tempKelime = await DatabaseHelper.getWordLenght(6);
        Consts.kelimeListesi45678910.add(tempKelime);
      }
    } else if (widget.oyunTuru == "7") {
      for (int i = 0; i < 10; i++) {
        tempKelime = await DatabaseHelper.getWordLenght(7);
        Consts.kelimeListesi45678910.add(tempKelime);
      }
    } else if (widget.oyunTuru == "8") {
      for (int i = 0; i < 10; i++) {
        tempKelime = await DatabaseHelper.getWordLenght(8);
        Consts.kelimeListesi45678910.add(tempKelime);
      }
    } else if (widget.oyunTuru == "9") {
      for (int i = 0; i < 10; i++) {
        tempKelime = await DatabaseHelper.getWordLenght(9);
        Consts.kelimeListesi45678910.add(tempKelime);
      }
    } else if (widget.oyunTuru == "10") {
      for (int i = 0; i < 10; i++) {
        tempKelime = await DatabaseHelper.getWordLenght(10);
        Consts.kelimeListesi45678910.add(tempKelime);
      }
    }

    // Her bir karakter için text controller oluşturma
    controllers = List.generate(kelime["madde"].length, (index) {
      if (kelime["madde"][index] == ' ') {
        return TextEditingController(text: "|");
      } else {
        return TextEditingController();
      }
    });

    buttons = kelime["madde"].replaceAll(' ', '').split('')..shuffle(random);
    enteredChars.clear();
    setState(() {});
    return Consts.kelimeListesi45678910;
  }
}
