import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  // Sign in method
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  // Sign up method

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );
    return response;
  }

  // Sign out method
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // Get user email
  String? getCurrentUser() {
    final Session = supabase.auth.currentSession!;
    final User? user = Session.user;
    return user?.email;
  }
}
