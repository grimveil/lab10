import 'package:flutter/material.dart';

void main() {
  runApp(const TextPreviewApp());
}

class TextPreviewApp extends StatelessWidget {
  const TextPreviewApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Preview App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Поле вводу тексту
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Enter text'),
            ),
            const SizedBox(height: 10),
            // Поле вводу розміру тексту
            TextField(
              controller: _sizeController,
              decoration: const InputDecoration(labelText: 'Enter text size'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // Кнопка переходу до другого екрану
            ElevatedButton(
              onPressed: () async {
                final text = _textController.text;
                final size = double.tryParse(_sizeController.text);

                if (text.isEmpty || size == null || size <= 0) {
                  _showDialog('Error', 'Please enter valid text and size.');
                  return;
                }

                // Навігація на другий екран
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SecondScreen(text: text, textSize: size),
                  ),
                );

                // Обробка результату
                if (result == 'Ok') {
                  _showDialog('Message', 'Cool!');
                } else if (result == 'Cancel') {
                  _showDialog('Message', 'Let’s try something else');
                } else {
                  _showDialog('Message', 'Don\'t know what to say');
                }
              },
              child: const Text('Preview'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String text;
  final double textSize;

  const SecondScreen({
    Key? key,
    required this.text,
    required this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Відображення тексту
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(fontSize: textSize),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Кнопка Ok
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Ok');
              },
              child: const Text('Ok'),
            ),
            const SizedBox(height: 10),
            // Кнопка Cancel
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
