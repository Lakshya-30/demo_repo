import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/chat_repo.dart';

class TypingMsg extends StatefulWidget {
  final String recieverUserId;
  const TypingMsg({super.key, required this.recieverUserId});
  @override
  State<TypingMsg> createState() => _TypingMsgState();
}

class _TypingMsgState extends State<TypingMsg> {

  bool isShowSendButton = false;
  final TextEditingController messageController = TextEditingController();
  void sendTextmessage() async{
    if (isShowSendButton) {
      await FirebaseApi.sendtextmessage(
          context: context,
          text: messageController.text.trim(),
          recieverUserId: widget.recieverUserId,
          senderUserId: FirebaseAuth.instance.currentUser!.email
      );

    }
      setState(() {
        messageController.text = '';
      });
  }
  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:const EdgeInsets.all(5.0),
      child: Row(
        children: [
        Expanded(
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              controller: messageController,
              onChanged: (val) {
                if (val.isNotEmpty) {
                  setState(() {
                    isShowSendButton = true;
                  });
                } else {
                  setState(() {
                    isShowSendButton = false;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Message',
                hintStyle: TextStyle(color: Colors.white),
                filled : true,
                fillColor: Colors.deepPurple[400],
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(30)
                ),
          ),
             cursorColor: Colors.white,

        )
        ),
        IconButton(
            onPressed: (){sendTextmessage();},
            icon: Icon(Icons.send),
            color: Colors.deepPurple[400],

        ),
      ],
    ),
    );
  }
}

