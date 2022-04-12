import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:testtt/app/sign_in/RecordClass.dart';

import 'member_event_button.dart';


class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record List'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }
}
final _database = FirebaseDatabase.instance.reference();

Widget _buildContent(BuildContext context) {
  return Container(
    child: StreamBuilder(
      stream: _database.child('record').orderByKey().limitToLast(100).onValue,
      builder: (context, snapshot){
        final eventListFDB = <RecordClass>[];
        if(snapshot.hasData && (snapshot.data! as DatabaseEvent).snapshot.value != null){
          final myEvents = Map<String, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map);
          myEvents.forEach((key, value) {
            final nextEvent = RecordClass.fromRTDB(Map<String, dynamic>.from(value));
            eventListFDB.add(nextEvent);
          });
        }
        final eventList = List.from(eventListFDB.reversed);
        return (eventList.isEmpty) ? Center(
          child: Text(
            'No Record Currently',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ) : ListView.separated(
          padding: EdgeInsets.all(16.0),
          itemCount: eventList.length,
          itemBuilder: (BuildContext context, int index){
            return MemberEventButton(
              borderRadius: 10.0,
              onPressed: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDetailAdmin(eventID: eventList[index].id,attendanceID: eventList[index].attendanceId,eventName: eventList[index].name,)));
              },
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 4.0,
                  ),
                  Text('User: ${eventList[index].User}',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  Text('Total: ${eventList[index].Total}',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text('Action Date: ${eventList[index].date}',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text('Action Time: ${eventList[index].time}',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                ],
              ),);
          }, separatorBuilder: (BuildContext context, int index) => const Divider() ,
        );
      },
    ),

  );
}