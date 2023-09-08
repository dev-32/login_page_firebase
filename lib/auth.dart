import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  var _enteredEmail;
  var _enteredPassword;
  var _isLogin = false;
  final _formKey = GlobalKey<FormState>();
  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if(!isValid){
      return;
    }
    _formKey.currentState!.save();

    try{
      if(_isLogin){
        final userCredentials = await _firebase.signInWithEmailAndPassword(email:_enteredEmail, password: _enteredPassword);
      }
      else{
        final userCredentials = await _firebase.createUserWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
      }
    } on FirebaseAuthException catch (error){

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ??
              'Authentication Failed',)));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/user.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 12,
            ),
            Card(
              margin: const EdgeInsets.all(11),
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.orangeAccent),
                              )),
                            validator: (value) {
                              if (value == null || value
                                  .trim()
                                  .isEmpty || !value.contains('@')) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                          onSaved: (value){
                            _enteredEmail = value!;
                          },
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.orangeAccent),
                              )),
                          validator: (value){
                            if(value == null || value.trim().length < 5){
                              return 'Password must contains 5 characters';
                            }
                            return null;
                          },
                          onSaved: (value){
                            _enteredPassword = value!;
                          },
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(
                                      width: 3, color: Colors.orangeAccent),
                                ),
                              ),
                            ),
                            onPressed: _submit,
                            child: Text(_isLogin? 'Login' : 'Sign Up',
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            ),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin =!_isLogin;
                              });

                            }, child:Text(_isLogin ? 'Create an account'
                            : 'Already have an account',
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
