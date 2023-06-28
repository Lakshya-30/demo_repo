import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/user_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'chat_contact_home.dart';
import 'message_mode.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';

// final chatRepositoryProvider = Provider(
//       create: (ref) => ChatRepository(
//     firestore: FirebaseFirestore.instance,
//     auth: FirebaseAuth.instance,
//   ),
// );

class FirebaseApi {
  // final FirebaseFirestore firestore;
  // final FirebaseAuth auth;
  //
  // ChatRepository({required this.firestore, required this.auth,});

  // void _saveDataToContactsSubcollection(
  //     UserModel senderUserData,
  //     UserModel recieverUserData,
  //     String text,
  //     DateTime timeSent,
  //     String recieverUserId,
  //     )async{
  //   var recieverChatContact = ChatContact(
  //     name: senderUserData.name,
  //     profilePic: senderUserData.profilePic,
  //     contactId: senderUserData.email,
  //     timeSent: timeSent,
  //     lastMessage: text,
  //   );
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(recieverUserId)
  //       .collection('chats')
  //       .doc(FirebaseAuth.instance.currentUser!.email)
  //       .set(recieverChatContact.toMap(),);
  //
  //   var senderChatContact = ChatContact(
  //     name: recieverUserData!.name,
  //     profilePic: recieverUserData.profilePic,
  //     contactId: recieverUserData.email,
  //     timeSent: timeSent,
  //     lastMessage: text,
  //   );
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.email)
  //       .collection('chats')
  //       .doc(recieverUserId)
  //       .set(senderChatContact.toMap(),);
  // }
  // void _saveMessageToMessageSubcollection({
  //   required String recieverUserId,
  //   required String text,
  //   required DateTime timeSent,
  //   required String messageId,
  // }) async{
  //   final message = Message(
  //       senderId: FirebaseAuth.instance.currentUser!.uid,
  //       recieverid: recieverUserId,
  //       text: text,
  //       timeSent: timeSent,
  //       messageId: messageId,
  //       isSeen: false,);
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.email)
  //       .collection('chats')
  //       .doc(recieverUserId)
  //       .collection('messages')
  //       .doc(messageId)
  //       .set(message.toMap(),
  //   );
    // users -> eciever id  -> sender id -> messages -> message id -> store message
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(recieverUserId)
  //       .collection('chats')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('messages')
  //       .doc(messageId)
  //       .set(message.toMap(),
  //   );
  // }
  static Future sendtextmessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required String? senderUserId,
  })async{
    try {
      var timeSent = DateTime.now();
      UserModel recieverUserData;
      var userDataMap = await FirebaseFirestore.instance.collection('users').doc(recieverUserId).get();
      recieverUserData = UserModel.fromJson(userDataMap.data()!);
      userDataMap = await FirebaseFirestore.instance.collection('users').doc(senderUserId).get();
      UserModel senderUser;
      senderUser=UserModel.fromJson(userDataMap.data()!);
      var messageId = const Uuid().v1();

      var recieverChatContact = ChatContact(
        name: senderUser.name,
        profilePic: senderUser.profilePic,
        contactId: senderUser.email,
        timeSent: timeSent,
        lastMessage: text,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(recieverUserId)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .set(recieverChatContact.toMap(),);

      var senderChatContact = ChatContact(
        name: recieverUserData.name,
        profilePic: recieverUserData.profilePic,
        contactId: recieverUserData.email,
        timeSent: timeSent,
        lastMessage: text,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('chats')
          .doc(recieverUserId)
          .set(senderChatContact.toMap(),);

      //////////////////
      final message = Message(
        senderId: FirebaseAuth.instance.currentUser!.uid,
        recieverid: recieverUserId,
        text: text,
        timeSent: timeSent,
        messageId: messageId,
        isSeen: false,);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('chats')
          .doc(recieverUserId)
          .collection('messages')
          .doc(messageId)
          .set(message.toMap(),
      );
      // users -> reciever id  -> sender id -> messages -> message id -> store message
      await FirebaseFirestore.instance
          .collection('users')
          .doc(recieverUserId)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .set(message.toMap(),
      );
    } catch(e) {
      print("error");
    }

}
}