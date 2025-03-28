import 'dart:io';

import 'package:flutter/material.dart';

// Clase StatefulWidget que representa el formulario de login y registro
class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController domainController;
  final bool isLoginForm;
  final VoidCallback onLogin;
  final VoidCallback onRegister;
  final VoidCallback toggleForm;
  final bool isLoading;
  final bool isRegistering;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.domainController,
    required this.isLoginForm,
    required this.onLogin,
    required this.onRegister,
    required this.toggleForm,
    required this.isLoading,
    required this.isRegistering,
  });

  @override
  // Método que crea el estado del widget
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

// Clase que maneja el estado del widget LoginForm
class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      // Asigna la clave global al formulario
      key: widget.formKey,
      child: Column(
        // Ajusta el tamaño principal de la columna al mínimo necesario
        mainAxisSize: MainAxisSize.min,
        children: [
          // Título del formulario que cambia según el estado (login o registro)
          Text(
            widget.isLoginForm ? 'Iniciar Sesión' : 'Registrarse',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          // Campo de texto para el nombre de usuario
          TextFormField(
            controller: widget.usernameController,
            decoration: const InputDecoration(
              labelText: 'Usuario',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            // Validación para asegurar que el campo no esté vacío
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu usuario';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          // Campo de texto para la contraseña
          TextFormField(
            controller: widget.passwordController,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
            ),
            // Oculta el texto ingresado
            obscureText: true,
            // Validación para asegurar que el campo no esté vacío
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu contraseña';
              }
              return null;
            },
          ),
          // Si el formulario no es de login, muestra el campo de dominio
          if (!widget.isLoginForm) ...[
            const SizedBox(height: 16),
            TextFormField(
              controller: widget.domainController,
              decoration: const InputDecoration(
                labelText: 'Dominio',
                prefixIcon: Icon(Icons.public),
                border: OutlineInputBorder(),
              ),
              // Validación para asegurar que el campo no esté vacío
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu dominio';
                }
                return null;
              },
            ),
          ],
          const SizedBox(height: 24),
          // Botón para enviar el formulario
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              // Llama a la función correspondiente según el estado del formulario
              onPressed: widget.isLoginForm
                  ? (widget.isLoading ? null : widget.onLogin)
                  : (widget.isRegistering ? null : widget.onRegister),
              style: ElevatedButton.styleFrom(
                // Estilo del botón que cambia según el estado del formulario
                backgroundColor:
                    widget.isLoginForm ? Colors.green : Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // Muestra un indicador de carga o el texto del botón
              child: widget.isLoginForm
                  ? (widget.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Iniciar Sesión',
                          style: TextStyle(fontSize: 16)))
                  : (widget.isRegistering
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Registrarse',
                          style: TextStyle(fontSize: 16))),
            ),
          ),
          const SizedBox(height: 16),
          // Botón para cambiar entre el formulario de login y registro
          TextButton(
            onPressed: widget.toggleForm,
            child: Text(
              widget.isLoginForm
                  ? '¿No tienes una cuenta? Regístrate'
                  : '¿Ya tienes una cuenta? Inicia sesión',
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextButton(
              onPressed: () {
                exit(0);
              },
              child: const Text(
                'Salir de la aplicación',
                style: TextStyle(fontSize: 16, color: Colors.red),
              )),
        ],
      ),
    );
  }
}
