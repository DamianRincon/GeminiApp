import 'package:flutter/material.dart';
import 'package:gemini_app/models/message_model.dart';
import 'package:gemini_app/widgets/receiver_row.dart';
import 'package:gemini_app/widgets/sender_row.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';

class Chat extends StatefulWidget {
  const Chat({required this.apikey, required this.placeholder, super.key});

  @override
  State<Chat> createState() => _ChatState();
  final String apikey;
  final String placeholder;
}

class _ChatState extends State<Chat> {
  TextEditingController textEditingController = TextEditingController();
  late String senderMessage, receiverMessage;
  ScrollController scrollController = ScrollController();
  List<MessageData> messageList = [];
  bool loading = false;

  Future<void> obtenerRespuesta(String entradaDeTexto) async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      loading = true;
    });
    final model = GenerativeModel(model: 'gemini-pro', apiKey: widget.apikey);
    final content = [Content.text(entradaDeTexto)];
    final response = await model.generateContent(content);
    setState(() {
      loading = false;
      messageList.add(MessageData(
        response.text ?? "Error al obtener la respuesta",
        false,
      ));
      textEditingController.clear();
      scrollAnimation();
    });
  }

  Future<void> scrollAnimation() async {
    return await Future.delayed(
      const Duration(milliseconds: 100),
      () => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Habla con Gemini"),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) => (messageList[index].isSender)
                      ? SenderRowView(senderMessage: messageList[index].message)
                      : ReceiverRowView(
                          receiverMessage: messageList[index].message),
                ),
              ),
              Container(
                // height: 50,
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 35),
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xFF333D56),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: textEditingController,
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 6,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: widget.placeholder,
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 11.0),
                      child: Transform.rotate(
                        angle: -3.14 / 5,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: GestureDetector(
                            onTap: () {
                              obtenerRespuesta(
                                textEditingController.text,
                              );
                              setState(() {
                                messageList.add(MessageData(
                                  textEditingController.text,
                                  true,
                                ));
                                textEditingController.clear();
                                scrollAnimation();
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                obtenerRespuesta(
                                  textEditingController.text,
                                );
                                messageList.add(MessageData(
                                  textEditingController.text,
                                  false,
                                ));
                                textEditingController.clear();
                                scrollAnimation();
                              });
                            },
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
