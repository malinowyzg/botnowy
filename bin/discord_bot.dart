import 'dart:io';
import 'package:nyxx/nyxx.dart';

void main() async{
  String token = Platform.environment['TOKEN'] ?? '';

  final client = await Nyxx.connectGateway(
    token, 
    GatewayIntents.allUnprivileged
    );

    final bot = await client.users.fetchCurrentUser();
    print("✅ Bot Online");

    client.onMessageCreate.listen((event) async{
      if(event.mentions.contains(bot)) {
        await event.message.channel.sendMessage(MessageBuilder(
          content: 'Hi ${event.message.author.username}, How may I help you today',
          replyId: event.message.id,
        ));
      }
    });

   // Fake Web Server to Keep Render Alive
  var port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  var server = await HttpServer.bind(InternetAddress.anyIPv4, port);
  print("🌍 Fake server running on port $port");
  await for (var request in server) {
    request.response
      ..write("Bot is running!")
      ..close();
  }
}
