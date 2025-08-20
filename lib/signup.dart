import 'package:admintest/login.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final supabase = Supabase.instance.client;
final user = supabase.auth.currentUser!;


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  bool isLoading = false;

  void showMessage(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future signUp() async{
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final fname = fnameController.text.trim();
    final lname = lnameController.text.trim();
    if(email.isEmpty || password.isEmpty){
      showMessage('Please fill the required fields');
      return;
    }
    setState(() => isLoading = true);
    try {
      await Supabase.instance.client.auth.signUp(
        email: email,
        password: password
      );
      await Supabase.instance.client.from('users').insert({
          'id' : user.id,
          'fname': fname,
          'lname': lname,
          'role': "admin"
      });
      showMessage('Account has been created! proceed to sign in');
      Navigator.pop(context);
    } catch (e) {
      showMessage('SIgnup failed ${e.toString()}');
    }finally{
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign up for',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  // letterSpacing: 1.5,
                ),
              ),
              Image.asset('assets/images/logos/FullLogoBlackWide.png'),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      cont: fnameController,
                      label: 'Firstname',
                      icon: Icons.person,
                      obscure: false,
                    ),
                  ),
                  const SizedBox(width: 10), // Optional spacing
                  Expanded(
                    child: _buildTextField(
                      cont: lnameController,
                      label: 'lastname',
                      icon: Icons.person,
                      obscure: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildTextField(
                cont: emailController,
                label: 'Email',
                icon: Icons.email_outlined,
                obscure: false,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                cont: passwordController,
                label: 'Password',
                icon: Icons.lock_outline,
                obscure: true,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDB3939),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: (){
                    isLoading? null:signUp();
                  },
                  child: isLoading? const CircularProgressIndicator(): const Text(
                    'SIGN UP',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_)=> const LoginPage()
                  ));
                },
                child: const Text(
                  'already have an account? Login here',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required bool obscure,
    required TextEditingController cont
  }) {
    return TextField(
      obscureText: obscure,
      controller: cont ,
      style: const TextStyle(color: Colors.white),
      cursorColor: const Color(0xFFDB3939),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: const Color(0xFFDB3939)),
        filled: true,
        fillColor: const Color(0xFF2C3137),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFDB3939)),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}