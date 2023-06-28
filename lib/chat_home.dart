import 'package:flutter/material.dart';
import 'package:messaging_app/contact_page.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> with WidgetsBindingObserver, TickerProviderStateMixin{

  late TabController tabBarController;
  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[400],
          title: Text('ChatMe',style: TextStyle(letterSpacing: 1),),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),),
            ],
          bottom:  TabBar(
            controller: tabBarController,
            tabs: const [
              Tab(text: 'Allchats'),
              Tab(text: 'Personal'),
              Tab(text: 'Work'),
              Tab(text: 'Groups'),
            ],),
        ),
        body: TabBarView(
          controller: tabBarController,
          children: const [
            Center(child: Text('Chat')),
            Center(child: Text('Personal')),
            Center(child: Text('work')),
            Center(child: Text('groups')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage() ));},
          child: Icon(Icons.chat),
          backgroundColor: Colors.deepPurple[400],
          ),
        )
    );
  }
}
