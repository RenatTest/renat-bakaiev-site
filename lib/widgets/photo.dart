// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';

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
              CircleAvatar(
                radius: 100,
                backgroundColor: HexColor("#ff4119"),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: CircleAvatar(
                    radius: 90,
                    backgroundColor: HexColor("#ff4119"),
                    backgroundImage:
                        NetworkImage(snapshot.data?.docs[0].get('photo'))),
              )
            ],
          );
        });
  }
}
