import 'package:flutter/material.dart';

import 'package:life_easer/core/auth.dart';
import 'package:life_easer/core/validators.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  TextEditingController emailController =
      TextEditingController(text: "yogeshdevaggarwal@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "12345678");

  void handleLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields"),
        ),
      );
      return;
    }

    if (EmailValidator.isValid(emailController.text) == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email"),
        ),
      );
      return;
    }

    if (PasswordValidator.isValid(passwordController.text) == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Password must be of least minimum 8 characters, maximum 64 characters, 1 uppercase, 1 lowercase"),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });
    try {
      await signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildHero() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            "assets/logo.png",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          "Life Easer",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Your personal life assistant",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: "Email",
            hintText: "Enter your email",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          obscureText: true,
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    if (isLoading) {
      return SizedBox(
        width: 28,
        height: 28,
        child: const CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
      onPressed: handleLogin,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.logIn),
          SizedBox(width: 12),
          Text(
            "Login",
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 28),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHero(),
                  const SizedBox(height: 48),
                  _buildForm(),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _buildActionButton(),
                  const Spacer(),
                  _buildActionButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
