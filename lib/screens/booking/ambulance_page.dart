import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AmbulanceBookingsPage extends StatefulWidget {
  const AmbulanceBookingsPage({Key? key}) : super(key: key);

  @override
  State<AmbulanceBookingsPage> createState() => _AmbulanceBookingsPageState();
}

class _AmbulanceBookingsPageState extends State<AmbulanceBookingsPage> {
  var isClick = false;
  Future<void> delayFunction() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bookings')
          .where('status', isEqualTo: 'pending')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Material(
          child: isClick == true
              ? doneWidget(context)
              : ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return InkWell(
                      onTap: () async {
                        setState(() {
                          isClick = true;
                        });
                        await delayFunction();
                        setState(() {
                          isClick = false;
                        });
                      },
                      child: ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['phone']),
                        trailing: Text(data['status']),
                      ),
                    );
                  }).toList(),
                ),
        );
      },
    );
  }
}

Widget doneWidget(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          // child: RiveAnimation.network(
          //   'https://cdn.rive.app/animations/vehicles.riv',
          // ),
          // child: const RiveAnimation.asset(
          //   'assets/rive/done_checkmark.riv',
          //   fit: BoxFit.fill,
          // ),
        ),
        const Text(
          'Ambulance Booked',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ],
    ),
  );
}
