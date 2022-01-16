import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_group9/myworkshop.dart';
import 'package:intl/intl.dart';

// ignore: prefer_typing_uninitialized_variables

FirebaseAuth user = FirebaseAuth.instance;
String? userName;
Map? myWorkShop;

getUserName() async {
  final data = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.currentUser!.uid)
      .get();

  userName = data.data()!['username'];
}

class Workshop extends StatefulWidget {
  const Workshop({Key? key}) : super(key: key);

  @override
  State<Workshop> createState() => _WorkshopState();
}

class _WorkshopState extends State<Workshop> {
  @override
  Widget build(BuildContext context) {
    getUserName();
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('workshop').snapshots(),
          builder: (context, dynamic snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            List data = snapshot.data.docs.toList();
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
                      child: IconButton(
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: SearchProgramme(data: data));
                        },
                        icon: const Icon(Icons.search),
                      ),
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
                    child: data.isEmpty
                        ? const Text('')
                        : DataTable(
                      columnSpacing: 10,
                      dataRowHeight: 100,
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Programe',
                            style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Session',
                            style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(''),
                        ),
                      ],
                      rows: [
                        for (int i = 0; i < data.length; i++)
                          DataRow(cells: [
                            DataCell(Text(
                              data[i]['programe'],
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic),
                            )),
                            DataCell(Text(
                              data[i]['description'],
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic),
                            )),
                            DataCell(Text(
                              DateFormat.yMMMd()
                                  .format(data[i]['date'].toDate())
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                              ),
                            )),
                            DataCell(
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat.jm()
                                        .format(data[i]['sessionFrom']
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
                                        .format(
                                        data[i]['sessionTo'].toDate())
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DataCell(
                              MaterialButton(
                                onPressed: () {
                                  data[i]['users'].any((element) =>
                                  element ==
                                      user.currentUser!.uid) ==
                                      true
                                      ? showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: const Text(
                                            'You are aleardy Book this Programme'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(
                                                    context),
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                      : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (_) => BookingForm(
                                            programmeName: data[i]
                                            ['programe'],
                                            date: data[i]['date'],
                                            description: data[i]
                                            ['description'],
                                            index: data[i],
                                            sessionFrom: data[i]
                                            ['sessionFrom'],
                                            sessiontTo: data[i]
                                            ['sessionTo'],
                                            docId: data[i].id,
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
      // floatingActionButton: ElevatedButton.icon(
      //   style: ElevatedButton.styleFrom(
      //     primary: Colors.lightGreen.shade100,
      //   ),
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (_) => const MyWorkShop()));
      //   },
      //   icon: const Icon(
      //     Icons.schedule_outlined,
      //     color: Colors.black,
      //   ),
      //   label: const Text(
      //     'My Workshop',
      //     style: TextStyle(
      //         color: Colors.black, fontSize: 10, fontStyle: FontStyle.italic),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyWorkShop()));
        },
        child: const Icon(Icons.schedule_outlined),
        backgroundColor: Colors.green[700],
        tooltip: "My Workshop",
      ),
    );
  }
}

class SearchProgramme extends SearchDelegate {
  List? data;
  SearchProgramme({this.data});
  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear)),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) => Center(child: Text(query));

  @override
  Widget buildSuggestions(BuildContext context) {
    dynamic searchList = query.isEmpty
        ? data
        : data!.where((value) => value['programe'].startsWith(query)).toList();
    return ListView.builder(
      itemCount: searchList!.length,
      itemBuilder: (context, i) {
        return ListTile(
            title: Text(searchList[i]['programe']),
            onTap: () {
              query = searchList[i]['programe'];
              showResults(context);
            });
      },
    );
  }
}

// ignore: must_be_immutable
class BookingForm extends StatefulWidget {
  dynamic programmeName;
  dynamic date;
  dynamic description;
  dynamic sessionFrom;
  dynamic sessiontTo;
  dynamic index;
  dynamic docId;
  BookingForm({
    Key? key,
    this.programmeName,
    this.date,
    this.description,
    this.sessionFrom,
    this.sessiontTo,
    this.index,
    this.docId,
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
              initialValue: userName,
              enabled: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
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
              initialValue:
              DateFormat.yMMMd().format(widget.date.toDate()).toString(),
              enabled: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Session :',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 15),
            TextFormField(
              initialValue:
              '${DateFormat.jm().format(widget.sessiontTo.toDate()).toString()} to ${DateFormat.jm().format(widget.sessionFrom.toDate()).toString()}',
              enabled: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
              ),
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
                        'description': widget.description,
                        'sessionTo': widget.sessiontTo,
                        'sessionFrom': widget.sessionFrom,
                        'userName': user.currentUser!.email,
                        'workshopId': widget.docId,
                      };
                      await FirebaseFirestore.instance
                          .collection('workshop')
                          .doc(widget.docId)
                          .set({
                        'users': FieldValue.arrayUnion([user.currentUser!.uid]),
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
