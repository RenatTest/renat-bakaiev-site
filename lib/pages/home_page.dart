// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import '../widgets/photo.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Photo(),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('contacts')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          width: 220,
                                          child: Text(
                                            'About me:\n${snapshot.data?.docs[0].get('description')}',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Arial',
                                              fontWeight: FontWeight.w600,
                                              color: HexColor("#FFFFFF"),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10),
                                            Text(
                                              'name: ${snapshot.data?.docs[0].get('name')}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Arial',
                                                fontWeight: FontWeight.w600,
                                                color: HexColor("#FFFFFF"),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            InkWell(
                                              onTap: () {
                                                _makePhoneCall(snapshot
                                                    .data?.docs[0]
                                                    .get('phone'));
                                              },
                                              child: Text(
                                                'phone: ${snapshot.data?.docs[0].get('phone')}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Arial',
                                                    fontWeight: FontWeight.w600,
                                                    color: HexColor("#FFFFFF")),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            InkWell(
                                              onTap: () {
                                                final Uri params = Uri(
                                                  scheme: 'mailto',
                                                  path:
                                                      '${snapshot.data?.docs[0].get('email')}',
                                                );

                                                var url = params.toString();
                                                launchUrlmail(url);
                                              },
                                              child: Text(
                                                'email: ${snapshot.data?.docs[0].get('email')}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Arial',
                                                    fontWeight: FontWeight.w600,
                                                    color: HexColor("#FFFFFF")),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            InkWell(
                                              onTap: () {
                                                launchURL(
                                                    '${snapshot.data?.docs[0].get('telegram')}');
                                              },
                                              child: Text(
                                                'telegram: ${snapshot.data?.docs[0].get('telegramName')}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Arial',
                                                    fontWeight: FontWeight.w600,
                                                    color: HexColor("#FFFFFF")),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            InkWell(
                                              onTap: () {
                                                launchURL(
                                                    '${snapshot.data?.docs[0].get('linkedin')}');
                                              },
                                              child: Text(
                                                'linkedIn: ${snapshot.data?.docs[0].get('name')}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Arial',
                                                    fontWeight: FontWeight.w600,
                                                    color: HexColor("#FFFFFF")),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            InkWell(
                                              onTap: () {
                                                _openPDF(
                                                    '${snapshot.data?.docs[0].get('cv')}');
                                                // launchURL(
                                                //     '${snapshot.data?.docs[0].get('cv')}');
                                              },
                                              child: Text(
                                                'cv: ${snapshot.data?.docs[0].get('name')} cv',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Arial',
                                                    fontWeight: FontWeight.w600,
                                                    color: HexColor("#FFFFFF")),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            InkWell(
                                              onTap: () {
                                                launchURL(
                                                    '${snapshot.data?.docs[0].get('git')}');
                                              },
                                              child: Text(
                                                'git: ${snapshot.data?.docs[0].get('name')} git',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Arial',
                                                    fontWeight: FontWeight.w600,
                                                    color: HexColor("#FFFFFF")),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              );
                            })
                      ],
                    ));
              }),
        ],
      ),
    );
  }

  Future<void> launchUrlmail(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void _makePhoneCall(String phoneNumber) async {
    var url = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openPdfFromUrl(String url) {
    debugPrint('opening PDF url = $url');
    var googleDocsUrl =
        'https://docs.google.com/gview?embedded=true&url=${Uri.encodeQueryComponent(url)}';
    debugPrint('opening Google docs with PDF url = $googleDocsUrl');
    final Uri uri = Uri.parse(googleDocsUrl);
    launchUrl(uri);
  }

  void _openPDF(String url) {
    var googleDocsUrl =
        'https://docs.google.com/gview?embedded=true&url=${Uri.encodeQueryComponent(url)}';
    final Uri uri = Uri.parse(googleDocsUrl);
    launchUrl(uri);
  }
}
