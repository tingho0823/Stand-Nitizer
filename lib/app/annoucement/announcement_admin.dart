
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:testtt/app/annoucement/announcement.dart';
import 'add_announcement.dart';

class AnnouncementAdmin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcement'),
        elevation: 2.0,

      ),
      body: _buildContext(context),
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAnnouncement()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }

  final database = FirebaseDatabase.instance.reference();

  Widget _buildContext(BuildContext context) {
    return Container(
        child: StreamBuilder(
          stream: database.child('announcement').orderByChild('time').onValue,
          builder: (context, snapshot){
            final announcementListFDB = <Announcement>[];
            if(snapshot.hasData && (snapshot.data! as DatabaseEvent).snapshot.value != null){
              final myAnnouncements = Map<String, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map);
              myAnnouncements.forEach((key, value) {
                final nextAnnouncement = Announcement.fromRTDB(Map<String, dynamic>.from(value));
                announcementListFDB.add(nextAnnouncement);
              });
            }
            final announcementList = announcementListFDB;
            return (announcementList.isEmpty) ? Center(
              child: Text(
                'No Announcement',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ) : ListView.separated(
              padding: EdgeInsets.all(16.0),
              itemCount: announcementList.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  padding: EdgeInsets.all(10.0),

                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        announcementList[index].title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize:22,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),

                      SizedBox(
                        height: 2.0,
                      ),
                      Text('Announcement Date:  ${announcementList[index].date}',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text('Announcement Time:  ${announcementList[index].time}',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(announcementList[index].content,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_forever, color: Colors.red,),
                        onPressed: (){
                          _deleteAnnouncement(context,announcementList[index].title);
                        },
                      ),
                    ],
                  ),);
              }, separatorBuilder: (BuildContext context, int index) => const Divider() ,
            );
          },
        )
    );
  }


  void _deleteAnnouncement(BuildContext context, String announcementTitle) {
    showDialog(context: context, builder: (BuildContext context) => AlertDialog(
      title: Text('Delete Announcement'),
      content: Text('Are you sure you want to delete $announcementTitle ?'),
      actions: [
        TextButton(
          onPressed: () async {
            try{
              await database.child('announcement').child(announcementTitle).remove();
              Navigator.pop(context);
              printAlertDialog(context, 'Successful', 'Announcement $announcementTitle is deleted');
            } catch(e){
              printAlertDialog(context, 'Error', '$e');
            }
          },
          child: Text('Delete'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
      ],

    ));
  }

  void printAlertDialog( BuildContext context,String title, String message) {
    showDialog(context: context, builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Ok'),
        ),
      ],

    ));
  }

}