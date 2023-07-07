import 'package:flutter/material.dart';

class CallHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Text('Calls'),
      ),
      body: ListView.builder(
        itemCount: callLogs.length,
        itemBuilder: (context, index) {
          final callLog = callLogs[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple[400],
              backgroundImage: AssetImage(callLog.thumbnail),
            ),
            title: Text(callLog.name),
            subtitle: Row(
              children: [
                Icon(
                  callLog.callType == CallType.incoming
                      ? Icons.call_received
                      : Icons.call_made,
                  color: callLog.callType == CallType.incoming
                      ? Colors.green
                      : Colors.red,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(callLog.time),
              ],
            ),
            onTap: () {
              // Handle call log tap
            },
          );
        },
      ),
    floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.call),
    backgroundColor: Colors.deepPurple[400],
    ),
    );
  }
}

enum CallType { incoming, outgoing }

class CallLog {
  final String name;
  final String time;
  final String thumbnail;
  final CallType callType;

  CallLog({
    required this.name,
    required this.time,
    required this.thumbnail,
    required this.callType,
  });
}

final List<CallLog> callLogs = [
  CallLog(
    name: 'Sandhya',
    time: 'Yesterday, 10:30 AM',
    thumbnail: 'assets/call_thumbnail_1.jpg',
    callType: CallType.incoming,
  ),
  CallLog(
    name: 'Deekshitha',
    time: 'Yesterday, 3:45 PM',
    thumbnail: 'assets/call_thumbnail_2.jpg',
    callType: CallType.outgoing,
  ),
  CallLog(
    name: 'Usha',
    time: '2 days ago, 9:15 AM',
    thumbnail: 'assets/call_thumbnail_3.jpg',
    callType: CallType.incoming,
  ),
  CallLog(
    name: 'Lakshya',
    time: '3 days ago, 9:45 PM',
    thumbnail: 'assets/call_thumbnail_3.jpg',
    callType: CallType.incoming,
  ),
  // Add more call logs as needed
];
