import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

FirebaseAuth user = FirebaseAuth.instance;

class MyWorkShop extends StatefulWidget {
  const MyWorkShop({Key? key}) : super(key: key);

  @override
  State<MyWorkShop> createState() => _MyWorkShopState();
}

class _MyWorkShopState extends State<MyWorkShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen.shade100,
          elevation: 0.0,
        ),
        backgroundColor: Colors.lightGreen.shade100,
        body: Scaffold(
          backgroundColor: Colors.lightGreen.shade100,
          body: StreamBuilder<dynamic>(
              stream: FirebaseFirestore.instance
                  .collection('myWorkshop')
                  .doc(user.currentUser!.uid)
                  .snapshots(),
              builder: (context, dynamic snapshot) {
                if (snapshot.hasError || !snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Colors.lightGreen.shade100,
                        width: double.infinity,
                        child: const Center(
                          child: Text(
                            "My Workshop",
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
                                setState(() {});
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.event_note_outlined,
                                color: Colors.black,
                              ),
                              label: const Text(
                                'Workshop',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic),
                              )),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 350,
                        width: 400,
                        child: const Center(
                          child: Text(' There is No Workshop yet'),
                        ),
                      ),
                    ],
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                dynamic data = snapshot.data!.data();

                return data == null || data['myWorkshop'].isEmpty
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.lightGreen.shade100,
                      width: double.infinity,
                      child: const Center(
                        child: Text(
                          "My Workshop",
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
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.event_note_outlined,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Workshop',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic),
                            )),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 350,
                      width: 400,
                      child: const Center(
                        child: Text(' There is No Workshop yet'),
                      ),
                    ),
                  ],
                )
                    : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Colors.lightGreen.shade100,
                        width: double.infinity,
                        child: const Center(
                          child: Text(
                            "My Workshop",
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
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
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.event_note_outlined,
                                color: Colors.black,
                              ),
                              label: const Text(
                                'Workshop',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic),
                              )),
                        ),
                      ),
                      Container(
                          color: Colors.white,
                          height: 350,
                          width: 400,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            // child: SingleChildScrollView(
                            //scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 10,
                              dataRowHeight: 100,
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    'Id',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
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
                                for (int i = 0;
                                i < data['myWorkshop'].length;
                                i++)
                                  DataRow(cells: [
                                    DataCell(Text(
                                      '${i + 1}'.toString(),
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic),
                                    )),
                                    DataCell(Text(
                                      data['myWorkshop'][i]['programe'],
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic),
                                    )),
                                    DataCell(Text(
                                      DateFormat.yMMMd()
                                          .format(data['myWorkshop'][i]
                                      ['date']
                                          .toDate())
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic),
                                    )),
                                    DataCell(
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            DateFormat.jm()
                                                .format(data['myWorkshop']
                                            [i]['sessionFrom']
                                                .toDate())
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontStyle:
                                                FontStyle.italic),
                                          ),
                                          const Text(
                                            'to',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontStyle:
                                                FontStyle.italic),
                                          ),
                                          Text(
                                            DateFormat.jm()
                                                .format(data['myWorkshop']
                                            [i]['sessionTo']
                                                .toDate())
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
                                        onPressed: () async {
                                          setState(() {});
                                          await FirebaseFirestore.instance
                                              .collection('myWorkshop')
                                              .doc(user.currentUser!.uid)
                                              .update({
                                            'myWorkshop':
                                            FieldValue.arrayRemove([
                                              data['myWorkshop'][i]
                                            ]),
                                          });
                                          Navigator.pop(context);
                                        },
                                        color: Colors.red.shade100,
                                        child: const Text(
                                          'Cencel',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontStyle:
                                              FontStyle.italic),
                                        ),
                                      ),
                                    ),
                                  ])
                              ],
                            ),
                            //  ),
                          )),
                    ],
                  ),
                );
              }),
        ));
  }
}
