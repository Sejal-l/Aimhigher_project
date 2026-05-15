import 'package:flutter/material.dart';
import 'package:aimhigher_app/services/auth_service.dart';
import 'package:intl/intl.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dobController = TextEditingController();
  
  final _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _calculatedAge = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2009),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
        final now = DateTime.now();
        int age = now.year - picked.year;
        if (now.month < picked.month || (now.month == picked.month && now.day < picked.day)) { age--; }
        _calculatedAge = age.toString();
      });
    }
  }

  void _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final dob = _dobController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty || dob.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    }

    if (password != confirmPassword) {
      _showSnackBar('Passwords do not match');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await _authService.register(name, email, password, dob, _calculatedAge);
      if (result['success'] == true) {
        if (mounted) {
          _showSnackBar('Account created! Welcome to AimHigher.');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen(email: email, password: password)));
        }
      } else {
        _showSnackBar(result['message'] ?? 'Registration failed');
      }
    } catch (e) {
      _showSnackBar('Connection error. Is the server running?');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message), 
      backgroundColor: const Color(0xFF1A237E), 
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text('Create Account', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
              const SizedBox(height: 10),
              const Text('Join our community of future leaders', style: TextStyle(color: Colors.grey, fontSize: 16)),
              const SizedBox(height: 40),
              _buildInput(_nameController, 'Full Name', Icons.person_outline),
              const SizedBox(height: 16),
              _buildInput(_emailController, 'Email Address', Icons.email_outlined, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(child: _buildInput(_dobController, 'Date of Birth', Icons.calendar_today_outlined)),
              ),
              const SizedBox(height: 16),
              _buildInput(_passwordController, 'Password', Icons.lock_outline, 
                isPass: true, 
                obscure: _obscurePassword, 
                onToggle: () => setState(() => _obscurePassword = !_obscurePassword)
              ),
              const SizedBox(height: 16),
              _buildInput(_confirmPasswordController, 'Confirm Password', Icons.lock_outline, 
                isPass: true, 
                obscure: _obscureConfirmPassword, 
                onToggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword)
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity, height: 60,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                  ),
                  child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white) 
                    : const Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(text: 'Login', style: TextStyle(color: Color(0xFF1A237E), fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String hint, IconData icon, {bool isPass = false, bool obscure = true, VoidCallback? onToggle, TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      obscureText: isPass ? obscure : false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF1A237E)),
        suffixIcon: isPass ? IconButton(icon: Icon(obscure ? Icons.visibility_off : Icons.visibility), onPressed: onToggle) : null,
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF5F7FA),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      ),
    );
  }
}
