import 'dart:math';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final Map<String, List<String>> _wordsWithHints = {
    'banana': ["É uma fruta", "Amarela por fora", "É rica em potássio"],
    'coração': ["Parte do corpo", "É responsável pelo bombeamento de sangue", "Simboliza amor"],
    'avião': ["Transporte aéreo", "Possui asas", "Leva pessoas ou cargas"],
    'cachorro': ["É um animal", "Melhor amigo do homem", "Late para estranhos"],
  };

  String? _currentWord;
  List<String>? _currentHints;
  int _currentHintIndex = 0;
  String? _message;

  final TextEditingController _wordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pickRandomWord();
  }

  void _pickRandomWord() {
    final random = Random();
    final words = _wordsWithHints.keys.toList();
    final chosenWord = words[random.nextInt(words.length)];

    setState(() {
      _currentWord = chosenWord;
      _currentHints = _wordsWithHints[chosenWord];
      _currentHintIndex = 0;
      _message = null;
    });
  }

  void _checkAnswer() {
    final userAnswer = _wordController.text.trim().toLowerCase();

    if (userAnswer == _currentWord) {
      setState(() {
        _message = 'Você acertou! ';
      });
      Future.delayed(Duration(seconds: 2), () {
        _pickRandomWord();
        _wordController.clear();
      });
    } else {
      if (_currentHintIndex < (_currentHints!.length - 1)) {
        _currentHintIndex++;
      }
      Navigator.pushNamed(
        context,
        '/secondScreen',
        arguments: {
          'hint': _currentHints![_currentHintIndex],
          'message': 'Que pena, você errou! Tente novamente.',
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerta Palavra'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _wordController,
              decoration: InputDecoration(
                labelText: 'Digite sua resposta',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _message = _currentHints![_currentHintIndex];
                    });
                  },
                  child: Text('Pedir Dica'),
                ),
                ElevatedButton(
                  onPressed: _checkAnswer,
                  child: Text('Verificar'),
                ),
              ],
            ),
            if (_message != null) ...[
              SizedBox(height: 20),
              Text(
                _message!,
                style: TextStyle(fontSize: 18, color: Colors.indigo),
              ),
            ],
          ],
        ),
      ),
    );
  }
}