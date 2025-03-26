import 'package:flutter/material.dart';
import 'package:app_geolocalizacion/services/auth_service.dart';
import 'login_form.dart';

// Clase StatefulWidget que representa la pantalla de login
class LoginScreen extends StatefulWidget {
  // Constructor que permite pasar una clave opcional
  const LoginScreen({super.key});

  @override
  // Método que crea el estado del widget
  State<LoginScreen> createState() => _LoginScreenState();
}

// Clase que maneja el estado del widget LoginScreen
class _LoginScreenState extends State<LoginScreen> {
  // Clave global para manejar el estado del formulario
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto de usuario, contraseña y dominio
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _domainController = TextEditingController();

  // Instancia del servicio de autenticación
  final _authService = AuthService();

  // Estados de carga para los botones de login y registro
  bool _isLoading = false;
  bool _isRegistering = false;

  // Estado que indica si el formulario actual es de login o registro
  bool _isLoginForm = true;

  // Método para iniciar sesión
  Future<void> _login() async {
    // Valida el formulario antes de continuar
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      // Activa el indicador de carga
      _isLoading = true;
    });

    try {
      // Llama al servicio de autenticación para iniciar sesión
      await _authService.login(
        _usernameController.text,
        _passwordController.text,
      );

      if (mounted) {
        // Si la pantalla sigue en el árbol de widgets, redirige a la pantalla de inicio
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } catch (e) {
      if (mounted) {
        // Muestra un mensaje de error en caso de fallo en la autenticación
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          // Desactiva el indicador de carga
          _isLoading = false;
        });
      }
    }
  }

  // Método para registrarse
  Future<void> _register() async {
    // Valida el formulario antes de continuar
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      // Activa el indicador de carga para el registro
      _isRegistering = true;
    });

    try {
      // Llama al servicio de autenticación para registrar un nuevo usuario
      await _authService.register(
        _usernameController.text,
        _passwordController.text,
        _domainController.text,
      );

      if (mounted) {
        // Si el registro es exitoso, redirige a la pantalla de inicio
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } catch (e) {
      if (mounted) {
        // Muestra un mensaje de error en caso de fallo en el registro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          // Desactiva el indicador de carga
          _isRegistering = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // La estructura principal de la pantalla, que contiene un contenedor y una decoración de fondo
      body: Container(
        // Aplica un fondo con un degradado de verde a negro
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // Centra el contenido dentro del contenedor
        child: Center(
          child: SingleChildScrollView(
            // Permite que el contenido sea desplazable si es necesario
            padding: const EdgeInsets.all(24.0),
            // Define una tarjeta con sombra y bordes redondeados
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              // Añade un relleno alrededor del contenido de la tarjeta
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                // Usa el componente LoginForm para mostrar el formulario de login o registro
                child: LoginForm(
                  formKey: _formKey,
                  usernameController: _usernameController,
                  passwordController: _passwordController,
                  domainController: _domainController,
                  isLoginForm: _isLoginForm,
                  onLogin: _login,
                  onRegister: _register,
                  toggleForm: () {
                    setState(() {
                      // Alterna entre el formulario de login y registro
                      _isLoginForm = !_isLoginForm;
                    });
                  },
                  isLoading: _isLoading,
                  isRegistering: _isRegistering,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Libera los recursos de los controladores de texto
    _usernameController.dispose();
    _passwordController.dispose();
    _domainController.dispose();
    super.dispose();
  }
}
