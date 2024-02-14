import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/size/size_const.dart';

import '../../../model/message.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return message.fromId == '1'
        ? greenMessageCard(context)
        : whiteMessageCard(context);
  }
}

Widget greenMessageCard(BuildContext _) {
  return Align(
    alignment: Alignment.bottomRight,
    child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(_).size.width - 65,
            minWidth: SizeConst.customWidth(_, .3)),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          elevation: 1,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          )),
          color: Theme.of(_).primaryColorDark,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  bottom: 14,
                  top: 8,
                ),
                child: Text(
                  'nksejjgn efoiwajraekinm goaewniqmopngkeqondhbgmaondb sdgvnsazpogvmas zb s dgnvad o j',
                  style:
                      Theme.of(_).textTheme.titleLarge!.copyWith(fontSize: 18),
                ),
              ),
              const Positioned(right: 10, bottom: 0, child: Text('12.35pm'))
            ]),
          ),
        )),
  );
}

Widget whiteMessageCard(BuildContext _) {
  return Align(
    alignment: Alignment.bottomLeft,
    child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(_).size.width - 65,
            minWidth: SizeConst.customWidth(_, .3)),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          elevation: 1,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
          color: Theme.of(_).primaryColorLight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  bottom: 14,
                  top: 8,
                ),
                child: Text(
                  'nksejjgn efoiwajraekinm goaewniqmopngkeqondhbgmaondb sdgvnsazpogvmas zb s dgnvad o j',
                  style:
                      Theme.of(_).textTheme.titleLarge!.copyWith(fontSize: 18),
                ),
              ),
              const Positioned(right: 10, bottom: 0, child: Text('12.35pm'))
            ]),
          ),
        )),
  );
}
