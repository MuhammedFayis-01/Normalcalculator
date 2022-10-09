import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:mycalculator/Mybutton.dart';

String userQuestion = '';
String answer = '';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mycalculator(),
    );
  }
}

class Mycalculator extends StatefulWidget {
  @override
  State<Mycalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<Mycalculator> {
  bool isOperator(String x) {
    if (x == "+" ||
        x == "-" ||
        x == "*" ||
        x == "/" ||
        x == "%" ||
        x == "+/-") {
      return true;
    }
    return false;
  }

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    print(buttons.length);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff000019),
        body: Column(
          children: [
            Expanded(
                child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        userQuestion,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      child: Text(
                        answer,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      alignment: Alignment.topRight,
                    )
                  ],
                ),
              ),
            )),
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return MyButton(
                              ontap: (() {
                                setState(() {
                                  userQuestion = "";
                                  answer = "";
                                });
                              }),
                              color: Color(0xff800000),
                              text: buttons[index],
                              textColor: Colors.deepPurple.shade50);
                        } else if (index == 1) {
                          return MyButton(
                            ontap: () {
                              setState(() {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                              });
                            },
                            color: Color(0xff800000),
                            text: buttons[index],
                            textColor: Colors.deepPurple.shade50,
                          );
                        } else if (index == buttons.length - 1) {
                          return MyButton(
                            ontap: () {
                              setState(() {
                                equalPressed();
                              });
                            },
                            color: Color(0xff114111),
                            text: buttons[index],
                            textColor: Colors.deepPurple.shade50,
                          );
                        }
                        return MyButton(
                            ontap: () {
                              setState(() {
                                userQuestion += buttons[index];
                              });
                            },
                            color: isOperator(buttons[index])
                                ? Color(0xff114111)
                                : Colors.deepPurple.shade50,
                            text: buttons[index],
                            textColor: isOperator(buttons[index])
                                ? Colors.deepPurple.shade50
                                : Colors.black);
                      }),
                )),
          ],
        ),
      ),
    );
  }
}

void equalPressed() {
  var finalQuestion = userQuestion;
  Parser p = Parser();
  Expression exp = p.parse(finalQuestion);

  ContextModel cm = ContextModel();
  double eval = exp.evaluate(EvaluationType.REAL, cm);
  answer = eval.toString();
}
