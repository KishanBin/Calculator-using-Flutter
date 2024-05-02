import 'package:calculator/Ui%20helper.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class UI extends StatefulWidget {
  const UI({super.key});

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  bool Darkmode = false;
  var InputText = '';
  var Result = '';
  var error = '';

  // var error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: backGround,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(10),
              child: Text(
                InputText,
                style: TextStyle(fontSize: 40, color: inputColor),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(10),
              child: Text(
                Result,
                style: TextStyle(fontSize: 30, color: resultColor),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 200,
                      child: Text(
                        error,
                        style: TextStyle(fontSize: 15, color: inputColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Switch(
                        value: Darkmode,
                        activeColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            if (Darkmode == false) {
                              // For Dark Mode
                              numBtn = Colors.white;
                              opratBtn = Colors.orange;
                              backGround = Color(0xff374352);
                              btnColor = Color(0xff374352);
                              inputColor = Colors.white70;
                              resultColor = Colors.white70;
                              upbtnShadow = Color(0xff44505D);
                              downBtnShadow = Color(0xff2E3945);
                              Darkmode = true;
                            } else {
                              // For Light Mode
                              numBtn = Colors.black;
                              opratBtn = Colors.blue;
                              backGround = Colors.white70;
                              btnColor = Colors.white70;
                              inputColor = Colors.black;
                              resultColor = Colors.black87;
                              upbtnShadow = Colors.white;
                              downBtnShadow = Colors.blue[200];
                              Darkmode = false;
                            }
                            ;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonUI(
                  text: 'AC',
                  textColor: opratBtn,
                ),
                buttonUI(
                  text: '%',
                  textColor: opratBtn,
                ),
                buttonUI(
                  text: 'C',
                  textColor: opratBtn,
                ),
                buttonUI(
                  text: '/',
                  textColor: opratBtn,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonUI(
                  text: '7',
                  textColor: numBtn,
                ),
                buttonUI(
                  text: '8',
                  textColor: numBtn,
                ),
                buttonUI(
                  text: '9',
                  textColor: numBtn,
                ),
                buttonUI(
                  text: 'X',
                  textColor: opratBtn,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonUI(
                  text: '4',
                  textColor: numBtn,
                ),
                buttonUI(
                  text: '5',
                  textColor: numBtn,
                ),
                buttonUI(
                  text: '6',
                  textColor: numBtn,
                ),
                buttonUI(
                  text: '-',
                  textColor: opratBtn,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonUI(
                  text: '3',
                  textColor: numBtn,
                ),
                buttonUI(
                  text: '2',
                  textColor: numBtn,
                ),
                buttonUI(
                  text: '1',
                  textColor: numBtn,
                ),
                buttonUI(
                  text: '+',
                  textColor: opratBtn,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonUI(
                  text: '00',
                  textColor: numBtn,
                ),
                buttonUI(
                  text: '0',
                  textColor: numBtn,
                ),
                buttonUI(
                  text: '.',
                  textColor: numBtn,
                ),
                buttonUI(
                  text: '=',
                  textColor: opratBtn,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Custom Calculation Button

  //var decor = ;

  var boxSize = 70.0;

  var margin = const EdgeInsets.all(10);

  var textFontSize = 25.0;

  Widget buttonUI({required text, textColor}) {
    return InkWell(
      onTap: () => calOperation(text),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: margin,
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          color: btnColor,
          border: Border.all(color: Colors.black12, width: 0.2),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: upbtnShadow!,
              blurRadius: 10,
              offset: Offset(-5, -5),
            ),
            BoxShadow(
                color: downBtnShadow!.withOpacity(0.5),
                blurRadius: 10,
                offset: Offset(5, 5)),
          ],
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: textFontSize,
          ),
        )),
      ),
    );
  }

  // functon to perform calculation
  void calOperation(value) {
    setState(() {
      if (value == "AC") {
        InputText = "";
        Result = "";
      } else if (value == "C") {
        if (value.isNotEmpty) {
          InputText = InputText.substring(0, InputText.length - 1);
        } else {
          InputText = '';
        }
      } else if (value == "=") {
        if (value.isNotEmpty) {
          var userInput = InputText.replaceAll("X", "*");
          try {
            Parser p = Parser();
            Expression expression = p.parse(userInput);
            ContextModel cm = ContextModel();
            var finalValue = expression.evaluate(EvaluationType.REAL, cm);
            Result = finalValue.toString();
            if (Result.endsWith('.0')) {
              Result = Result.substring(0, Result.length - 2);
            }
            InputText = Result;
            error = "";
          } catch (e) {
            var x = e.toString();
            if (x.isNotEmpty) {
              error = 'Expression error';
            }
          }
        }
      } else {
        InputText = InputText + value;
      }
    });
  }
}
