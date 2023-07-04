import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/utils.dart';
import 'user_model.dart';

class EditInfo extends StatefulWidget {
  const EditInfo({super.key});

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  File? image;

  @override
  void dispose(){
    super.dispose();
    nameController.dispose();
  }
  // void selectImage() async{
  //   image = await pickImageFromGallery(context);
  //   setState(() {});
  // }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[400],
          title: const Text('Edit Information'),
        ),
        body: FutureBuilder<UserModel>(
            future: readUser(user.email!),
            builder: (context, snapshot) {
              final me = snapshot.data;
              return me == null
                  ? const Center(
                      child: Text('Loading...'),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                image == null ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(me.profilePic),
                                )
                                : CircleAvatar(
                                  radius: 64,
                                  backgroundImage: FileImage(image!),
                                ),
                                Positioned(
                                  bottom: -10,
                                  left: 80,
                                  child: IconButton(
                                      onPressed: () {
                                        //selectImage;
                                      },
                                      icon: const Icon(Icons.add_a_photo,color: Colors.black,)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width *0.8,
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: me.name,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      saveName();
                                    },
                                    icon: const Icon(Icons.done)),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width *0.8,
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    controller: aboutController,
                                    decoration: InputDecoration(
                                      hintText: me.about,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      saveAbout();
                                    },
                                    icon: const Icon(Icons.done)),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
            }));
  }
  Future saveName() async{
    String name = nameController.text.trim();
    await FirebaseFirestore.instance.collection("users")
        .doc(user.email)
        .update({
      "name" : name,
    });
  }

  Future saveAbout() async{
    String abt = aboutController.text.trim();
    await FirebaseFirestore.instance.collection("users")
        .doc(user.email)
        .update({
      "about" : abt,
    });
  }
}

Future<UserModel> readUser(String email) async {
  final docuser = FirebaseFirestore.instance.collection('users').doc(email);
  final snapshot = await docuser.get();

  if (snapshot.exists) {
    return UserModel.fromJson(snapshot.data()!);
  }
  return UserModel(
      name: 'Demo',
      email: 'dummy@yo.com',
      profilePic: 'abracadabra',
      about: 'Hello!',
      timeCreated: DateTime.now(),
      lastSeen: DateTime.now());
}


