import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kelime_oyunu/const/consts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IstatislikScreen extends StatefulWidget {
  IstatislikScreen({Key? key}) : super(key: key);

  @override
  IstatislikScreenState createState() => IstatislikScreenState();
}

class IstatislikScreenState extends State<IstatislikScreen> {
  List<GameData> yanlisDeneme = [];
  List<GameData> ipucuSayisi = [];
  double yanlisDenemeToplam = 0.0;
  double dogruSayisiToplam = 0.0;
  List<GameData> toplamlar = [];
  List<GameData> oyunTuru = [];

  @override
  void initState() {
    super.initState();

    /* for (int i = 0; i <= 4; i++) {
      UserGameModel userGameModel = UserGameModel.empty();
      userGameModel.dogruSayisi = i * 10;
      userGameModel.denemeSayisi = i * 10 / 2;
      Consts.user!.kullaniciOyunlari!.add(userGameModel);
    }*/

    for (int i = 0; i < Consts.user!.kullaniciOyunlari!.length; i++) {
      yanlisDenemeToplam += Consts.user!.kullaniciOyunlari![i].denemeSayisi!;
      dogruSayisiToplam += Consts.user!.kullaniciOyunlari![i].dogruSayisi!;
    }
    toplamlar.add(GameData('Doğru', dogruSayisiToplam));
    toplamlar.add(GameData('Yanlış', yanlisDenemeToplam));

    // const userin son 5 oyununun istatistikleri

    for (var temp in Consts.user!.kullaniciOyunlari!
        .skip(max(0, Consts.user!.kullaniciOyunlari!.length - 5))) {
      yanlisDeneme.add(GameData(
          'Oyun ${Consts.user!.kullaniciOyunlari!.indexOf(temp) + 1}',
          temp.denemeSayisi!.toDouble()));
      ipucuSayisi.add(GameData(
          'Oyun ${Consts.user!.kullaniciOyunlari!.indexOf(temp) + 1}',
          temp.ipucuSayisi!.toDouble()));
    }

    /* for (int i = Consts.user!.kullaniciOyunlari!.length - 1;
        i >= Consts.user!.kullaniciOyunlari!.length - 5;
        i--) {
      if (i == Consts.user!.kullaniciOyunlari!.length - 1) {
        yanlisDeneme.add(GameData('En Son',
            Consts.user!.kullaniciOyunlari![i + 1].denemeSayisi!.toDouble()));
        dogruSayisi.add(GameData('En Son',
            Consts.user!.kullaniciOyunlari![i + 1].dogruSayisi!.toDouble()));
      } else {
        yanlisDeneme.add(GameData(
            'Son ${Consts.user!.kullaniciOyunlari!.length - i}.',
            Consts.user!.kullaniciOyunlari![i + 1].denemeSayisi!.toDouble()));
        dogruSayisi.add(GameData(
            'Son ${Consts.user!.kullaniciOyunlari!.length - i}.',
            Consts.user!.kullaniciOyunlari![i + 1].dogruSayisi!.toDouble()));
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İstatistikler', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[700],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Card(
                elevation: 5,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: 'Son 5 oyunun istatislikleri'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<GameData, String>>[
                    RangeColumnSeries<GameData, String>(
                      dataSource: yanlisDeneme,
                      color: Colors.red,
                      xValueMapper: (GameData gd, _) => gd.game,
                      highValueMapper: (GameData gd, _) => gd.score,
                      lowValueMapper: (GameData gd, _) => 0,
                      name: 'Yanlış Deneme',
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                    RangeColumnSeries<GameData, String>(
                      dataSource: ipucuSayisi,
                      color: Colors.indigo,
                      xValueMapper: (GameData gd, _) => gd.game,
                      highValueMapper: (GameData gd, _) => gd.score,
                      lowValueMapper: (GameData gd, _) => 0,
                      name: 'Alınan İpucu',
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Card(
                elevation: 5,
                child: SfCircularChart(
                    title: ChartTitle(text: 'Tüm Zamanlar'),
                    legend: Legend(isVisible: true),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <DoughnutSeries<GameData, String>>[
                      DoughnutSeries<GameData, String>(
                        dataSource: toplamlar,
                        xValueMapper: (GameData data, _) => data.game,
                        yValueMapper: (GameData data, _) => data.score,
                        dataLabelMapper: (GameData data, _) =>
                            data.game + ' : ' + data.score.toStringAsFixed(0),
                        strokeColor: Colors.white,
                        strokeWidth: 2,
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.outside,
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameData {
  GameData(this.game, this.score);

  final String game;
  final double score;
}
