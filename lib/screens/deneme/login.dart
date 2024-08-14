import 'package:flutter/material.dart';
import 'package:kelime_oyunu/screens/mainHome.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isPasswordVisible1 = false;
  bool _isNewAccount = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();

  bool hesap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  hesap = false;
                  _isNewAccount = false;
                });
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/b1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.73 -
                        (hesap
                            ? MediaQuery.of(context).size.height * 0.65
                            : MediaQuery.of(context).size.height * 0.2),
                  ),
                  Text(
                    "Kelimelerle\ndolu bir maceraya\nçıkın!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Kelimelerin büyülü dünyasını keşfedin!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: hesap
                    ? MediaQuery.of(context).size.height * 0.5
                    : MediaQuery.of(context).size.height * 0.2,
                padding: EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.065,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            Colors.orange[700]!,
                          ),
                        ),
                        onPressed: () {
                          _isNewAccount = true;
                          setState(() {
                            hesap = true;
                          });
                        },
                        child: const Text(
                          'Yeni hesap oluştur —>',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        _isNewAccount = false;
                        setState(() {
                          hesap = true;
                        });
                      },
                      child: Text(
                        "Zaten hesabınız var mı?",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    hesap == true
                        ? Form(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    // add email validation
                                    if (value == null || value.isEmpty) {
                                      return 'Lütfen bir metin giriniz';
                                    }

                                    bool emailValid = RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value);
                                    if (!emailValid) {
                                      return 'Lütfen geçerli bir email giriniz';
                                    }

                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'Email giriniz',
                                    prefixIcon: Icon(Icons.email_outlined),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Lütfen bir şifre giriniz';
                                    }

                                    if (value.length < 6) {
                                      return 'Şifre en az 6 karakter olmalıdır';
                                    }
                                    return null;
                                  },
                                  obscureText: !_isPasswordVisible,
                                  decoration: InputDecoration(
                                      labelText: 'Şifre',
                                      hintText: 'Şifre giriniz',
                                      prefixIcon: const Icon(
                                          Icons.lock_outline_rounded),
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        icon: Icon(_isPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordVisible =
                                                !_isPasswordVisible;
                                          });
                                        },
                                      )),
                                ),
                                const SizedBox(height: 16),
                                _isNewAccount == true
                                    ? TextFormField(
                                        controller: _passwordController1,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Lütfen bir şifre giriniz';
                                          }

                                          if (value.length < 6) {
                                            return 'Şifre en az 6 karakter olmalıdır';
                                          }
                                          if (value !=
                                              _passwordController.text) {
                                            return 'Şifreler uyuşmuyor';
                                          }
                                          return null;
                                        },
                                        obscureText: !_isPasswordVisible1,
                                        decoration: InputDecoration(
                                            labelText: 'Şifre Tekrar',
                                            hintText: 'Şifre giriniz',
                                            prefixIcon: const Icon(
                                                Icons.lock_outline_rounded),
                                            border: const OutlineInputBorder(),
                                            suffixIcon: IconButton(
                                              icon: Icon(_isPasswordVisible1
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                              onPressed: () {
                                                setState(() {
                                                  _isPasswordVisible1 =
                                                      !_isPasswordVisible1;
                                                });
                                              },
                                            )),
                                      )
                                    : Container(),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange[700],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          side: BorderSide(
                                              color: Colors.orange[700]!)),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'Giriş Yap',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainHome(),
                                          ),
                                          (route) => false);
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        /// do something
                                        ///
                                        //! kontroller yapılacak
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
