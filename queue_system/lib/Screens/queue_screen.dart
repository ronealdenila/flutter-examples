import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class QueueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => FirebaseAuth.instance.signOut())
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Create a list of queue number sorted by number
            //Achieved. but not sure if will work on long run
            Expanded(child: QueueList()),

            //Unsolved. get the current snapshot of queuNum and display on user screen
            Expanded(child: CurretnQueue()),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        child: Text('Make Queue Request'),
        onPressed: () => sendQueue(),
      ),
    );
  }
}

class QueueList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('queue')
          .orderBy('queueNum')
          .snapshots(),
      builder: (ctx, queueSnapshot) {
        if (queueSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = queueSnapshot.data.docs;
        return ListView.builder(
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => QueueNumList(
            chatDocs[index].data()['queueNum'],
          ),
        );
      },
    );
  }
}

class CurretnQueue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('queue')
          .limit(1)
          .orderBy('queueNum')
          .snapshots(),
      builder: (ctx, queueSnapshot) {
        final queueDocs = queueSnapshot.data.docs;
        return ListView(
          children: [
            Text('The queue number is ${queueDocs.data()['queueNum']}'),
          ],
        );
      },
    );
  }
}


class QueueNumList extends StatelessWidget {
  final Key key;
  final int queueNum;

  const QueueNumList(this.queueNum, {this.key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$queueNum'),
    );
  }
}

void sendQueue() async {
  final user = FirebaseAuth.instance.currentUser;

  FirebaseFirestore.instance.collection('queue').add(
    {
      //hardcoded queue number. Must get the latest snapshot of queue number
      //and add 1 when sendQueue request is submitted.
      'queueNum': 6,
      'requestedAt': Timestamp.now(),
      'userId': user.uid,
      'status': 'pending',
    },
  );
}

// int get queuNum {
//   final queueData = FirebaseFirestore.instance.collection('queue').doc().get();
//   return queueData + 1;
// }

//Note: If you want to reset the queue everyday maybe use firestore runTransaction
//method and sort them by dateTimenow.
//Reference https://firebase.flutter.dev/docs/firestore/usage/#transactions
