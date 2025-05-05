import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  static const green700 = Color(0xFF047857);
  static const gray200 = Color(0xFFE5E7EB);
  static const gray300 = Color(0xFFD1D5DB);
  static const white = Colors.white;

  @override
  void initState() {
    super.initState();
    _nameController.text = user?.displayName ?? '';
    _emailController.text = user?.email ?? '';
  }

  Future<void> _updateName() async {
    try {
      await user?.updateDisplayName(_nameController.text);
      await user?.reload();
      setState(() {
        _nameController.text = user?.displayName ?? '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update name: $e')));
    }
  }

  Future<void> _updateEmail() async {
    try {
      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: await _askPassword(),
      );

      await user!.reauthenticateWithCredential(credential);

      await user!.verifyBeforeUpdateEmail(_emailController.text);
      await user!.reload();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Verification email sent. Please check your inbox to confirm the new email.',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update email: $e')));
    }
  }

  Future<void> _updatePassword() async {
    try {
      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: await _askPassword(),
      );

      await user!.reauthenticateWithCredential(credential);

      await user!.updatePassword(_passwordController.text);
      await user!.reload();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully')),
      );
      _passwordController.clear();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update password: $e')));
    }
  }

  Future<String> _askPassword() async {
    String password = '';
    await showDialog(
      context: context,
      builder: (context) {
        final _passwordDialogController = TextEditingController();
        return AlertDialog(
          title: const Text('Re-authenticate'),
          content: TextField(
            controller: _passwordDialogController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Enter your current password',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                password = _passwordDialogController.text;
                Navigator.of(context).pop();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
    return password;
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: gray200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: gray300),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: green700,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Save',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Account Settings',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(label: 'Name', controller: _nameController),
            _buildButton(label: 'Save Name', onPressed: _updateName),
            const SizedBox(height: 20),
            _buildTextField(label: 'Email', controller: _emailController),
            _buildButton(label: 'Save Email', onPressed: _updateEmail),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'New Password',
              controller: _passwordController,
              obscureText: true,
            ),
            _buildButton(label: 'Save Password', onPressed: _updatePassword),
          ],
        ),
      ),
    );
  }
}
