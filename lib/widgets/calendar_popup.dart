// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class CalendarPopup extends StatefulWidget {
  final Function(String) onDaySelected;

  const CalendarPopup({Key? key, required this.onDaySelected})
      : super(key: key);

  @override
  State<CalendarPopup> createState() => _CalendarPopupState();
}

class _CalendarPopupState extends State<CalendarPopup> {
  String? selectedDay;

  Widget _buildDayItem(String day) {
    final isSelected = selectedDay == day;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFD97B1E) : null,
        borderRadius: isSelected ? BorderRadius.circular(15) : null,
      ),
      height: 30,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        day,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(20, -230),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 4,
      color: const Color(0xFFFFF3E0),
      constraints: const BoxConstraints(minWidth: 200),
      icon: const Icon(
        Icons.calendar_month_outlined,
        color: Color(0xFFD97B1E),
        size: 30,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          height: 30,
          value: 'Lunes',
          child: _buildDayItem('Lunes'),
        ),
        PopupMenuItem<String>(
          height: 30,
          value: 'Martes',
          child: _buildDayItem('Martes'),
        ),
        PopupMenuItem<String>(
          height: 30,
          value: 'Miércoles',
          child: _buildDayItem('Miércoles'),
        ),
        PopupMenuItem<String>(
          height: 30,
          value: 'Jueves',
          child: _buildDayItem('Jueves'),
        ),
        PopupMenuItem<String>(
          height: 30,
          value: 'Viernes',
          child: _buildDayItem('Viernes'),
        ),
        PopupMenuItem<String>(
          height: 30,
          value: 'Sábado',
          child: _buildDayItem('Sábado'),
        ),
        PopupMenuItem<String>(
          height: 30,
          value: 'Domingo',
          child: _buildDayItem('Domingo'),
        ),
      ],
      onSelected: (String value) {
        setState(() {
          selectedDay = value;
        });
        widget.onDaySelected(value);
      },
    );
  }
}
