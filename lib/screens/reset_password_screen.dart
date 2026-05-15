import 'package:flutter/material.dart';
import 'package:aimhigher_app/services/auth_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _tokenController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;

  bool _isStrongPassword(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$').hasMatch(password);
  }

  void _handleReset() async {
    if (_tokenController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    }

    if (!_isStrongPassword(_passwordController.text)) {
      _showSnackBar('Password is too weak');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar('Passwords do not match');
      return;
    }

    setState(() => _isLoading = true);
    final result = await _authService.resetPassword(_tokenController.text, _passwordController.text);
    if (mounted) setState(() => _isLoading = false);

    if (result['success'] == true) {
      _showSnackBar('Password reset successful! Please login.');
      if (mounted) {
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    } else {
      _showSnackBar(result['message'] ?? 'Error resetting password');
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1A237E), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Reset Password',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF1A237E), letterSpacing: -1),
            ),
            const SizedBox(height: 12),
            Text(
              'Enter the token sent to ${widget.email} and choose a new strong password.',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.5),
            ),
            const SizedBox(height: 40),
            _buildTextField(controller: _tokenController, hint: 'Reset Token', icon: Icons.vpn_key_outlined),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _passwordController,
              hint: 'New Password',
              icon: Icons.lock_outline,
              isPassword: true,
              obscureText: _obscurePassword,
              onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _confirmPasswordController,
              hint: 'Confirm Password',
              icon: Icons.lock_outline,
              isPassword: true,
              obscureText: _obscurePassword,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleReset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Reset Password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey, size: 20),
        suffixIcon: isPassword && onToggleVisibility != null
            ? IconButton(
                icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey, size: 20),
                onPressed: onToggleVisibility,
              )
            : null,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF3F3F3),
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide.none),
      ),
    );
  }
}
