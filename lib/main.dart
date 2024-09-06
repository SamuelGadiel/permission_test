import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = '';
  final List<String> extensions = ['png', 'jpg', 'jpeg'];

  void _selectFile() async {
    FilePickerResult? filePicker = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
      allowMultiple: true,
      withData: true,
    );

    if (filePicker != null) {
      setState(() {
        if (filePicker.files.every((file) => extensions.contains(file.extension))) {
          text = filePicker.files.map((e) => e.name).join('\n');
        } else {
          text = "ERROR";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permission Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            ElevatedButton(
              onPressed: _selectFile,
              child: const Text('Select File'),
            ),
          ],
        ),
      ),
    );
  }
}
