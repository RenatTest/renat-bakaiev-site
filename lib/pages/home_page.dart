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
                  return Center(
                    child: CircularProgressIndicator(
                      color: HexColor("#ff4119"),
                    ),
                  );
                }
                String backgroundimage =
                    snapshot.data?.docs[0].get('backgroundimage');
                return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(backgroundimage),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('contacts')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return SizedBox(
                                  height: 220,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: HexColor("#ff4119"),
                                    ),
                                  ),
                                );
                              }
                              String photo =
                                  snapshot.data?.docs[0].get('photo');

                              String description =
                                  snapshot.data?.docs[0].get('description');
                              String name = snapshot.data?.docs[0].get('name');
                              String phone =
                                  snapshot.data?.docs[0].get('phone');
                              String email =
                                  snapshot.data?.docs[0].get('email');
                              String telegram =
                                  snapshot.data?.docs[0].get('telegram');
                              String telegramName =
                                  snapshot.data?.docs[0].get('telegramName');
                              String linkedin =
                                  snapshot.data?.docs[0].get('linkedin');
                              String cv = snapshot.data?.docs[0].get('cv');
                              String git = snapshot.data?.docs[0].get('git');
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
                                        const SizedBox(height: 20),
                                        Photo(
                                          image: photo,
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          width: 220,
                                          child: Text(
                                            'About me:\n$description',
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
                                              'name: $name',
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
                                                _makePhoneCall(phone);
                                              },
                                              child: Text(
                                                'phone: $phone',
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
                                                  path: email,
                                                );

                                                var url = params.toString();
                                                launchUrlmail(url);
                                              },
                                              child: Text(
                                                'email: $email',
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
                                                launchURL(telegram);
                                              },
                                              child: Text(
                                                'telegram: $telegramName',
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
                                                launchURL(linkedin);
                                              },
                                              child: Text(
                                                'linkedIn: $name',
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
                                                _openPDF(cv);
                                              },
                                              child: Text(
                                                'cv: $name cv',
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
                                                launchURL(git);
                                              },
                                              child: Text(
                                                'git: $name git',
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

//
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

  void _openPDF(String url) {
    var googleDocsUrl =
        'https://docs.google.com/gview?embedded=true&url=${Uri.encodeQueryComponent(url)}';
    final Uri uri = Uri.parse(googleDocsUrl);
    launchUrl(uri);
  }
}
