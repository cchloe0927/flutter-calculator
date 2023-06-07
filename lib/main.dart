import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color? numColor = Colors.grey[800];
  final Color? initColor = Colors.grey[900];
  final Color? calculateColor = const Color(0xFFff9502);

  final TextStyle textStyle = TextStyle(
    fontSize: 40,
    color: Colors.white.withOpacity(0.8),
  );

  MyApp({super.key});

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
              child: const Text(
                "0",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 100,
                ),
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
                      onPressed: () {},
                      style: TextButton.styleFrom(backgroundColor: initColor),
                      child: Text(
                        'AC',
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
                      onPressed: () {},
                      style:
                          TextButton.styleFrom(backgroundColor: calculateColor),
                      child: Text(
                        '÷',
                        style: textStyle,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('7', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('8', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('9', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () {},
                      style:
                          TextButton.styleFrom(backgroundColor: calculateColor),
                      child: Text('×', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('4', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('5', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('6', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () {},
                      style:
                          TextButton.styleFrom(backgroundColor: calculateColor),
                      child: Text('―', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('1', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('2', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('3', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () {},
                      style:
                          TextButton.styleFrom(backgroundColor: calculateColor),
                      child: Text('+', style: textStyle),
                    ),
                    Container(
                      color: numColor,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('0', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(backgroundColor: numColor),
                      child: Text('.', style: textStyle),
                    ),
                    TextButton(
                      onPressed: () {},
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
