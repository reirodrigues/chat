import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TextCompose extends StatefulWidget {
  const TextCompose(this.sendMessage);

  final Function({String? text, File? photo}) sendMessage;

  @override
  State<TextCompose> createState() => _TextComposeState();
}

class _TextComposeState extends State<TextCompose> {
  bool _isComposing = false;

  final TextEditingController sendController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void resetButtonSend() {
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.camera);

              File fileSend = File(photo!.path);
              widget.sendMessage(photo: fileSend);

              if (photo == null) return;
            },
            icon: const Icon(Icons.photo_camera),
          ),
          Expanded(
            child: TextField(
              controller: sendController,
              decoration: const InputDecoration.collapsed(
                hintText: 'Enviar uma mensagem',
              ),
              onChanged: (value) {
                setState(() {
                  _isComposing = value.isNotEmpty;
                });
              },
              onSubmitted: (value) {
                widget.sendMessage(text: value);
                sendController.clear();
                resetButtonSend();
              },
            ),
          ),
          IconButton(
            onPressed: _isComposing
                ? () {
                    widget.sendMessage(text: sendController.text);
                    sendController.clear();
                    resetButtonSend();
                  }
                : null,
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
