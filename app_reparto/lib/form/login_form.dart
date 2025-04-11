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
    // Estructura del formulario
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Título del formulario con estilo personalizado
          Text(
            'Iniciar Sesión',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Roboto',
              shadows: [
                Shadow(
                  blurRadius: 8,
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Campo de texto para el usuario con validación
          TextFormField(
            controller: widget.usernameController,
            decoration: InputDecoration(
              labelText: 'Usuario',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
              // ignore: deprecated_member_use
              fillColor: Colors.white.withOpacity(0.2),
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu usuario';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Campo de texto para la contraseña con validación
          TextFormField(
            controller: widget.passwordController,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
              // ignore: deprecated_member_use
              fillColor: Colors.white.withOpacity(0.2),
              filled: true,
            ),
            // Oculta el texto de la contraseña
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu contraseña';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Botón personalizado para iniciar sesión
          ButtonWidget(
            text: 'INICIAR SESIÓN',
            icon: Icons.login,
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 200, 120, 20),
                Color.fromARGB(255, 200, 120, 20),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),

            // Deshabilita el botón mientras está cargando
            onPressed: widget.isLoading ? () {} : widget.onLogin,
          ),
        ],
      ),
    );
  }
}
