import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Color? numColor = Colors.grey[800];
  final Color? initColor = Colors.grey[900];
  final Color? calculateColor = const Color(0xFFff9502);

  final TextStyle textStyle = TextStyle(
    fontSize: 40,
    color: Colors.white.withOpacity(0.8),
  );

  List<String> equalRePush = [];
  String variableValueAfter = "0";
  num variableValueBefore = 0;

  bool operateBtn = false;

  bool plusState = false;
  bool minusState = false;
  bool multiplyState = false;
  bool divideState = false;

  void initOperateState() {
    plusState = false;
    minusState = false;
    multiplyState = false;
    divideState = false;
  }

  void initVariableValue() {
    variableValueAfter = "0";
  }

  void onClickACBtn() {
    variableValueBefore = 0;
    initVariableValue();
    initOperateState();
    setState(() {});
  }

  void onDecimalPoint() {
    if (variableValueAfter.contains('.')) {
      return;
    }
    variableValueAfter += ".";
    setState(() {});
  }

  convertDecimalToInt(num decimal) {
    if (decimal != decimal.round()) {
      return decimal;
    }
    return decimal.toInt();
  }

  void onClickNumberBtn(String value) {
    if (operateBtn) {
      operateBtn = false;
      initVariableValue();
    }
    if (variableValueAfter == "0" && variableValueAfter.length == 1) {
      variableValueAfter = '';
    }
    variableValueAfter += value;
    setState(() {});
  }

  //사칙연산 버튼
  void onClickOperateBtn(String type) {
    num after = num.parse(variableValueAfter);
    initOperateState(); //사칙연산 버튼 초기화
    if (variableValueBefore != 0) {
      switch (type) {
        case "+":
          variableValueBefore += after;
          break;
        case "―":
          variableValueBefore -= after;
          break;
        case "x":
          variableValueBefore *= after;
          break;
        case "/":
          variableValueBefore /= after;
          break;
      }
      variableValueAfter = variableValueBefore.toString();
    } else {
      variableValueBefore =
          num.parse(variableValueAfter); //=가 아닌 사칙연산버튼만 눌러도 자동 계산되게 하기!
    }
    initOperateState(); //사칙연산 버튼 클릭 시 모든 연산 버튼 false 만들어 주고 나서 받아온 타입만 true로 변경!
    switch (type) {
      case "+":
        plusState = true;
        break;
      case "―":
        minusState = true;
        break;
      case "x":
        multiplyState = true;
        break;
      case "/":
        divideState = true;
        break;
    }
    operateBtn = true; //variableValueAfter을 0으로 만들고->""이 되면서 새로운 화면 출력 값 만듦!
    setState(() {});
  }

  void onClickEqualBtn() {
    num after = num.parse(variableValueAfter);
    equalRePush.add(variableValueAfter);
    // print("= 버튼 State 값 : $minusState");

    if (plusState) {
      if (variableValueBefore == 0) {
        variableValueAfter = (convertDecimalToInt(
                (num.parse(variableValueAfter) + num.parse(equalRePush[0])))
            .toString());
      } else {
        variableValueAfter =
            (convertDecimalToInt(variableValueBefore + after)).toString();
      }
    } else if (minusState) {
      if (variableValueBefore == 0) {
        variableValueAfter =
            (num.parse(variableValueAfter) - num.parse(equalRePush[0]))
                .toString();
      } else {
        variableValueAfter =
            (convertDecimalToInt(variableValueBefore - after)).toString();
      }
    } else if (multiplyState) {
      if (variableValueBefore == 0) {
        variableValueAfter =
            (num.parse(variableValueAfter) * num.parse(equalRePush[0]))
                .toString();
      } else {
        variableValueAfter =
            (convertDecimalToInt(variableValueBefore * after)).toString();
      }
    } else if (divideState) {
      if (num.parse(variableValueAfter) == 0) {
        variableValueAfter = "숫자 아님";
      } else if (variableValueBefore == 0) {
        variableValueAfter =
            (num.parse(variableValueAfter) / num.parse(equalRePush[0]))
                .toString();
      } else {
        variableValueAfter =
            (convertDecimalToInt(variableValueBefore / after)).toString();
      }
    }
    variableValueBefore = 0; //variableValueBefore 화면의 variableValueAfter
    operateBtn = true; //variableValueAfter을 0으로 만들고->""이 되면서 새로운 화면 출력 값 만듦!
    setState(() {});

    // print("= 버튼 equalRePush 값!!! : $equalRePush");
    // print("= 버튼 variableValueBefore 값!!! : $variableValueBefore");
    // print("= 버튼 variableValueAfter 값!!! : $variableValueAfter");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 340,
              alignment: const Alignment(0.9, 1.4),
              child: Text(
                variableValueAfter,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: variableValueAfter.length > 7 ? 60 : 100,
                    fontWeight: FontWeight.w200),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: GridView.extent(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 1.5,
                  mainAxisSpacing: 1.5,
                  maxCrossAxisExtent: 120,
                  children: [
                    TextButton(
                      onPressed: onClickACBtn,
                      style: TextButton.styleFrom(backgroundColor: initColor),
                      child: Text(
                        variableValueAfter == "0" ? "AC" : "C",
                        style: textStyle,
                      ),
                    ),
                    Container(
                      color: initColor,
                    ),
                    Container(
                      color: initColor,
                    ),
                    TextButton(
                      onPressed: () => onClickOperateBtn("/"),
                      style:
                          TextButton.styleFrom(backgroundColor: calculateColor),
                      child: Text(
                        '÷',
                        style: textStyle,
                      ),
                    ),
                    TextButton(
                      onPressed: () => onClickNumberBtn("7"),
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('7', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () => onClickNumberBtn("8"),
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('8', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () => onClickNumberBtn("9"),
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('9', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () => onClickOperateBtn("x"),
                      style:
                          TextButton.styleFrom(backgroundColor: calculateColor),
                      child: Text('x', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () => onClickNumberBtn("4"),
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('4', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () => onClickNumberBtn("5"),
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('5', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () => onClickNumberBtn("6"),
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('6', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () => onClickOperateBtn("―"),
                      style:
                          TextButton.styleFrom(backgroundColor: calculateColor),
                      child: Text('―', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () => onClickNumberBtn("1"),
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('1', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () => onClickNumberBtn("2"),
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('2', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () => onClickNumberBtn("3"),
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('3', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () => onClickOperateBtn("+"),
                      style:
                          TextButton.styleFrom(backgroundColor: calculateColor),
                      child: Text('+', style: textStyle),
                    ),
                    Container(
                      color: numColor,
                    ),
                    TextButton(
                      onPressed: () => onClickNumberBtn("0"),
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('0', style: textStyle),
                    ),
                    TextButton(
                      onPressed: onDecimalPoint,
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('.', style: textStyle),
                    ),
                    TextButton(
                      onPressed: onClickEqualBtn,
                      style:
                          TextButton.styleFrom(backgroundColor: calculateColor),
                      child: Text('=', style: textStyle),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
