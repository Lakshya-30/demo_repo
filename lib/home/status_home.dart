import 'package:flutter/material.dart';

class StatusHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Text('Status'),
      ),
      body: ListView.builder(
        itemCount: statusUpdates.length,
        itemBuilder: (context, index) {
          final statusUpdate = statusUpdates[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor:Colors.deepPurple[400] ,
              backgroundImage: AssetImage(statusUpdate.thumbnail),
            ),
            title: Text(statusUpdate.name),
            subtitle: Text(statusUpdate.time),
            onTap: () {
              // Handle status tap
            },
          );
        },
      ),
    floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.edit),
    backgroundColor: Colors.deepPurple[400],
    ),
    );
  }
}

class StatusUpdate {
  final String name;
  final String time;
  final String thumbnail;

  StatusUpdate({
    required this.name,
    required this.time,
    required this.thumbnail,
  });
}

final List<StatusUpdate> statusUpdates = [
  StatusUpdate(
    name: 'Lakshya',
    time: 'Just now',
    thumbnail: 'assets/status_thumbnail_1.jpg',
  ),
  StatusUpdate(
    name: 'Deekshitha',
    time: '2 hours ago',
    thumbnail: 'assets/status_thumbnail_2.jpg',
  ),
  StatusUpdate(
    name: 'Sandhya',
    time: 'Yesterday',
    thumbnail: 'assets/status_thumbnail_3.jpg',
  ),
  StatusUpdate(
    name: 'Usha',
    time: 'Just now',
    thumbnail: 'assets/status_thumbnail_3.jpg',
  ),
  // Add more status updates as needed
];
