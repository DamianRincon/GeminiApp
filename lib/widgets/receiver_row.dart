import 'package:flutter/material.dart';

class ReceiverRowView extends StatelessWidget {
  const ReceiverRowView({super.key, required this.receiverMessage});

  final String receiverMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Flexible(
          flex: 13,
          fit: FlexFit.tight,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, top: 1.0, bottom: 9.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                'G',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 72,
          fit: FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 5.0, right: 8.0, top: 8.0, bottom: 2.0),
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 9.0, bottom: 9.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.lightBlue.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                    child: Text(
                      receiverMessage,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                child: const Text(
                  '8:55 AM, Today',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 7.0,
                  ),
                ),
              ),
            ],
          ),
          //
        ),
        Flexible(
          flex: 15,
          fit: FlexFit.tight,
          child: Container(
            width: 50.0,
          ),
        ),
      ],
    );
  }
}
