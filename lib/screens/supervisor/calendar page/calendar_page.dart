import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      body: Column(
        children: [
          // Status INDICATOR INFO
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10,
              children: [
                statusIndicator("Present", Colors.green),
                statusIndicator("Absent", Colors.red),
                statusIndicator("Leave", Colors.blue),
                statusIndicator("Week Off", Colors.grey),
                statusIndicator("Late", Colors.pink),
                statusIndicator("Early", Colors.purple),
                statusIndicator("Late & Early", Colors.brown),
              ],
            ),
          ),

          // Calendar
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2025, 1, 1),
                lastDay: DateTime.now(),
                focusedDay: DateTime.now(),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false,
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, _) {
                    return Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: getColorForDate(date),
                        shape: BoxShape.rectangle,
                        border: Border.all(width: 0.5, color: Colors.grey)
                        // borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "${date.day}",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Status Indicator Widget
  Widget statusIndicator(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 12, color: color),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  // Attendance Color Mapping
  Color getColorForDate(DateTime date) {
    if ([1, 3, 4, 17].contains(date.day)) return Colors.green;
    if ([7, 14].contains(date.day)) return Colors.red;
    if ([15].contains(date.day)) return Colors.blue;
    if ([16].contains(date.day)) return Colors.purple;
    if ([10].contains(date.day)) return Colors.pink;
    if ([26, 27, 28].contains(date.day)) return Colors.grey;
    return Colors.grey.shade200;
  }
}
