import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Simple Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "0";
  String _output = "0";
  double num1;
  double num2;
  String operand = "";
  String equation = "";

  void buttonPressed(String buttonText) {
    if (equation.contains("=")) {
      equation = "";
    }
    if (buttonText == "Clear") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
      equation = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "X" ||
        buttonText == "%") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
      equation = equation + output + " " + buttonText + " ";
    } else if (buttonText == ".") {
      if (!(_output.contains("."))) {
        _output += buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "X") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }
      if (operand == "%") {
        _output = (num1 % num2).toString();
      }
      num1 = 0;
      num2 = 0;
      operand = "";
      if (output == "0") {
        equation = equation + " " + buttonText + " ";
      } else {
        equation = equation + output + " " + buttonText + " ";
      }
    } else {
      _output += buttonText;
    }
    isInteger(String num) {
      List<String> split = num.split(".");
      if (double.parse(split[1]) == 0) {
        return true;
      }
      return false;
    }

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
      if (isInteger(output)) {
        output = output.split(".")[0];
      }
    });
  }

  Widget createButton(String buttonText, Color color) {
    return Expanded(
      child: OutlinedButton(
          //padding: EdgeInsets.all(24.0),
          style: OutlinedButton.styleFrom(
            primary: Colors.black,
            backgroundColor: color,
            padding: EdgeInsets.all(24.0),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
          onPressed: () => buttonPressed(buttonText)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color defaultColor = Colors.blue[100];
    Color operation = Colors.blue[200];
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                padding: new EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 12.0,
                ),
                child: Text(equation,
                    style: new TextStyle(
                      fontSize: 38.0,
                    )),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: new EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 12.0,
                ),
                child: Text(output,
                    style: new TextStyle(
                      fontSize: 40.0,
                    )),
              ),
              Expanded(
                child: Divider(),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      createButton("7", defaultColor),
                      createButton("8", defaultColor),
                      createButton("9", defaultColor),
                      createButton("+", operation)
                    ],
                  ),
                  Row(
                    children: [
                      createButton("4", defaultColor),
                      createButton("5", defaultColor),
                      createButton("6", defaultColor),
                      createButton("-", operation)
                    ],
                  ),
                  Row(
                    children: [
                      createButton("1", defaultColor),
                      createButton("2", defaultColor),
                      createButton("3", defaultColor),
                      createButton("X", operation)
                    ],
                  ),
                  Row(
                    children: [
                      createButton("0", defaultColor),
                      createButton(".", defaultColor),
                      createButton("%", defaultColor),
                      createButton("/", operation)
                    ],
                  ),
                  Row(
                    children: [
                      createButton("Clear", operation),
                      createButton("=", operation)
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
