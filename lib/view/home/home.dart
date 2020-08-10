import 'package:flutter/material.dart';

import '../../bot/bot_client.dart';
import '../../bot/token_util.dart';
import './notify_token_unset_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BotClient client;
  String token;

  Future loginToDiscord() async {
    token = await getTokenFromSharedPref();
    if (token == null || token.isEmpty)
      token = await showNotifyTokenNotSetDialog(context);
    client = BotClient(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discord Remote Controller'),
      ),
      body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[],
          ),
        );
      }),
    );
  }
}
