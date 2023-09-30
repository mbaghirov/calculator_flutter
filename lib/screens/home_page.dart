import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userInput = '';
  String result = '0';

  List<String> buttonsList = [
    'AC',
    ')',
    '(',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(color: Colors.white, fontSize: 32),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 47,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
                itemCount: buttonsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (BuildContext context, index) {
                  return CustomButton(buttonsList[index]);
                }),
          ))
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CustomButton(String text) {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(39),
            boxShadow: const [
              BoxShadow(color: Colors.white, blurRadius: 3, spreadRadius: 0.5)
            ]),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: getColor(text)),
        )),
      ),
    );
  }

  getColor(String text) {
    if (text == '+' ||
        text == '-' ||
        text == '*' ||
        text == '/' ||
        text == ')' ||
        text == '(' ||
        text == 'C') {
     return Colors.green;
    }
    return Colors.white;
  }

  getBgColor(String text) {
    if (text == 'AC') {
     return Colors.green;
    }
    if (text == '=') {
     return Colors.green;
    }
    return Colors.black;
  }

  handleButtons(String text){
    if(text == 'AC'){
      userInput = '';
      result = '0';
      return;
    }
    if(text == 'C'){
      if(userInput.isNotEmpty){
        userInput = userInput.substring(0, userInput.length -1);
         return;
      }else{
      return null;
      }
    }
    if(text == '='){
      result = calculate();
      userInput = result;

      if(userInput.endsWith('.0')) {
        userInput = userInput.replaceAll('.0', '');
      }
      if(result.endsWith('.0')) {
        result = result.replaceAll('.0', '');
        return;
      }
    }
    userInput = userInput + text; 
  }
  
  String calculate () {
      try {
        var exp = Parser().parse(userInput);
        var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
        return evaluation.toString();
      } catch (e) {
        return 'Error';
      }
    }
}



