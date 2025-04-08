import 'package:flutter/material.dart';
import 'package:app_reparto/services/auth_service.dart';
import '../form/login_form.dart';
import 'package:app_reparto/utils/dialog_utils.dart';

// Página de inicio de sesión que mantiene estado
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Estado de la página de inicio de sesión
class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();  // Clave global para validar el formulario
  final _usernameController = TextEditingController();  // Controlador para el campo de usuario
  final _passwordController = TextEditingController();  // Controlador para el campo de contraseña
  final _authService = AuthService();  // Servicio de autenticación
  bool _isLoading = false;  // Indicador de estado de carga

  // Método para manejar el proceso de inicio de sesión
  Future<void> _login() async {
    // Verifica si el formulario es válido
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;  // Activa el indicador de carga
    });

    try {
      // Intenta autenticar al usuario con el servicio
      await _authService.login(
        _usernameController.text,
        _passwordController.text,
      );

      // Verifica si el widget sigue montado antes de continuar
      if (mounted) {
        FocusScope.of(context).unfocus();  // Cierra el teclado
        // Navega a la página principal y elimina el historial de navegación
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
          arguments: _usernameController.text,
        );
      }
    } catch (e) {
      // Maneja los errores mostrando un diálogo
      if (mounted) {
        DialogUtils.showErrorDialog(context, e.toString());
      }
    } finally {
      // Desactiva el indicador de carga al finalizar
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior de la aplicación
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 120, 20),
        centerTitle: true,
        title: const Text(
          'App Reparto',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Roboto',
            shadows: [
              Shadow(
                blurRadius: 8,
                color: Color.fromRGBO(0, 0, 0, 0.3),
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      ),
      // Contenedor principal con scroll
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tarjeta que contiene el formulario de login
                  Card(
                    elevation: 8,  // Elevación para efecto de sombra
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 200, 120, 20),
                        width: 1.5,
                      ),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      // Widget de formulario personalizado
                      child: LoginForm(
                        formKey: _formKey,
                        usernameController: _usernameController,
                        passwordController: _passwordController,
                        isLoginForm: true,
                        onLogin: _login,
                        toggleForm: () {},
                        isLoading: _isLoading,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // Limpieza de recursos cuando se destruye el widget
  void dispose() {
    _usernameController.dispose();  // Libera el controlador del usuario
    _passwordController.dispose();  // Libera el controlador de la contraseña
    super.dispose();
  }
}
