import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool _notificationsEnabled = false;
  TimeOfDay? _notificationTime;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid || Platform.isIOS) {
      _initializeNotifications();
    }
  }

  void _initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin!.initialize(initializationSettings);
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });

    if (_notificationsEnabled) {
      _selectNotificationTime();
    } else {
      _cancelNotification();
    }
  }

  Future<void> _selectNotificationTime() async {
    if (flutterLocalNotificationsPlugin == null) return;

    final TimeOfDay initialTime =
        TimeOfDay(hour: 0, minute: _notificationTime?.minute ?? 0);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null && (picked.minute != _notificationTime?.minute)) {
      setState(() {
        _notificationTime = TimeOfDay(hour: 0, minute: picked.minute);
      });
      _scheduleNotification();
    }
  }

  Future<void> _scheduleNotification() async {
    if (flutterLocalNotificationsPlugin == null) return;

    tz.initializeTimeZones();
    final DateTime now = DateTime.now();
    final DateTime scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      _notificationTime!.hour,
      _notificationTime!.minute,
    );

    if (scheduledTime.isBefore(now)) {
      // If the scheduled time is in the past, schedule for the next day
      scheduledTime.add(const Duration(days: 1));
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin!.zonedSchedule(
      0,
      'Notificacion de Jornada Laboral',
      'Es hora de tomar un descanso!',
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _cancelNotification() async {
    if (flutterLocalNotificationsPlugin == null) return;
    await flutterLocalNotificationsPlugin!.cancel(0);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(
        Icons.notifications,
        color: Colors.black,
      ),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              const Text('Activar notificación'),
              Switch(
                value: _notificationsEnabled,
                onChanged: _toggleNotifications,
              ),
            ],
          ),
        ),
        if (_notificationsEnabled)
          PopupMenuItem<int>(
            value: 1,
            child: ListTile(
              title: const Text('Tiempo Notificacion'),
              subtitle: Text(
                _notificationTime == null
                    ? 'Not set'
                    : '${_notificationTime!.hour.toString().padLeft(2, '0')}:${_notificationTime!.minute.toString().padLeft(2, '0')}',
              ),
              onTap: _selectNotificationTime,
            ),
          ),
      ],
      onSelected: (value) {
        if (value == 1) {
          _selectNotificationTime();
        }
      },
    );
  }
}
