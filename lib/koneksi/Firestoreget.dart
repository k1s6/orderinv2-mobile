import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:orderez/koneksi/CollageController.dart';

class Firestoreget extends StatelessWidget {
  final String documentId;

  Firestoreget(this.documentId);

  @override
  Widget build(BuildContext context) {
    // CollectionReference products = FirebaseFirestore.instance.collection('product');
    // FirebaseFirestore db = FirebaseFirestore.instance;

    // final docRef = db.collection("product").doc("SF");
    // docRef.get().then(
    //   (DocumentSnapshot doc) {
    //     final data = doc.data() as Map<String, dynamic>;
    //     print(data);
    //     // ...
    //   },
    //   onError: (e) => print("Error getting document: $e"),
    // );

    CollageController collageController = CollageController();
    
    Future(() => collageController.getAllStudent());


    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Center(
        child: Text('getmydata'),
      ),
    );
  }
}
