import 'package:flutter/material.dart';
import 'quizzler_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Brain quizBrain = Brain();
void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: QuizzlerPage(),
      ),
    );
  }
}

class QuizzlerPage extends StatefulWidget {
  const QuizzlerPage({Key? key}) : super(key: key);

  @override
  State<QuizzlerPage> createState() => _QuizzlerPageState();
}

class _QuizzlerPageState extends State<QuizzlerPage> {
  List<Icon> scoreKeeper = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(70.0),
            child: Card(
              color: Colors.black,
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                bool correctans = quizBrain.getAnswerBool();
                if (quizBrain.isFinished()) {
                  setState((){
                    Alert(context: context, title: "You have reached the end", desc: "").show();
                  });
                  scoreKeeper = [];
                  quizBrain.reset();
                } else {
                  if (correctans == true) {
                    setState(() {
                      scoreKeeper.add(const Icon(
                        Icons.check,
                        color: Colors.green,
                      ));
                      quizBrain.nextQuestion();
                    });
                  } else {
                    setState(() {
                      scoreKeeper.add(const Icon(
                        Icons.close,
                        color: Colors.red,
                      ));
                      quizBrain.nextQuestion();
                    });
                  }
                }
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
                padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
              ),
              child: const Text(
                'True',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                bool correctans = quizBrain.getAnswerBool();
                if (quizBrain.isFinished()) {
                  scoreKeeper = [];
                  quizBrain.reset();
                } else {
                  if (correctans == false) {
                    setState(() {
                      scoreKeeper.add(const Icon(
                        Icons.check,
                        color: Colors.green,
                      ));
                      quizBrain.nextQuestion();
                    });
                  } else {
                    setState(() {
                      scoreKeeper.add(const Icon(
                        Icons.close,
                        color: Colors.red,
                      ));
                      quizBrain.nextQuestion();
                    });
                  }
                }
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red),
                padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
              ),
              child: const Text(
                'False',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: scoreKeeper,
          ),
        ],
      ),
    );
  }
}
