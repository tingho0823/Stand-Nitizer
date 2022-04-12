import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testtt/app/annoucement/getDateTime.dart';


class AddAnnouncement extends StatefulWidget{
  @override
  _AddAnnouncementState createState() => _AddAnnouncementState();
}

class _AddAnnouncementState extends State<AddAnnouncement> {

  final database = FirebaseDatabase.instance.reference();

  final _formKey = GlobalKey<FormState>();
  final _announcementController = TextEditingController();
  final _titleController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Announcement'),
        elevation: 2.0,
      ),
      body: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            SizedBox(
              height: 24.0,
            ),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Announcement Title',
                labelText: 'Announcement Title',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Please type in announcement title';
                }
                return null;
              },
            ),
            SizedBox(
              height: 24.0,
            ),
            TextFormField(
              controller: _announcementController,
              decoration: InputDecoration(
                hintText: 'Announcement',
                labelText: 'Announcement',
                prefixIcon: Icon(Icons.announcement),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 5,
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Please type in announcement';
                }
                return null;
              },
            ),
            SizedBox(
              height: 24.0,
            ),
            SizedBox(
              height: 40.0,
              child: ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _addAnnouncement();
                  }
                },
                child: (_isLoading) ? CircularProgressIndicator(color: Colors.white,) :  Text(
                  'Announce',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.indigo),
                    shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            )))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    _announcementController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _addAnnouncement() async {
    final String date = getDate();
    final String time = getTime();

    setState(() {
      _isLoading = true;
    });

    try {


      final announcementDb = database.child('announcement');
      final idDatabase = database.child('id');

      //int annId = 0;

      // await idDatabase.child('announcementid').get().then((snapshot) {
      //   final currentId = snapshot.value.toString();
      //   print(currentId);
      //   setState(() {
      //     annId = int.parse(currentId);
      //   });
      // });

      String annTitle = _titleController.text;

      await announcementDb.child(annTitle).set({
        'date': date,
        'time': time,
        'content': _announcementController.text,
        'title' : _titleController.text
      });

      //await idDatabase.update({'announcementid' : annId+1});

      printAlertDialogWithExit('Congratulations', 'Announcement uploaded');

    } catch (e){
      printAlertDialog('Alert', '$e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void printAlertDialog<string>(String title, String message) {
    showDialog(context: context, builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Ok');
            _isLoading = false;
          },
          child: Text('Ok'),
        ),
      ],

    ));
  }

  void printAlertDialogWithExit(String title, String message) {
    showDialog(context: context, builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            setState(() {
              _isLoading = false;
            });
          } ,
          child: Text('Ok'),
        ),
      ],

    ));
  }
}