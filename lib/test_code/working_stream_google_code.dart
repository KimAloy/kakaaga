import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WorkingStreamCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Scaffold(
          body: ListView(
            //   //   return users.doc(loggedInUser!.uid).snapshots().map(_userDataFromSnapshot);

            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return ListTile(
                title: Text(document.data()!['name']),
                subtitle: Text(document.data()!['phoneNumber']),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
