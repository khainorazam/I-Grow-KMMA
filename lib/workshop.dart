import 'package:flutter/material.dart';

List duration = ['1 H', '2 H', '3 H', ' 4 H'];
// ignore: prefer_typing_uninitialized_variables
var dropDownValue;

class Workshop extends StatelessWidget {
  const Workshop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            color: Colors.lightGreen.shade100,
            width: double.infinity,
            child: const Center(
              child: Text(
                "Workshop",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Programme Name',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Session',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(''),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text(
                            'Pucuk Ubi',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          const DataCell(Text(
                            'pucuk abi',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          const DataCell(Text(
                            'March 19,2021',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          const DataCell(Text(
                            '8.00am-12.00pm',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          DataCell(
                            MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (_) => BookingForm(
                                              programmeName: 'Pucuk Ubi',
                                              date: 'March 19,2021',
                                            )));
                              },
                              color: Colors.lightGreen.shade100,
                              child: const Text(
                                'Book',
                                style: TextStyle(
                                    fontSize: 15, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text(
                            'Carrot',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          const DataCell(Text(
                            'Carrot',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          const DataCell(Text(
                            'May 18,2021',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          const DataCell(Text(
                            '8.00am-12.00pm',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          DataCell(
                            MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (_) => BookingForm(
                                              programmeName: 'Carrot',
                                              date: 'May 18,2021',
                                            )));
                              },
                              color: Colors.lightGreen.shade100,
                              child: const Text(
                                'Book',
                                style: TextStyle(
                                    fontSize: 15, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text(
                            'Cili Padi',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          const DataCell(Text(
                            'Penanaman cili padi ini memerlukan ilmu yang tepat',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          const DataCell(Text(
                            'May 1,2021',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          const DataCell(Text(
                            '8.00am-12.00pm',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          DataCell(
                            MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (_) => BookingForm(
                                              programmeName: 'Cili Padi',
                                              date: 'May 1,2021',
                                            )));
                              },
                              color: Colors.lightGreen.shade100,
                              child: const Text(
                                'Book',
                                style: TextStyle(
                                    fontSize: 15, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text(
                            'Kubis bunga',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          const DataCell(Text(
                            'Kubis bunga',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          const DataCell(Text(
                            'June 30,2021',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          const DataCell(Text(
                            '8.00am-12.00pm',
                            style: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          )),
                          DataCell(
                            MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (_) => BookingForm(
                                              programmeName: 'Kubis bunga',
                                              date: 'June 30,2021',
                                            )));
                              },
                              color: Colors.lightGreen.shade100,
                              child: const Text(
                                'Book',
                                style: TextStyle(
                                    fontSize: 15, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class BookingForm extends StatefulWidget {
  dynamic programmeName;
  dynamic date;
  dynamic duration;
  BookingForm({
    Key? key,
    this.programmeName,
    this.date,
    this.duration,
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
                    onPressed: () {
                      Navigator.pop(context);
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
