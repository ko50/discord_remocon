import 'package:nyxx/Nyxx.dart';

class BotClient extends Nyxx {
  BotClient(String token) : super(token) {
    print('================= Successfully Logged In =================-');
  }
}
