import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // Instancia estática del plugin de notificaciones
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // Método para inicializar el servicio de notificaciones
  static Future<void> initialize() async {
    try {
      // Configuración inicial para Android usando el icono por defecto de la app
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      // Configuración general de inicialización
      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
      );

      // Configuración específica para Android
      if (Platform.isAndroid) {
        // ignore: avoid_print
        print('Debug - Creating canal de notificacion de android...');
        final androidPlugin =
            _notifications.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();

        // Verificación de que se obtuvo correctamente el plugin de Android
        if (androidPlugin == null) {
          // ignore: avoid_print
          print('Debug - fallo al obtener Android plugin instance');
          return;
        }

        // Creación del canal de notificaciones para Android
        await androidPlugin.createNotificationChannel(
          const AndroidNotificationChannel(
            'pomodoro_channel', // ID único del canal
            'Descansos', // Nombre del canal
            description: 'Notificaciones de descansos programados',
            importance: Importance.max, // Importancia máxima
          ),
        );
        // ignore: avoid_print
        print('Debug - Canal de notificiaciones creado correctamente');
      }

      // Inicialización final del servicio de notificaciones
      await _notifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) async {
          // ignore: avoid_print
          print('Debug - Notificacion recibida: ${details.payload}');
        },
      );
      // ignore: avoid_print
      print('Debug - Notificaciones inicializada correctamente');
    } catch (e) {
      // ignore: avoid_print
      print('Debug - Error al inicializar notificaciones: $e');
    }
  }

  // Método para mostrar la notificación de descanso
  static Future<void> showBreakNotification() async {
    try {
      // Configuración de detalles específicos para Android
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'pomodoro_channel', // ID del canal (debe coincidir con el creado arriba)
        'Descansos',
        channelDescription: 'Notificaciones de descansos programados',
        importance: Importance.max, // Prioridad máxima
        priority: Priority.high,
        playSound: true, // Reproducir sonido
        enableVibration: true, // Habilitar vibración
      );

      // Configuración general de la notificación
      const NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails,
      );

      // Mostrar la notificación
      await _notifications.show(
        0, // ID de la notificación
        '¡Tiempo de descanso!', // Título
        'Es momento de tomar un breve descanso', // Mensaje
        platformDetails,
      );
    } catch (e) {
      // ignore: avoid_print
      print('Debug - Error mostrar notification: $e');
    }
  }
}
