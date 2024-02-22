import 'package:flutter/material.dart';

class SenderRowView extends StatelessWidget {
  const SenderRowView({super.key, required this.senderMessage});

  final String senderMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          flex: 15,
          fit: FlexFit.tight,
          child: Container(
            width: 50.0,
          ),
        ),
        Flexible(
          flex: 72,
          fit: FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Wrap(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 8.0, right: 5.0, top: 8.0, bottom: 2.0),
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 9.0, bottom: 9.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.amber.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                    child: Text(
                      senderMessage,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ],
          ),
          //
        ),
        const Flexible(
          flex: 13,
          fit: FlexFit.tight,
          child: Padding(
            padding: EdgeInsets.only(right: 10.0, top: 1.0, bottom: 9.0),
            child: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(
                'D',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
