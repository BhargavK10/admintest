import 'package:admintest/signup.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  void showMessage(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future signIn() async{
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if(email.isEmpty || password.isEmpty){
      showMessage('Please fill the required fields');
      return;
    }
    setState(() => isLoading = true);
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password
      );
      final userId = supabase.auth.currentUser!.id;

      final userData = await supabase
        .from('users')
        .select('role')
        .eq('id', userId)
        .single();

      if (userData['role'] != 'admin') {
        // ❌ Not an admin, sign them out
        await supabase.auth.signOut();
      }

    } catch (e) {
      showMessage('Login failed ${e.toString()}');
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
                'Login to',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  // letterSpacing: 1.5,
                ),
              ),
              // Image.asset('assets/images/logos/FullLogoBlackWide.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Use phone number instead',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ]
              ),
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
                    isLoading? null:signIn();
                  },
                  child: isLoading? const CircularProgressIndicator(): const Text(
                    'LOGIN',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (_)=> const SignupPage()
                      ));
                    },
                    child: const Text(
                      'Signup here',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
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