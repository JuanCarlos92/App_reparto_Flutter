import 'package:app_reparto/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool isLoginForm;
  final VoidCallback onLogin;
  final VoidCallback toggleForm;
  final bool isLoading;

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
          TextFormField(
            controller: widget.usernameController,
            decoration: InputDecoration(
              labelText: 'Usuario',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
              fillColor:
                  // ignore: deprecated_member_use
                  Colors.white.withOpacity(0.2),
              // Ajusta la opacidad aquí
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
          TextFormField(
            controller: widget.passwordController,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
              fillColor:
                  // ignore: deprecated_member_use
                  Colors.white.withOpacity(0.2),
              // Ajusta la opacidad aquí
              filled: true,
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
            icon: Icons.login,
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
