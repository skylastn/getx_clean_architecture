import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../login/login_page.dart';
import 'register_logic.dart';

class RegisterPage extends StatelessWidget {
  static const String routeName = '/register';
  RegisterPage({super.key});
  final logic = Get.find<RegisterLogic>();

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF048CC4);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Join Billiard Membership community',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(logic.nameController, 'Full Name', Icons.person_outline),
                      const SizedBox(height: 14),
                      _buildTextField(logic.emailController, 'Email Address', Icons.email_outlined),
                      const SizedBox(height: 14),
                      _buildTextField(
                        logic.phoneNumberController,
                        'Phone Number (WhatsApp)',
                        Icons.phone_outlined,
                      ),
                      const SizedBox(height: 14),
                      _buildTextField(logic.subCabangController, 'Sub Cabang Code', Icons.store_outlined),
                      const SizedBox(height: 14),
                      _buildTextField(
                        logic.passwordController,
                        'Password',
                        Icons.lock_outline,
                        isPassword: true,
                      ),
                      const SizedBox(height: 14),
                      _buildTextField(
                        logic.confirmPasswordController,
                        'Confirm Password',
                        Icons.lock_reset_outlined,
                        isPassword: true,
                      ),
                      const SizedBox(height: 24),
                      _buildRegisterButton(primaryBlue),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildSignInOption(primaryBlue),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 120,
          height: 120,
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14),
          decoration: InputDecoration(
            hintText: 'Enter your $label',
            hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
            prefixIcon: Icon(icon, size: 20, color: const Color(0xFF94A3B8)),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFF048CC4), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(Color primaryColor) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () => logic.register(),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSignInOption(Color primaryColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
        ),
        TextButton(
          onPressed: () => Get.toNamed(LoginPage.routeName),
          child: Text(
            'Sign in',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
