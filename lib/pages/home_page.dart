import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:hexcolor/hexcolor.dart';
import '../widgets/photo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: HexColor("#e47009"),
          centerTitle: true,
          title: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('contacts').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Text('${snapshot.data?.docs[0].get('name')}',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w600,
                      color: HexColor("#81d30b"),
                    ));
              })),
      body: Stack(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection('site').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              snapshot.data?.docs[0].get('backgroundimage')),
                          fit: BoxFit.cover)),
                  child: const Center(child: Photo()),
                );
              }),
        ],
      ),
    );
  }
}
