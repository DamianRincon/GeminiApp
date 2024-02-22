import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class CompareImages extends StatefulWidget {
  const CompareImages({required this.apikey, super.key});
  final String apikey;

  @override
  State<CompareImages> createState() => _CompareImagesState();
}

class _CompareImagesState extends State<CompareImages> {
  List<XFile>? _images;
  String _response = "";
  bool loading = false;

  Future<void> restore() async {
    setState(() {
      _response = "";
      _images = null;
      loading = false;
    });
  }

  Future<void> comparadorDeImagenes() async {
    setState(() {
      loading = true;
    });

    final model =
        GenerativeModel(model: 'gemini-pro-vision', apiKey: widget.apikey);

    final img1Bytes = await rootBundle.load(_images![0].path);
    final img2Bytes = await rootBundle.load(_images![1].path);

    final img1Buffer = img1Bytes.buffer.asUint8List();
    final img2Buffer = img2Bytes.buffer.asUint8List();

    final imageParts = [
      DataPart('image/jpeg', img1Buffer),
      DataPart('image/jpeg', img2Buffer),
    ];

    final prompt =
        TextPart("Puedes comparar ambas imagenes y decirme las diferencias");
    final response = await model.generateContent([
      Content.multi([prompt, ...imageParts])
    ]);
    setState(() {
      loading = false;
      _response = response.text ?? "";
    });
    // return Future.value(response.text);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Comparar imagenes"),
          ),
          bottomNavigationBar: Container(
            height: 50,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 30, left: 50, right: 50),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () {
                comparadorDeImagenes();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Comparar"),
              ),
            ),
          ),
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Selecione 2 imagenes para que Gemini haga una comparación entre ellas.",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () async {
                    final images = await ImagePicker().pickMultiImage();
                    if (images.length == 2) {
                      setState(() {
                        _images = images;
                      });
                    }
                  },
                  child: const Text("Seleccionar imagenes"),
                ),
              ),
              const SizedBox(height: 20),
              if (_images != null && _images?.length == 2)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Image.file(File(_images![0].path)),
                    ),
                    SizedBox(
                      width: 150,
                      child: Image.file(File(_images![1].path)),
                    )
                  ],
                ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(_response),
              )
            ],
          ),
        ),
        loading
            ? Container(
                color: Colors.white.withOpacity(0.5),
                child: Center(
                  child: Lottie.asset('assets/animation1.json'),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
