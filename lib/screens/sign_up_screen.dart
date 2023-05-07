import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:messagaty/widgets/primary_button_widget.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:messagaty/screens/screens.dart';

import '../helpers.dart';
import '../logger.dart';

class SignUpScreen extends StatefulWidget {
  static Route get route => MaterialPageRoute(
    builder: (context) => const SignUpScreen(),
  );
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final auth = firebase.FirebaseAuth.instance;
  final functions = FirebaseFunctions.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final _profilePicture = Helpers.randomPictureUrl();

  bool _loading = false;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      try {
        // Authenticate with Firebase
        final creds =
        await firebase.FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        final user = creds.user;
        if (mounted) {
          if (user == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User is empty')),
            );
            return;
          }
        }

        // Set Firebase display name and profile picture
        List<Future<void>> futures = [
          creds.user!.updateDisplayName(_nameController.text),
          creds.user!.updatePhotoURL(_profilePicture)
        ];

        await Future.wait(futures);

        // Create Stream user and get token using Firebase Functions
        final results = await functions
            .httpsCallable('ext-auth-chat-getStreamUserToken')
            .call();

        // Connect user to Stream and set user data
        if (!mounted) return;
        final client = StreamChatCore.of(context).client;
        final streamUser = User(
          id: creds.user!.uid,
          name: _nameController.text,
          image: _profilePicture,
          extraData: {
            'phone_number': _phoneNumberController.text,
          },
        );
        await client.connectUser(
          streamUser,
          results.data,
        );
        await client.updateUser(streamUser);

        if (!mounted) return;
        // Navigate to home screen
        await Navigator.of(context).pushReplacement(HomeScreen.route);
      } on firebase.FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Auth error')),
        );
      } catch (e, st) {
        logger.e('Sign up error', e, st);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred')),
        );
      }
      setState(() {
        _loading = false;
      });
    }
  }

  String? _nameInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    return null;
  }

  String? _emailInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Not a valid email';
    }
    return null;
  }

  String? _passwordInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    if (value.length <= 6) {
      return 'Password needs to be longer than 6 characters';
    }
    return null;
  }

  String? _phoneNumberInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    if (value.length <= 11) {
      return 'Phone Number needs to be longer than 11 characters';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messagaty'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: (_loading)
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 24),
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 26, fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nameController,
                    validator: _nameInputValidator,
                    decoration: const InputDecoration(hintText: 'name'),
                    keyboardType: TextInputType.name,
                    autofillHints: const [
                      AutofillHints.name,
                      AutofillHints.username
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration:
                    const InputDecoration(hintText: 'picture URL'),
                    keyboardType: TextInputType.url,
                    initialValue: Helpers.randomPictureUrl(),
                    enabled: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    validator: _emailInputValidator,
                    decoration: const InputDecoration(hintText: 'email'),
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordController,
                    validator: _passwordInputValidator,
                    decoration: const InputDecoration(
                      hintText: 'password',
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneNumberController,
                    validator: _phoneNumberInputValidator,
                    decoration: const InputDecoration(hintText: 'phone number'),
                    keyboardType: TextInputType.phone,
                    autofillHints: const [AutofillHints.telephoneNumber],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryButtonWidget(
                    onPressed: _signUp,
                    text: 'Sign up',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Sign in'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}