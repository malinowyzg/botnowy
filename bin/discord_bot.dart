import 'dart:io';
import 'package:nyxx/nyxx.dart';
import 'discord';

void main() async{
  String token = Platform.environment['TOKEN'] ?? '';

  final client = await Nyxx.connectGateway(
    token, 
    GatewayIntents.allUnprivileged
    );

    final bot = await client.users.fetchCurrentUser();
    print("✅ Bot Aktywny!");

    client.onMessageCreate.listen((event) async{
      if(event.mentions.contains(bot)) {
        await event.message.channel.sendMessage(MessageBuilder(
          content: 'Hi ${event.message.author.username}, How may I help you today',
          replyId: event.message.id,
        ));
      }
    });

  @client.command(name='test')
async def _test(ctx):
    await ctx.send(f'Test')
      
   // Fake Web Server to Keep Render Alive
  var port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  var server = await HttpServer.bind(InternetAddress.anyIPv4, port);
  print("🌍 Asystent Uruchomiony Prawidłowo! $port");
  await for (var request in server) {
    request.response
      ..write("https://media.discordapp.net/attachments/1199742339632091247/1351934534119329932/LOGODC.png?ex=6805b5e6&is=68046466&hm=4d7575eb77a86490147f81aaa4648e9adc3e92d14c48ea47ad6c41dc0b45cd4e&=&format=webp&quality=lossless")
      ..close();
  }
}
