class RecordClass{
  final String User;
  final int Total;
  final String action;
  final String date;
  final String time;


  RecordClass({this.User='',this.Total = 0, this.action = '', this.date = '', this.time = ''});

  factory RecordClass.fromRTDB(Map<String, dynamic> data) {
    return RecordClass(User:data['User'],Total: data['Total'], date: data['date'], time: data['time'],);
  }

}