import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:native_readability/native_readability.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _urlController = TextEditingController();
  String _htmlContent = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch HTML Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: 'Enter URL'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async{
                await fetchHtml();
                _htmlContent = await NativeReadability().parse(url: _urlController.text.trim(), html: _htmlContent)??'Error parsing webpage';
                setState(() {});
              },
              child: const Text('Fetch HTML'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_htmlContent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchHtml() async {
    String url = _urlController.text.trim();

    if (url.isNotEmpty) {
      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          setState(() {
            _htmlContent = response.body;
          });
        } else {
          setState(() {
            _htmlContent = 'Failed to fetch HTML. Status Code: ${response.statusCode}';
          });
        }
      } catch (e) {
        setState(() {
          _htmlContent = 'Error: $e';
        });
      }
    } else {
      setState(() {
        _htmlContent = 'Please enter a URL';
      });
    }
  }
}
