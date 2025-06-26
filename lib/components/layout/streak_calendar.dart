import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class StreakCalendar extends StatefulWidget {
  final String currentDate;
  final List<String> learnedDays;

  const StreakCalendar({
    super.key,
    required this.currentDate,
    required this.learnedDays,
  });

  @override
  State<StreakCalendar> createState() => _StreakCalendarState();
}

class _StreakCalendarState extends State<StreakCalendar> {
  late DateTime _focusedDay;
  late Map<DateTime, Color> _markedDates;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('vi_VN', null);
    _focusedDay = _normalizeDate(DateTime.parse(widget.currentDate));
    _markedDates = _generateMarkedDates();
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Map<DateTime, Color> _generateMarkedDates() {
    final current = _normalizeDate(DateTime.parse(widget.currentDate));
    final year = current.year;
    final Map<DateTime, Color> result = {};

    for (int month = 1; month <= 12; month++) {
      final daysInMonth = DateUtils.getDaysInMonth(year, month);
      for (int day = 1; day <= daysInMonth; day++) {
        final date = _normalizeDate(DateTime(year, month, day));
        final dateStr = DateFormat('yyyy-MM-dd').format(date);

        if (widget.learnedDays.contains(dateStr)) {
          result[date] = Colors.deepOrangeAccent;
        } else if (date.isBefore(current) || date.isAtSameMomentAs(current)) {
          result[date] = Colors.lightBlueAccent;
        }
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'vi_VN',
      focusedDay: _focusedDay,
      firstDay: DateTime(_focusedDay.year, 1, 1),
      lastDay: DateTime(_focusedDay.year, 12, 31),
      calendarFormat: CalendarFormat.month,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.orange),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.orange),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          final color = _markedDates[_normalizeDate(day)];
          if (color != null) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${day.day}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
