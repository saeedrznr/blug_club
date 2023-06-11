import 'dart:core';

import 'package:blug_club/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  static const int loginTab = 0;
  static const int signUpTab = 1;
  int selectedTabIndex = loginTab;
  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    final tabTextStyle = TextStyle(
        color: themedata.colorScheme.onPrimary,
        fontSize: 18,
        fontWeight: FontWeight.bold);
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 32, top: 32),
            child: Center(child: Assets.img.icons.logo.svg(width: 120)),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: themedata.colorScheme.primary,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32))),
            child: Column(children: [
              Container(
                height: 60,
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        setState(() {
                          selectedTabIndex = loginTab;
                        });
                      },
                      child: Text(
                        'login'.toUpperCase(),
                        style: tabTextStyle.apply(
                          color: selectedTabIndex==loginTab?Colors.white:Colors.white54
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        setState(() {
                          selectedTabIndex = signUpTab;
                        });
                      },
                      child: Text(
                        'sign up'.toUpperCase(),
                        style: tabTextStyle.apply(
                          color: selectedTabIndex==signUpTab?Colors.white:Colors.white54
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: 
                Container(
                  decoration: BoxDecoration(
                      color: themedata.colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 48, 32, 32),
                      child: selectedTabIndex==loginTab?_Login(themedata: themedata):_SignUp(themedata: themedata),
                    ),
                  ),
                ),
              )
            ]),
          ))
        ]),
      ),
    );
  }
}

class _SignUp extends StatelessWidget {
  const _SignUp({
    super.key,
    required this.themedata,
  });

  final ThemeData themedata;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome to blog club',
            style: themedata.textTheme.headlineMedium),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Please enter your information',
          style: themedata.textTheme.titleMedium!
              .apply(fontSizeFactor: 0.8),
        ),
        const SizedBox(
          height: 16,
        ),
        const TextField(
          decoration: InputDecoration(label: Text('Full name')),
        ),
        const SizedBox(
          height: 16,
        ),
        const TextField(
          decoration: InputDecoration(label: Text('Username')),
        ),
        const _PasswordTextField(),
        const SizedBox(height: 24,),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 60)),
                  backgroundColor: MaterialStateProperty.all(themedata.colorScheme.primary),
                  foregroundColor: MaterialStateProperty.all(themedata.colorScheme.surface),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12)))),
          child: Text('Sign up'.toUpperCase()),
        ),
        const SizedBox(height: 16,),
        const Center(
          child: Text('OR SIGN UP WITH',style: TextStyle(letterSpacing: 2),),
        ),
        const SizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.img.icons.google
                .image(width: 36, height: 36),
            const SizedBox(
              width: 24,
            ),
            Assets.img.icons.facebook
                .image(width: 36, height: 36),
            const SizedBox(
              width: 24,
            ),
            Assets.img.icons.twitter
                .image(width: 36, height: 36)
          ],
        )
      ],
    );
  }
}

class _Login extends StatelessWidget {
  const _Login({
    super.key,
    required this.themedata,
  });

  final ThemeData themedata;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome back',
            style: themedata.textTheme.headlineMedium),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Sign in with your account',
          style: themedata.textTheme.titleMedium!
              .apply(fontSizeFactor: 0.8),
        ),
        const SizedBox(
          height: 16,
        ),
        const TextField(
          decoration: InputDecoration(label: Text('Username')),
        ),
        const _PasswordTextField(),
        const SizedBox(height: 24,),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 60)),
                  backgroundColor: MaterialStateProperty.all(themedata.colorScheme.primary),
                  foregroundColor: MaterialStateProperty.all(themedata.colorScheme.surface),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12)))),
          child: Text('Login'.toUpperCase()),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Forgot your password?'),
            const SizedBox(width: 8,),
            TextButton(
                onPressed: () {}, child: const Text('Reset here'))
          ],
        ),
        const SizedBox(height: 16,),
        const Center(
          child: Text('OR SIGN IN WITH',style: TextStyle(letterSpacing: 2),),
        ),
        const SizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.img.icons.google
                .image(width: 36, height: 36),
            const SizedBox(
              width: 24,
            ),
            Assets.img.icons.facebook
                .image(width: 36, height: 36),
            const SizedBox(
              width: 24,
            ),
            Assets.img.icons.twitter
                .image(width: 36, height: 36)
          ],
        )
      ],
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    super.key,
  });

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
   bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(label: const Text('Password'),
      suffix: InkWell(onTap: (){
        setState(() {
          obscureText = !obscureText;
        });
      },child:  Text(obscureText? 'Show':'Hide',
      style: TextStyle(fontSize: 14,color: Theme.of(context).colorScheme.primary),),)),
    );
  }
}
