import 'dart:math';

import 'package:codeverifyemail/src/pages/code_is_completed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({Key? key}) : super(key: key);

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final qtdeCodes = 6;

  int finalCode = 0;

  int? code1;
  int? code2;
  int? code3;
  int? code4;
  int? code5;
  int? code6;

  @override
  void initState() {
    super.initState();
    finalCode = Random().nextInt(999999);
    // checkIsCodeCompleted();
  }

  bool checkIsCodeRigth() {
    var arrCodes = [
      code1 ?? 0,
      code2 ?? 0,
      code3 ?? 0,
      code4 ?? 0,
      code5 ?? 0,
      code6 ?? 0
    ].join("");

    var parsedCode = int.parse(arrCodes);

    debugPrint("parsedCode: $parsedCode");
    var result = parsedCode == finalCode;
    return result;
  }

  bool checkIsCodeCompleted() {
    var result = code1 != null &&
        code2 != null &&
        code3 != null &&
        code4 != null &&
        code5 != null &&
        code6 != null;
    debugPrint("checkIsCodeCompleted: $result");
    return result;
  }

  void goToIsCompletedPage() {
    debugPrint(
        "goToIsCompletedPage - checkIsCodeCompleted(): ${checkIsCodeCompleted()}");

    debugPrint(
        "goToIsCompletedPage - checkIsCodeRigth(): ${checkIsCodeRigth()}");

    if (checkIsCodeCompleted() && checkIsCodeRigth()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CodeIsCompletedPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF33363e),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Verificar seu número",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Digite o código de $qtdeCodes digitos que nós enviamos para o seu telefone",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Code: $finalCode",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SvgPicture.asset(
                    "assets/phone.svg",
                    semanticsLabel: 'Phone icon.',
                    currentColor: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 40,
                      child: TextField(
                        // maxLength: 1,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        cursorColor: const Color(0xFF3b3784),
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (newValue) => setState(() {
                          var parsedValue = int.tryParse(newValue);
                          if (parsedValue != null) {
                            code1 = parsedValue;
                            FocusScope.of(context).nextFocus();
                            debugPrint("=====================");
                            debugPrint("Code 1: $code1");
                            goToIsCompletedPage();
                          }
                        }),
                        style: const TextStyle(
                          color: Color(0xFF3b3784),
                          fontWeight: FontWeight.bold,
                          decorationColor: Color(0xFF3b3784),
                        ),
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                              width: 3.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        // maxLength: 1,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        cursorColor: const Color(0xFF3b3784),
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (newValue) => setState(() {
                          var parsedValue = int.tryParse(newValue);
                          if (parsedValue != null) {
                            code2 = parsedValue;
                            FocusScope.of(context).nextFocus();
                            debugPrint("=====================");
                            debugPrint("Code 2: $code2");
                            goToIsCompletedPage();
                          }
                        }),
                        style: const TextStyle(
                          color: Color(0xFF3b3784),
                          fontWeight: FontWeight.bold,
                          decorationColor: Color(0xFF3b3784),
                        ),
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                              width: 3.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        // maxLength: 1,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        cursorColor: const Color(0xFF3b3784),
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (newValue) => setState(() {
                          var parsedValue = int.tryParse(newValue);
                          if (parsedValue != null) {
                            code3 = parsedValue;
                            FocusScope.of(context).nextFocus();
                            debugPrint("=====================");
                            debugPrint("Code 3: $code3");
                            goToIsCompletedPage();
                          }
                        }),
                        style: const TextStyle(
                          color: Color(0xFF3b3784),
                          fontWeight: FontWeight.bold,
                          decorationColor: Color(0xFF3b3784),
                        ),
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                              width: 3.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40,
                      child: TextField(
                        // maxLength: 1,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        cursorColor: const Color(0xFF3b3784),
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (newValue) => setState(() {
                          var parsedValue = int.tryParse(newValue);
                          if (parsedValue != null) {
                            code4 = parsedValue;
                            FocusScope.of(context).nextFocus();
                            debugPrint("=====================");
                            debugPrint("Code 4: $code4");
                            goToIsCompletedPage();
                          }
                        }),
                        style: const TextStyle(
                          color: Color(0xFF3b3784),
                          fontWeight: FontWeight.bold,
                          decorationColor: Color(0xFF3b3784),
                        ),
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                              width: 3.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        // maxLength: 1,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        cursorColor: const Color(0xFF3b3784),
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (newValue) => setState(() {
                          var parsedValue = int.tryParse(newValue);
                          if (parsedValue != null) {
                            code5 = parsedValue;
                            FocusScope.of(context).nextFocus();
                            debugPrint("=====================");
                            debugPrint("Code 5: $code5");
                            goToIsCompletedPage();
                          }
                        }),
                        style: const TextStyle(
                          color: Color(0xFF3b3784),
                          fontWeight: FontWeight.bold,
                          decorationColor: Color(0xFF3b3784),
                        ),
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                              width: 3.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        // maxLength: 1,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        autofocus: true,
                        cursorColor: const Color(0xFF3b3784),
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (newValue) => setState(() {
                          var parsedValue = int.tryParse(newValue);
                          if (parsedValue != null) {
                            code6 = parsedValue;
                            FocusScope.of(context).nextFocus();
                            debugPrint("=====================");
                            debugPrint("Code 6: $code6");
                            goToIsCompletedPage();
                          }
                        }),
                        style: const TextStyle(
                          color: Color(0xFF3b3784),
                          fontWeight: FontWeight.bold,
                          decorationColor: Color(0xFF3b3784),
                        ),
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3b3784),
                              width: 3.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
