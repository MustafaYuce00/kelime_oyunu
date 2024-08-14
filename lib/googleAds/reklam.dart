import 'package:google_mobile_ads/google_mobile_ads.dart';

class Reklam {
  static RewardedAd? rewardedAd;
  InterstitialAd? interstitialAd;
  
  final String adUnitId = "ca-app-pub-3940256099942544/5224354917";
  final String adUnitIdgecis = "ca-app-pub-3940256099942544/1033173712";

  void loadAdOdullu1() {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {
          print("Ödüllü reklam yüklenemedi");
        },
      ),
    );
  }

  void loadAdOdullu2() {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          // Ad loaded.
          rewardedAd = ad;
          print('Ad loaded.');
        },
        onAdFailedToLoad: (LoadAdError error) {
          // Ad failed to load.
          print('Ad failed to load: $error');
        },
      ),
    );
  }

  void showRewardedAd(Function onRewarded) {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {
          print('Ad showed.');
        },
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          ad.dispose();
          loadAdOdullu1(); // Yeni bir reklam yükle
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          ad.dispose();
          print('Ad failed to show: $error');
          loadAdOdullu1(); // Yeni bir reklam yükle
        },
        onAdImpression: (RewardedAd ad) {
          print('Ad impression.');
        },
      );

      rewardedAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        print('User earned reward: $reward');
        onRewarded(); // Kullanıcı ödülü kazandıktan sonra yapılacak işlemleri burada tanımlayın
      });

      rewardedAd = null; // Reklam gösterildikten sonra sıfırlayın
    } else {
      print('Rewarded ad is not ready yet.');
    }
  }

 //* geçiş reklamı
void loadAdGecis() {
  InterstitialAd.load(
    adUnitId: adUnitIdgecis,
    request: const AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (ad) {
        interstitialAd = ad;
      },
      onAdFailedToLoad: (LoadAdError error) {
        print('InterstitialAd failed to load: $error');
      },
    ),
  );
}

//* geçiş reklamı göster
void showGecisAd() {
  if (interstitialAd != null) {
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        print('Ad showed full screen content.');
      },
      onAdImpression: (ad) {
        print('Ad impression.');
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        print('Ad failed to show full screen content: $err');
        ad.dispose();
        interstitialAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        print('Ad dismissed full screen content.');
        ad.dispose();
        interstitialAd = null;
      },
      onAdClicked: (ad) {
        print('Ad clicked.');
      },
    );

    interstitialAd!.show();
    interstitialAd = null;
  } else {
    print('Tried to show ad before it was loaded.');
  }
}

}
