import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCollection extends StatefulWidget {
  @override
  _AddCollectionState createState() => _AddCollectionState();
}

class _AddCollectionState extends State<AddCollection> {
  final List<TextEditingController> _subControllers = [];
  final List<TextEditingController> _markControllers = [];
  @override
  void initState() {
    super.initState();
    _addTextField();
  }

  Future<void> addData(String reg_no) async {
    Map<String, dynamic> data = {};
    print(_markControllers.length);
    for(int i = 0; i < _subControllers.length - 1; i++) {
      data[_subControllers[i].text] = _markControllers[i].text;
    }
    FirebaseFirestore.instance.collection("Users")
    .doc(reg_no).collection("MarksStore").doc()
    .set(data);
  }

  void _addTextField() {
    final subController = TextEditingController();
    final markController = TextEditingController();
    subController.addListener(() {
      final isLastField = _subControllers.last == subController;

      if (isLastField) {
        if (subController.text.isNotEmpty) {
          setState(() {
            _addTextField();
          });
        }
      } else {
        if (subController.text.isEmpty && _subControllers.length > 1) {
          if (_subControllers[_subControllers.length - 2].text.isEmpty) {
            setState(() {
              _subControllers.remove(subController);
              _markControllers.remove(markController);
            });
          }
        }
      }
    });
    setState(() {
      _subControllers.add(subController);
      _markControllers.add(markController);
    });
  }

  @override
  void dispose() {
    for (var controller in _subControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_rounded, size: 24)),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Add Collection",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Enter Subject name and Marks",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: const Color.fromARGB(255, 75, 75, 75),
              ),
            ),
            SizedBox(height: 20),
            TextField(
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 19, 19, 19),
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                    hintText: "Collection Name",
                    hintStyle: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 103, 103, 103),
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: const Color.fromARGB(255, 31, 31, 31),
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: const Color.fromARGB(255, 31, 31, 31),
                        )))),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                itemCount: _subControllers.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontWeight: FontWeight.w500,
                              ),
                              controller: _subControllers[index],
                              decoration: InputDecoration(
                                  hintText: "Subject Name",
                                  hintStyle: GoogleFonts.poppins(
                                    color: const Color.fromARGB(
                                        255, 103, 103, 103),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: const Color.fromARGB(
                                            255, 31, 31, 31),
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: const Color.fromARGB(
                                            255, 31, 31, 31),
                                      ))),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: _markControllers[index],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontWeight: FontWeight.w500,
                              ),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Marks",
                                hintStyle: GoogleFonts.poppins(
                                  color:
                                      const Color.fromARGB(255, 103, 103, 103),
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color:
                                          const Color.fromARGB(255, 31, 31, 31),
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color:
                                          const Color.fromARGB(255, 31, 31, 31),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                    ],
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                addData("reg_no");
              },
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 21, 21, 21),
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    "Add Collection",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
