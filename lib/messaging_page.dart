import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/contacts/contact_profile.dart';
import 'package:profanity_filter/profanity_filter.dart';

class MessagePage extends StatefulWidget {
  final Contact contact;
  MessagePage({required this.contact});

  @override
  State<MessagePage> createState() => _MessagePageState(contact: contact);
}

class _MessagePageState extends State<MessagePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final Contact contact;
  _MessagePageState({required this.contact});
  final fs = FirebaseFirestore.instance;
  final TextEditingController message = new TextEditingController();
  final filter = ProfanityFilter();


  @override
  Widget build(BuildContext context) {
    int comp = user.email!.compareTo(contact.email);
    String mid ='';
    if(comp < 0){
      mid = user.email! + contact.email;
    } else {
      mid = contact.email + user.email!;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${contact.name}'),
        backgroundColor: Colors.deepPurple[400],
          actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) =>  ContactProfilePage(contact: contact),)
                );
              },
            icon: const Icon(Icons.account_circle)
          ),
          ]
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.79,
              child: messages(
                me: user.email!,
                mid: mid
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: message,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.red[50],
                      hintText: 'Message',
                      enabled: true,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {},
                    onSaved: (value) {
                      message.text = value!;
                    },
                  ),
                ),
                IconButton(
                  onPressed: () async{
                    saveLastContacted();
                    bool hasProfanity = filter.hasProfanity(message.text);
                    print('The string has profanity: $hasProfanity');
                    if(hasProfanity == true){
                      message.text=filter.censor(message.text);
                    }
                    if (message.text.isNotEmpty) {
                      fs.collection('messages').doc().set({
                        'message': message.text.trim(),
                        'time': DateTime.now(),
                        'senderMail': user.email,
                        'senderName': user.displayName,
                        'mid': mid,
                      });
                      message.clear();
                    }
                  },
                  icon: Icon(Icons.send_sharp, color: Colors.deepPurple[400],),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future saveLastContacted() async{
    await FirebaseFirestore.instance.collection("users")
        .doc(user.email).collection('contacts').doc(contact.email)
        .update({
      "lastContacted" : DateTime.now(),
    });
  }

  messages({required String me, required String mid}) {
    final Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
        .collection('messages')
        .where("mid", isEqualTo: mid)
        .orderBy('time')
        .snapshots();
    return StreamBuilder(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("something is wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text('Loading...')
            //child: CircularProgressIndicator(color: Colors.white70,),
          );
        }

        return SingleChildScrollView(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            primary: true,
            itemBuilder: (_, index) {
              QueryDocumentSnapshot qs = snapshot.data!.docs[index];
              Timestamp t = qs['time'];
              DateTime d = t.toDate();
              print(d.toString());
              return Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: me == qs['senderMail']
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Delete or Edit  Message??'),
                            content: Text('Are you sure you want to delete or edit this message?'),
                            actions: [
                              TextButton(
                                child: Text('Delete'),
                                onPressed: () async {
                                  if(me==qs['senderMail']){
                                  await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                    await myTransaction.delete(qs.reference);
                                  });}
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text('edit'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );},
                      child :SizedBox(
                        width: 300,
                        child: ListTile(
                        tileColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(
                          qs['senderName'],
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.purple,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                qs['message'],
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              d.hour.toString() + ":" + d.minute.toString(),
                              style: const TextStyle(color: Colors.black,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}