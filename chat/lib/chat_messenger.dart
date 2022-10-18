import 'package:flutter/material.dart';

class ChatMessenger extends StatelessWidget {
  ChatMessenger(this.data, this.mine);

  Map<String, dynamic> data;

  final bool mine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          !mine
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data['senderPhotoUrl'] ?? ''),
                  ),
                )
              : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                data['imgUrl'] != null
                    ? Image.network(
                        data['imgUrl'],
                        width: 250,
                      )
                    : Padding(
                        padding: mine
                            ? const EdgeInsets.only(left: 100)
                            : const EdgeInsets.only(left: 0),
                        child: Text(
                          data['text'],
                          style: const TextStyle(fontSize: 18),
                          textAlign: mine ? TextAlign.start : TextAlign.start,
                        ),
                      ),
                Text(
                  data['senderName'],
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 13),
                ),
              ],
            ),
          ),
          mine
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data['senderPhotoUrl'] ?? ''),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
