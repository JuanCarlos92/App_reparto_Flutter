import 'package:flutter/material.dart';
import 'package:app_reparto/services/auth_service.dart';
import '../form/login_form.dart';
import 'package:app_reparto/utils/dialog_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  // Método para manejar el inicio de sesión
  Future<void> _login() async {
    // Verifica si el formulario es válido
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Llama al servicio de autenticación
      await _authService.login(
        _usernameController.text,
        _passwordController.text,
      );

      // Verifica si el widget sigue en el árbol de widgets
      if (mounted) {
        // Cierra el teclado
        FocusScope.of(context).unfocus();
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
          arguments: _usernameController.text,
        );
      }
    } catch (e) {
      // Muestra un diálogo de error si ocurre una excepción
      if (mounted) {
        DialogUtils.showErrorDialog(context, e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Estructura principal
    return Scaffold(
      // Contenedor principal ocupando toda la pantalla
      body: Container(
        // Configura el fondo de la pantalla con un degradado
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 200, 120, 20),
              Color.fromARGB(255, 252, 231, 197),

              // Color(0xFF0D3A21),
              // Color(0xFF1E5631),
              // Color(0xFF4FC98E),
            ],
            // stops: [0.0, 1],
          ),
        ),

        // Centra su contenido en la pantalla
        child: Center(
          // Contenedor que ocupa el 90% del ancho de la pantalla
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              // Contenedor que contiene el contenido de la pantalla
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_shipping,
                    size: 80,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        // Sombra del texto
                        blurRadius: 8,
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Título de la aplicación
                  Text(
                    'APP REPARTO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      shadows: [
                        Shadow(
                          // Sombra del texto
                          blurRadius: 8,
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Tarjeta que contiene el formulario de inicio de sesión
                  Card(
                    // Efecto de sombra en la tarjeta
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    // ignore: deprecated_member_use
                    color: Colors.white,
                    // color: Color.fromARGB(255, 189, 235, 247).withOpacity(1),

                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
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
  void dispose() {
    _usernameController.dispose(); // Libera el controlador del usuario
    _passwordController.dispose(); // Libera el controlador de la contraseña
    super.dispose();
  }
}
