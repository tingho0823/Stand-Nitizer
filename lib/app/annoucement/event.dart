class EventClass{
  final String date;
  final String description;
  final int id;
  final String name;
  final String time;
  final String venue;
  final String attendanceId;

  EventClass({this.date = '', this.description = '', this.id = -1, this.name = '', this.time = '', this.venue = '', this.attendanceId = ''});

  factory EventClass.fromRTDB(Map<String, dynamic> data) {
    return EventClass(id: data['id'], name: data['name'], date: data['date'], description: data['description'], time: data['time'], venue: data['venue'], attendanceId: data['attendance_id']);
  }

}