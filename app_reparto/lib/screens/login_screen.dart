import 'package:flutter/material.dart';
import 'package:app_reparto/core/services/backend/auth_service.dart';
import '../form/login_form.dart';
import 'package:app_reparto/core/utils/dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Estado de la página de inicio de sesión
class _LoginScreenState extends State<LoginScreen> {
  // Clave global para validar el formulario
  final _formKey = GlobalKey<FormState>();
  // Controlador para el campo de usuario
  final _usernameController = TextEditingController();
  // Controlador para el campo de contraseña
  final _passwordController = TextEditingController();
  // Servicio de autenticación
  final _authService = AuthService();
  // Indicador de estado de carga
  bool _isLoading = false;

  // Método para manejar el proceso de inicio de sesión
  Future<void> _login() async {
    // Verifica si el formulario es válido
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Activa el indicador de carga
    setState(() {
      _isLoading = true;
    });

    try {
      // Intenta autenticar al usuario con el servicio
      await _authService.login(
        _usernameController.text,
        _passwordController.text,
      );

      // Verifica si el widget sigue montado antes de continuar
      if (mounted) {
        FocusScope.of(context).unfocus();
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
                  // Logo image
                  Image.asset(
                    'assets/repartologo.png',
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 32),
                  // Form container with border
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
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
  // Limpieza de recursos cuando se destruye el widget
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
