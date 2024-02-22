import 'package:flutter/material.dart';
import 'package:gemini_app/page/chat.dart';
import 'package:gemini_app/page/compare_images.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({required this.apiKey, super.key});
  final String apiKey;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String responseText = "";
  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 500,
        ), () {
      obtenerRespuesta("Hola");
    });
    super.initState();
  }

  Future<String?> obtenerRespuesta(String entradaDeTexto) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: widget.apiKey);
    final content = [Content.text(entradaDeTexto)];
    final response = await model.generateContent(content);
    setState(() {
      responseText = response.text ?? "";
    });
    return response.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gemini ✦"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              alignment: Alignment.center,
              child: Lottie.asset('assets/animation2.json'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                responseText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Chat(
                        apikey: widget.apiKey,
                        placeholder: responseText,
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Hablar con Gemini"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CompareImages(
                        apikey: widget.apiKey,
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Comparar imagenes"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
