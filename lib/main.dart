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

  // List<String> equalRePush = []; //마지막에 입력받은 숫자 사용하는 배열
  // 📌 배열로 만들어서 마지막에 눌러진 숫자를 배열에 계속 add 하면서 = 버튼을 눌렀을 때 연산이 되도록 했음 => 쓸 때 없는 값을 계속 채워 넣는 것을 비효율 적!
  String equalRePush = ''; //마지막에 입력받은 숫자 사용하는 배열
  String variableValueAfter = "0"; //화면에 보여지는 숫자
  num variableValueBefore = 0; //계속 더해지는 숫자

  bool isOperateBtn = false; //사칙연산 활성화 상태
  bool isNumberBtn = false; //숫자 활성화 상태 => 숫자 누르기 전에 사칙연산 변경 시 기준점 역할
  bool isPressedPlusBtn = false; //플러스 상태
  bool isPressedMinus = false; //마이너스 상태
  bool isPressedMultiply = false; //곱하기 상태
  bool isPressedDivide = false; // 나누기 상태

  void initOperateState() {
    isPressedPlusBtn = false;
    isPressedMinus = false;
    isPressedMultiply = false;
    isPressedDivide = false;
  }

  void onClickACBtn() {
    variableValueBefore = 0;
    variableValueAfter = "0";
    equalRePush = '';
    initOperateState();
    setState(() {});
  }

  void onDecimalPoint() {
    // = 버튼 클릭 후 소수점을 누르면 계산 끝난걸로 간주 후 새롭게 계산
    if (isOperateBtn) {
      isOperateBtn = false;
      variableValueAfter = "0.";
    }
    // = 버튼 클릭 전 계산이 끝나지 않은 상태
    else {
      if (variableValueAfter.contains('.')) {
        return;
      }
      variableValueAfter += ".";
    }
    setState(() {});
  }

  //소수점 정수로 전환 함수
  convertInt(num decimal) {
    if (decimal != decimal.round()) {
      return decimal;
    }
    return decimal.toInt();
  }

  void onClickNumberBtn(String value) {
    if (isOperateBtn) {
      isOperateBtn = false;
      equalRePush = value; //미지막의 피연산자를 = 버튼을 눌렀을 때가 아닌 숫자를 눌렀을 때 대입함❗️❗️
      variableValueAfter = "0";
    }
    if (variableValueAfter == "0" && variableValueAfter.length == 1) {
      variableValueAfter = '';
    }
    variableValueAfter += value;
    isNumberBtn = true; //숫자 누르기 전에 사칙연산 변경 시 기준점 역할
    setState(() {});
  }

  void onClickOperateBtn(String type) {
    equalRePush = ''; //사칙연산 버튼 클릭 시 equalRePush 값을 다시 빈값으로 만듦
    num afterNum = num.parse(variableValueAfter);

    //variableValueBefore != 0 아닌 경우는 = 버튼 없이 사칙연산 버튼을 다시 눌러서 계속 계산할 때
    //numberBtnState가 false이면 숫자 입력없이 사칙연산만 변경했을 떄
    if (variableValueBefore != 0 && isNumberBtn) {
      /** 문제! 1 + 1 - 를 하게되면 2번째에 클린된 연산자가 실행됌
      * 처음에는 switch 문으로 사칙연산 타입을 받아와서 처리했음 -> 그래서 사칙연산을 누른 순간의 사칙연산으로 계산이 됌
      * 따라서 if문으로 바꾸고 변수로 선언한 사칙연산들의 불리언 값을 통해서 받아온 값으로 if문을 실행함
      * print("isPressedPlusBtn $isPressedPlusBtn");
      */
      if (isPressedPlusBtn) {
        variableValueBefore += afterNum;
      } else if (isPressedMinus) {
        variableValueBefore -= afterNum;
      } else if (isPressedMultiply) {
        variableValueBefore *= afterNum;
      } else if (isPressedDivide) {
        variableValueBefore /= afterNum;
      }
      variableValueAfter = convertInt(variableValueBefore).toString();
    }
    //variableValueBefore 0인 경우는 = 버튼 클릭 후 나온 결과값(variableValueAfter)을 variableValueBefore에 저장해둠!
    else {
      variableValueBefore = num.parse(variableValueAfter);
    }

    initOperateState(); //사칙연산 버튼 클릭 후 다시 사칙 연산을 false 만들어 줘야 다른 사칙연산 값을 받아서 적용함

    switch (type) {
      case "+":
        isPressedPlusBtn = true;
        break;
      case "―":
        isPressedMinus = true;
        break;
      case "x":
        isPressedMultiply = true;
        break;
      case "/":
        isPressedDivide = true;
        break;
    }
    isNumberBtn = false; //숫자 활성화 상태 => 숫자 누르기 전에 사칙연산 변경 시 기준점 역할
    isOperateBtn = true; //variableValueAfter = 0 -> ""이 되면서 새로운 화면 출력 값 만듦
    setState(() {});
  }

  void onClickEqualBtn() {
    num afterNum = num.parse(variableValueAfter);

    if (isPressedPlusBtn) {
      if (variableValueBefore == 0) {
        variableValueAfter =
            (convertInt(num.parse(variableValueAfter) + num.parse(equalRePush)))
                .toString();
      } else if (equalRePush == '') {
        variableValueAfter =
            (convertInt(num.parse(variableValueAfter) + afterNum)).toString();
      } else {
        variableValueAfter =
            (convertInt(variableValueBefore + afterNum)).toString();
      }
    } else if (isPressedMinus) {
      if (variableValueBefore == 0) {
        variableValueAfter =
            (convertInt(num.parse(variableValueAfter) - num.parse(equalRePush)))
                .toString();
      } else if (equalRePush == '') {
        variableValueAfter =
            (convertInt(num.parse(variableValueAfter) - afterNum)).toString();
      } else {
        variableValueAfter =
            (convertInt(variableValueBefore - afterNum)).toString();
      }
    } else if (isPressedMultiply) {
      if (variableValueBefore == 0) {
        variableValueAfter =
            (convertInt(num.parse(variableValueAfter) * num.parse(equalRePush)))
                .toString();
      } else if (equalRePush == '') {
        variableValueAfter =
            (convertInt(num.parse(variableValueAfter) * afterNum)).toString();
      } else {
        variableValueAfter =
            (convertInt(variableValueBefore * afterNum)).toString();
      }
    } else if (isPressedDivide) {
      if (num.parse(variableValueAfter) == 0) {
        variableValueAfter = "숫자 아님";
      } else if (variableValueBefore == 0) {
        variableValueAfter =
            (convertInt(num.parse(variableValueAfter) / num.parse(equalRePush)))
                .toString();
      } else if (equalRePush == '') {
        variableValueAfter =
            (convertInt(num.parse(variableValueAfter) / afterNum)).toString();
      } else {
        variableValueAfter =
            (convertInt(variableValueBefore / afterNum)).toString();
      }
    }
    variableValueBefore = 0; //variableValueBefore을 0 기준점으로 = 버튼만 눌렀을 때 연산함
    isOperateBtn = true;
    setState(() {});
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
