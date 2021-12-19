import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_group9/myworkshop.dart';
import 'package:intl/intl.dart';

List duration = ['1 H', '2 H', '3 H', ' 4 H'];
// ignore: prefer_typing_uninitialized_variables
var dropDownValue;
FirebaseAuth user = FirebaseAuth.instance;

class Workshop extends StatelessWidget {
  const Workshop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('workshop')
              .doc('AsBVN2Eu9SgaFK68CyR1')
              .snapshots(),
          builder: (context, dynamic snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            Map data = snapshot.data.data();

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.lightGreen.shade100,
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "Workshop",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightGreen.shade100,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const MyWorkShop()));
                          },
                          icon: const Icon(
                            Icons.schedule_outlined,
                            color: Colors.black,
                          ),
                          label: const Text(
                            'My Workshop',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontStyle: FontStyle.italic),
                          )),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    // height: 350,
                    // width: 400,
                    //  child: SingleChildScrollView(
                    // scrollDirection: Axis.vertical,
                    // child: SingleChildScrollView(
                    //scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 10,
                      dataRowHeight: 100,
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Programe',
                            style: TextStyle(
                                fontSize: 12, fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 12, fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 12, fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Session',
                            style: TextStyle(
                                fontSize: 12, fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(''),
                        ),
                      ],
                      rows: [
                        for (int i = 0; i < data['workshop'].length; i++)
                          DataRow(cells: [
                            DataCell(Text(
                              data['workshop'][i]['programe'],
                              style: const TextStyle(
                                  fontSize: 10, fontStyle: FontStyle.italic),
                            )),
                            DataCell(Text(
                              data['workshop'][i]['description'],
                              style: const TextStyle(
                                  fontSize: 10, fontStyle: FontStyle.italic),
                            )),
                            DataCell(Text(
                              DateFormat.yMMMd()
                                  .format(data['workshop'][i]['date'].toDate())
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                              ),
                            )),
                            DataCell(Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat.jm()
                                      .format(data['workshop'][i]['sessionFrom']
                                      .toDate())
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic),
                                ),
                                const Text(
                                  'to',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  DateFormat.jm()
                                      .format(data['workshop'][i]['sessionTo']
                                      .toDate())
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            )),
                            DataCell(
                              MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (_) => BookingForm(
                                            programmeName: data['workshop']
                                            [i]['programe'],
                                            date: DateFormat.yMMMd()
                                                .format(data['workshop'][i]
                                            ['date']
                                                .toDate())
                                                .toString(),
                                            index: data['workshop'][i],
                                          )));
                                },
                                color: Colors.lightGreen.shade100,
                                child: const Text(
                                  'Book',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                          ])
                      ],
                    ),
                    //  ),
                    //),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

// ignore: must_be_immutable
class BookingForm extends StatefulWidget {
  dynamic programmeName;
  dynamic date;
  dynamic duration;
  dynamic index;
  BookingForm({
    Key? key,
    this.programmeName,
    this.date,
    this.duration,
    this.index,
  }) : super(key: key);

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Form',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen.shade100,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Full Name :',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                alignLabelWithHint: false,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.white,
                  ),
                ),
                filled: true,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Programme Name :',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 15),
            TextFormField(
              initialValue: widget.programmeName,
              enabled: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Date :',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 15),
            TextFormField(
              initialValue: widget.date,
              enabled: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Duration :',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField(
              hint: const Align(
                alignment: Alignment.center,
              ),
              decoration: const InputDecoration(
                filled: true,
                hintStyle: TextStyle(
                  color: Color.fromRGBO(29, 29, 29, .4),
                ),
                hintText: 'Choose',
              ),
              value: dropDownValue,
              onChanged: (value) {
                setState(() {
                  dropDownValue = value;
                });
              },
              items: duration
                  .map((duration) => DropdownMenuItem(
                  value: duration, child: Text("$duration")))
                  .toList(),
            ),
            const SizedBox(height: 25),
            SizedBox(
              //color: Colors.lightGreen.shade100,
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      // Navigator.pop(context);
                      Map workshopData = {
                        'programe': widget.programmeName,
                        'date': widget.date,
                        'duration': dropDownValue ?? '1 H',
                        'userName': user.currentUser!.email,
                      };
                      await FirebaseFirestore.instance
                          .collection('workshop')
                          .doc('AsBVN2Eu9SgaFK68CyR1')
                          .update({
                        'workshop': FieldValue.arrayRemove([widget.index]),
                      });

                      await FirebaseFirestore.instance
                          .collection('myWorkshop')
                          .doc(user.currentUser!.uid)
                          .set({
                        'myWorkshop': FieldValue.arrayUnion([workshopData])
                      }, SetOptions(merge: true));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MyWorkShop()));
                    },
                    color: const Color(0xFF8BC34A),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "Booking",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),

                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
