import 'package:app_reparto/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
// Clave global para validar el formulario
  final GlobalKey<FormState> formKey;
  // Controlador para el campo de usuario
  final TextEditingController usernameController;
  // Controlador para el campo de contraseña
  final TextEditingController passwordController;
  // Indica si es formulario de login
  final bool isLoginForm;
  // Función que se ejecuta al iniciar sesión
  final VoidCallback onLogin;
  // Función para alternar entre formularios
  final VoidCallback toggleForm;
  // Indica si está cargando
  final bool isLoading;

  // Constructor
  const LoginForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.isLoginForm,
    required this.onLogin,
    required this.toggleForm,
    required this.isLoading,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

// Estado del formulario de login
class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Iniciar Sesión',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: widget.usernameController,
            decoration: InputDecoration(
              labelText: 'Usuario',
              prefixIcon: Icon(Icons.person, color: Colors.grey[600]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu usuario';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.passwordController,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu contraseña';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ButtonWidget(
            text: 'INICIAR SESIÓN',
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 200, 120, 20),
                Color.fromARGB(255, 200, 120, 20),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            onPressed: widget.isLoading ? () {} : widget.onLogin,
          ),
        ],
      ),
    );
  }
}
