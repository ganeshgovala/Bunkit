import 'package:bunkit/components/dialog_box.dart';
import 'package:bunkit/pages/add_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MarksStore extends StatelessWidget {
  const MarksStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 26.0, left: 26, right: 26),
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.arrow_back_ios_rounded, size: 24),
              ],
            ),
            SizedBox(height: 20),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc("23pa1a0577")
                    .collection("MarksStore")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    CustomDialog().showCustomDialog(
                        context, "Error", snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final data = snapshot.requireData;
                  if (data.size == 0) {
                    return Expanded(
                        child: Center(
                      child:
                          Image.asset("lib/assets/empty.jpg", height: 200),
                    ));
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("Count $index"),
                        );
                      },
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddCollection()));
                },
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 21, 21, 21),
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(
                      "New Collection",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
