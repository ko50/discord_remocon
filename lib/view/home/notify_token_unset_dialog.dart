import 'package:flutter/material.dart';

import '../../bot/token_util.dart';

class NotifyTokenNotSetDialog extends StatelessWidget {
  final _inputTokenFormController = TextEditingController();
  final _inputTokenFormKey = GlobalKey<FormState>();

  Widget _buildInputTokenForm() {
    FocusNode _focusNode = FocusNode();
    return Row(
      children: [
        Form(
          key: _inputTokenFormKey,
          child: TextFormField(
            controller: _inputTokenFormController,
            focusNode: _focusNode,
            decoration: InputDecoration(
                labelText: 'Token',
                hintText: "Discordのポータルサイトからコピーしてきたトークンを入力してください"),
            validator: (value) {
              if (value.isEmpty) return "tokenが入力されていません やる気ないならbackボタンで帰れ";
              return "";
            },
            onFieldSubmitted: (v) {
              bool isValid = _inputTokenFormKey.currentState.validate();
              if (isValid) _focusNode.unfocus();
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Botのトークンが設定されていません！"),
      content: Column(
        children: [
          Text("Botログインに必要な機密情報、Tokenが設定されていない為\n"
              "Discordにログインすることができません."
              "よろしければ、ここで設定していかれませんか？(後からでも設定/変更は可能です)"),
          _buildInputTokenForm(),
        ],
      ),
      actions: [
        FlatButton(
          child: Text('back'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('save'),
          onPressed: () {
            bool isValid = _inputTokenFormKey.currentState.validate();
            if (isValid)
              Navigator.of(context).pop(_inputTokenFormController.text);
          },
        ),
      ],
    );
  }
}

Future<String> showNotifyTokenNotSetDialog(BuildContext context) async {
  String token = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => NotifyTokenNotSetDialog()) ??
      "";

  await saveTokenToSharedPref(token);
  return token;
}
