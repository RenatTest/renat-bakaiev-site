import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

class Photo extends StatelessWidget {
  const Photo({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('contacts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            children: [
              const CircleAvatar(
                radius: 100,
                backgroundColor: Color.fromARGB(255, 5, 42, 122),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: CircleAvatar(
                    radius: 90,
                    backgroundColor: const Color.fromARGB(255, 5, 42, 122),
                    backgroundImage:
                        NetworkImage(snapshot.data?.docs[0].get('photo'))),
              )
            ],
          );
        });
  }
}
