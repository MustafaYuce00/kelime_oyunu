import 'package:flutter/material.dart';
import 'package:kelime_oyunu/const/consts.dart';
import 'package:kelime_oyunu/model/user.dart';
import 'package:kelime_oyunu/screens/deneme/login.dart';
import 'package:kelime_oyunu/screens/mainHome.dart';
import 'package:uuid/uuid.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(pages: [
        OnboardingPageModel(
          title: 'Kelime Oyunları',
          description:
              '100,000\'den fazla kelime ile eğlenceli kelime oyunları oynayın.',
          imageUrl: 'assets/A.png',
          bgColor: Color(0xFFFF9800), //7ed957
        ), //e7e8fd   c7c9f7  a6a6ee   e3e2ff
        OnboardingPageModel(
          title: 'Sözlük',
          description:
              'Türkçe kelimelerin anlamlarını keşfedin ve kelime haznenizi genişletin.',
          imageUrl: 'assets/A1.png',
          bgColor: Colors.red,
        ),
        OnboardingPageModel(
          title: 'Atasözleri ve Deyimler',
          description:
              'Türk kültürünün zengin atasözleri ve deyimlerini öğrenin.',
          imageUrl: 'assets/A.gif',
          bgColor: const Color(0xfff7c04a),
        ),
        OnboardingPageModel(
          title: 'Puanlar ve Sıralama',
          description:
              'Oyunları tamamlayarak puan kazanın ve global sıralamada yerinizi alın.',
          imageUrl: 'assets/A3.png',
          bgColor: Color(0xff64c8c0),
        ),
      ]),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;
  final VoidCallback? onSkip;
  final VoidCallback? onFinish;

  const OnboardingPagePresenter(
      {super.key, required this.pages, this.onSkip, this.onFinish});

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Pageview to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    // Change current page when pageview changes
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Image.asset(
                              item.imageUrl,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: item.textColor,
                                        )),
                              ),
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(item.description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: item.textColor,
                                        )),
                              )
                            ]))
                      ],
                    );
                  },
                ),
              ),

              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages
                    .map((item) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: _currentPage == widget.pages.indexOf(item)
                              ? 30
                              : 8,
                          height: 8,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                        ))
                    .toList(),
              ),

              // Bottom buttons
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            visualDensity: VisualDensity.comfortable,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          widget.onSkip?.call();
                          _pageController.animateToPage(widget.pages.length - 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250));
                          /*   _pageController.animateToPage(_currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250));
                              */
                        },
                        child: const Text("Atla")),
                    TextButton(
                      style: TextButton.styleFrom(
                          visualDensity: VisualDensity.comfortable,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (_currentPage == widget.pages.length - 1) {
                          //  widget.onFinish?.call();
                          //!Method ile burda user oluşturalım ve mainhome sayfasına yönlendirelim
                          userCreate();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainHome()));
                        } else {
                          _pageController.animateToPage(_currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250));
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            _currentPage == widget.pages.length - 1
                                ? "Başla"
                                : "İleri",
                          ),
                          const SizedBox(width: 8),
                          Icon(_currentPage == widget.pages.length - 1
                              ? Icons.done
                              : Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void userCreate() {
    UserModel userModel = UserModel.empty();
    userModel.id = Uuid().v4();
    userModel.name = "Guest${userModel.id!.substring(0, 5)}";
    userModel.image = "assets/profil.png";
    userModel.role = "user";
    userModel.status = "active";
    userModel.lastLogin = DateTime.now();
    userModel.lastLogout = DateTime.now();
    userModel.lastActivity = DateTime.now();
    userModel.kullaniciOyunlari = [];

    Consts.user = userModel;
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final String imageUrl;
  final Color bgColor;
  final Color textColor;

  OnboardingPageModel(
      {required this.title,
      required this.description,
      required this.imageUrl,
      this.bgColor = Colors.blue,
      this.textColor = Colors.white});
}
