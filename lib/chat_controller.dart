// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:messaging_app/user_model.dart';
// import 'package:riverpod/riverpod.dart';
//
// import 'chat_repo.dart';
//
// class ChatController {
//   final ChatRepository chatRepository;
//   final ProviderRef ref;
//
//   ChatController({
//     required this.chatRepository,
//     required this.ref,
//   });
//   void sendTextMessage(
//       BuildContext context,
//       String text,
//       String recieverUserId,
//       ) {
//     //final messageReply = ref.read(messageReplyProvider);
//     var userDataMap = await firestore.collection('users').doc(auth.currentUser!.email).get();
//     chatRepository.sendtextmessage(
//         context: context,
//         text: text,
//         recieverUserId: recieverUserId,
//         senderUser:  UserModel.fromJson(userDataMap.data()!),
//       );
//   }
// }