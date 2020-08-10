import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getTokenFromSharedPref() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();

  if (!pref.containsKey('DiscordRemoconClientToken')) {
    await pref.setString('DiscordRemoconClientToken', '');
    return null;
  }

  final String rawJson = pref.getString('DiscordRemoconClientToken');

  return rawJson == '' ? null : json.decode(rawJson);
}

Future saveTokenToSharedPref(String token) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString('DiscordRemoconClientToken', token);
}
