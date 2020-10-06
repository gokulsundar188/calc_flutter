import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant_terms.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyCalcPage(),
    );
  }
}

class MyCalcPage extends StatefulWidget {
  @override
  _MyCalcPageState createState() => _MyCalcPageState();
}

class _MyCalcPageState extends State<MyCalcPage> {
  var _output = '0';
  String _out = '0';
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operand = "";

  buttonPressed(String btnVal) {
    if (btnVal == 'C') {
      _out = '0';
      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
    } else if (btnVal == '%') {
      _out = (double.parse(_output) / 100).toString();
      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
    } else if (btnVal == '±') {
      _out = (double.parse(_output) * -1).toString();
      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
    } else if (btnVal == '⌫') {
      _out = _output.substring(0, _output.length - 1);
      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
    } else if (btnVal == '+' ||
        btnVal == '-' ||
        btnVal == '×' ||
        btnVal == '÷') {
      _num1 = double.parse(_output);
      _operand = btnVal;
      _out = "0";
      _output = _output + btnVal;
    } else if (btnVal == '.') {
      if (_out.contains('.')) {
        return;
      } else {
        _out = _out + btnVal;
      }
    } else if (btnVal == '=') {
      _num2 = double.parse(_output);
      if (_operand == '+') {
        _out = (_num1 + _num2).toString();
      } else if (_operand == '-') {
        _out = (_num1 - _num2).toString();
      } else if (_operand == '×') {
        _out = (_num1 * _num2).toString();
      } else if (_operand == '÷') {
        _out = (_num1 / _num2).toString();
      }
      _num1 = 0.0;
      _num2 = 0.0;
    } else {
      _out = _out + btnVal;
    }

    setState(() {
      if (!_out.contains('.')) {
        _output = int.parse(_out).toString();
      } else {
        _output = double.parse(_out).toString();
      }
    });
  }

  Widget buildButton(String buttonVal, MediaQueryData mediaQuery, Color colorBg,
      Color colorText) {
    return Expanded(
      child: Container(
        child: RawMaterialButton(
          onPressed: () => buttonPressed(buttonVal),
          elevation: 2.0,
          fillColor: colorBg,
          padding: EdgeInsets.all(mediaQuery.size.shortestSide / 20),
          shape: CircleBorder(),
          child: FittedBox(
            child: Text(
              buttonVal,
              style: TextStyle(
                  color: colorText,
                  fontSize: buttonVal == '⌫'
                      ? mediaQuery.size.shortestSide < 350
                          ? 24 * mediaQuery.textScaleFactor
                          : 28 * mediaQuery.textScaleFactor
                      : mediaQuery.size.shortestSide < 350
                          ? 28 * mediaQuery.textScaleFactor
                          : 32 * mediaQuery.textScaleFactor),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaleFactor;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      right: mediaQuery.size.width * 0.01,
                      left: mediaQuery.size.width * 0.01,
                    ),
                    // Display Container
                    constraints: BoxConstraints.expand(
                      // Creating a boxed container
                      height: mediaQuery.size.height < 400
                          ? (mediaQuery.size.height - mediaQuery.padding.top) *
                              0.175
                          : (mediaQuery.size.height - mediaQuery.padding.top) *
                              0.25,
                    ),
                    alignment: Alignment.bottomRight,
                    // Aligning the text to the bottom right of our display screen
                    color: Colors.black,
                    // Setting the background color of the container
                    child: Expanded(
                      child: FittedBox(
                        child: Text(
                          _output,
                          style: TextStyle(
                              // Styling the text
                              fontSize: 60.0 * curScaleFactor,
                              color: color3),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: mediaQuery.size.height < 400
                  ? (mediaQuery.size.height - mediaQuery.padding.top) * 0.004
                  : (mediaQuery.size.height - mediaQuery.padding.top) * 0.02,
            ),
            Container(
              margin: EdgeInsets.only(
                right: mediaQuery.size.width * 0.01,
                left: mediaQuery.size.width * 0.01,
              ),
              child: Row(
                children: <Widget>[
                  buildButton('C', mediaQuery, color3, color1),
                  buildButton('÷', mediaQuery, color3, color1),
                  buildButton('×', mediaQuery, color3, color1),
                  buildButton('⌫', mediaQuery, color3, color1),
                ],
              ),
            ),
            SizedBox(
              height: mediaQuery.size.height < 350
                  ? (mediaQuery.size.height - mediaQuery.padding.top) * 0.004
                  : (mediaQuery.size.height - mediaQuery.padding.top) * 0.02,
            ),
            Container(
              margin: EdgeInsets.only(
                right: mediaQuery.size.width * 0.01,
                left: mediaQuery.size.width * 0.01,
              ),
              child: Row(
                children: <Widget>[
                  buildButton('7', mediaQuery, color4, color3),
                  buildButton('8', mediaQuery, color4, color3),
                  buildButton('9', mediaQuery, color4, color3),
                  buildButton('+', mediaQuery, color3, color1),
                ],
              ),
            ),
            SizedBox(
              height: mediaQuery.size.height < 400
                  ? (mediaQuery.size.height - mediaQuery.padding.top) * 0.004
                  : (mediaQuery.size.height - mediaQuery.padding.top) * 0.02,
            ),
            Container(
              margin: EdgeInsets.only(
                right: mediaQuery.size.width * 0.01,
                left: mediaQuery.size.width * 0.01,
              ),
              child: Row(
                children: <Widget>[
                  buildButton('4', mediaQuery, color4, color3),
                  buildButton('5', mediaQuery, color4, color3),
                  buildButton('6', mediaQuery, color4, color3),
                  buildButton('−', mediaQuery, color3, color1),
                ],
              ),
            ),
            SizedBox(
              height: mediaQuery.size.height < 400
                  ? (mediaQuery.size.height - mediaQuery.padding.top) * 0.004
                  : (mediaQuery.size.height - mediaQuery.padding.top) * 0.02,
            ),
            Container(
              margin: EdgeInsets.only(
                right: mediaQuery.size.width * 0.01,
                left: mediaQuery.size.width * 0.01,
              ),
              child: Row(
                children: <Widget>[
                  buildButton('1', mediaQuery, color4, color3),
                  buildButton('2', mediaQuery, color4, color3),
                  buildButton('3', mediaQuery, color4, color3),
                  buildButton('±', mediaQuery, color3, color1),
                ],
              ),
            ),
            SizedBox(
              height: mediaQuery.size.height < 400
                  ? (mediaQuery.size.height - mediaQuery.padding.top) * 0.004
                  : (mediaQuery.size.height - mediaQuery.padding.top) * 0.02,
            ),
            Container(
              margin: EdgeInsets.only(
                right: mediaQuery.size.width * 0.01,
                left: mediaQuery.size.width * 0.01,
              ),
              child: Row(
                children: <Widget>[
                  buildButton('%', mediaQuery, color4, color3),
                  buildButton('0', mediaQuery, color4, color3),
                  buildButton('.', mediaQuery, color4, color3),
                  buildButton('=', mediaQuery, color3, color1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
