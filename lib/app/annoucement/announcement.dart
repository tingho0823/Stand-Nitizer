class Announcement{

  final String date;
  final String content;
  final String time;
  final String title;

  Announcement({this.date = '', this.content = '', this.time = '', this.title = ''});

  factory Announcement.fromRTDB(Map<String, dynamic> data){
    return Announcement(date: data['date'], content: data['content'], time: data['time'], title: data['title']);
  }
}