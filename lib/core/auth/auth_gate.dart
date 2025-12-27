/*

AUTH GATE - This will continuously listen to the authentication state changes

------------------------------------------------------------------------------------------------------

unauthenticated -> login page
authenticated -> home page


*/

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tourist_guide/featuers/auth/login.dart';
import 'package:tourist_guide/featuers/home/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  final Widget authenticated;
  final Widget unauthenticated;

  const AuthGate({
    super.key,
    required this.authenticated,
    required this.unauthenticated,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final sessin = snapshot.hasData ? snapshot.data!.session : null;
        if (sessin == null) {
          return HomePage();
        } else {
          return LoginScreenLight();
        }
      },
    );
  }
}
