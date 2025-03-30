import 'package:app_reparto/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:app_reparto/services/auth_service.dart';
import 'login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _domainController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  bool _isRegistering = false;
  bool _isLoginForm = true;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.login(
        _usernameController.text,
        _passwordController.text,
      );

      if (mounted) {
        FocusScope.of(context).unfocus();
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } catch (e) {
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

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isRegistering = true;
    });

    try {
      await _authService.register(
        _usernameController.text,
        _passwordController.text,
        _domainController.text,
      );

      if (mounted) {
        FocusScope.of(context).unfocus();
        setState(() {
          _isLoginForm = true;
        });
        _usernameController.clear();
        _passwordController.clear();
        _domainController.clear();
        DialogUtils.showInfoDialog(context, 'Registro exitoso. Por favor, inicia sesión.');
      }
    } catch (e) {
      if (mounted) {
        DialogUtils.showErrorDialog(context, e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isRegistering = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
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
    _usernameController.dispose();
    _passwordController.dispose();
    _domainController.dispose();
    super.dispose();
  }
}
