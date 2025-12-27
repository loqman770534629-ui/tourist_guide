import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourist_guide/core/auth/auth_service.dart';
import 'package:tourist_guide/featuers/auth/regester_page.dart';
import 'package:tourist_guide/featuers/home/pages/main_page.dart';

class LoginScreenLight extends StatefulWidget {
  const LoginScreenLight({super.key});

  @override
  State<LoginScreenLight> createState() => _LoginScreenLightState();
}

class _LoginScreenLightState extends State<LoginScreenLight>
    with TickerProviderStateMixin {
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar(
        'الرجاء إدخال البريد الإلكتروني وكلمة المرور',
        isError: true,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('فشل تسجيل الدخول: ${e.toString()}', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      body: Stack(
        children: [
          // Animated Gradient Background
          _buildGradientBackground(isDark, primaryColor),

          // Floating Circles Animation
          _buildFloatingCircles(size),

          // Main Content
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    constraints: BoxConstraints(minHeight: size.height - 50),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),

                        // Logo with Animation
                        _buildAnimatedLogo(),

                        const SizedBox(height: 40),

                        // Glass Card with Login Form
                        _buildGlassCard(context, theme, primaryColor),

                        const SizedBox(height: 24),

                        // Sign Up Link
                        _buildSignUpLink(theme, primaryColor),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Gradient Background
  Widget _buildGradientBackground(bool isDark, Color primaryColor) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF0A1929),
                  const Color(0xFF1A2332),
                  primaryColor.withOpacity(0.2),
                ]
              : [
                  primaryColor.withOpacity(0.1),
                  Colors.white,
                  primaryColor.withOpacity(0.05),
                ],
        ),
      ),
    );
  }

  // Floating Circles
  Widget _buildFloatingCircles(Size size) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,
          child: _buildCircle(250, Colors.blue.withOpacity(0.1)),
        ),
        Positioned(
          bottom: -50,
          left: -50,
          child: _buildCircle(200, Colors.purple.withOpacity(0.1)),
        ),
        Positioned(
          top: size.height * 0.3,
          left: -30,
          child: _buildCircle(150, Colors.cyan.withOpacity(0.1)),
        ),
      ],
    );
  }

  Widget _buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  // Animated Logo
  Widget _buildAnimatedLogo() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1500),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Image(
              image: AssetImage('assets/tourist.png'),
              height: 100,
            ),
          ),
        );
      },
    );
  }

  // Glass Card
  Widget _buildGlassCard(
    BuildContext context,
    ThemeData theme,
    Color primaryColor,
  ) {
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.white.withOpacity(0.7),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                // Welcome Text
                Text(
                  'مرحباً بعودتك!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [primaryColor, primaryColor.withOpacity(0.7)],
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'استكشف أجمل الأماكن السياحية',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 32),

                // Email Field
                _buildModernTextField(
                  controller: _emailController,
                  label: 'البريد الإلكتروني',
                  icon: Icons.email_rounded,
                  theme: theme,
                  primaryColor: primaryColor,
                ),
                const SizedBox(height: 20),

                // Password Field
                _buildModernTextField(
                  controller: _passwordController,
                  label: 'كلمة المرور',
                  icon: Icons.lock_rounded,
                  isPassword: true,
                  theme: theme,
                  primaryColor: primaryColor,
                ),

                const SizedBox(height: 12),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Login Button
                _buildGradientButton(
                  text: 'تسجيل الدخول',
                  onPressed: _login,
                  primaryColor: primaryColor,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 20),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: theme.dividerColor)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'أو',
                        style: TextStyle(
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: theme.dividerColor)),
                  ],
                ),

                const SizedBox(height: 20),

                // Google Sign In
                _buildSocialButton(
                  text: 'Google المتابعة باستخدام',
                  icon: FontAwesomeIcons.google,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const MainScreen()),
                    );
                  },
                  theme: theme,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Modern Text Field
  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required ThemeData theme,
    required Color primaryColor,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.cardColor.withOpacity(0.5),
        border: Border.all(color: primaryColor.withOpacity(0.2), width: 1),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        textDirection: TextDirection.rtl,
        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
          ),
          prefixIcon: Icon(icon, color: primaryColor),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    setState(() => _isPasswordVisible = !_isPasswordVisible);
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  // Gradient Button
  Widget _buildGradientButton({
    required String text,
    required VoidCallback onPressed,
    required Color primaryColor,
    bool isLoading = false,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withOpacity(0.7)],
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  // Social Button
  Widget _buildSocialButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    required ThemeData theme,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.cardColor,
        border: Border.all(color: theme.dividerColor, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Google Icon with original colors
              _buildGoogleIcon(),
              const SizedBox(width: 12),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                  children: [
                    TextSpan(
                      text: 'المتابعة باستخدام ',
                      style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                    ),
                    const TextSpan(
                      text: 'Google',
                      style: TextStyle(
                        color: Color(0xFFDB4437), // Google Red
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Google Icon with original colors
  Widget _buildGoogleIcon() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
      child: CustomPaint(painter: GoogleIconPainter()),
    );
  }

  // Sign Up Link
  Widget _buildSignUpLink(ThemeData theme, Color primaryColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ليس لديك حساب؟',
          style: TextStyle(
            color: theme.textTheme.bodyMedium?.color,
            fontSize: 16,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const RegesterPage()));
          },
          child: Text(
            'إنشاء حساب جديد',
            style: TextStyle(
              color: primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// Google Icon Painter - Creates the colorful Google logo
class GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    // Google Blue (top-right)
    final Paint bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    // Google Red (top-left)
    final Paint redPaint = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.fill;

    // Google Yellow (bottom-left)
    final Paint yellowPaint = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.fill;

    // Google Green (bottom-right)
    final Paint greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.fill;

    // Draw simplified Google "G" logo
    final double centerX = width / 2;
    final double centerY = height / 2;
    final double radius = width / 2.5;

    // Blue arc (top-right, 45° to 135°)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      -0.75, // Start angle (radians)
      1.5, // Sweep angle
      true,
      bluePaint,
    );

    // Red arc (top-left, 135° to 225°)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      0.75,
      1.5,
      true,
      redPaint,
    );

    // Yellow arc (bottom-left, 225° to 315°)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      2.25,
      1.5,
      true,
      yellowPaint,
    );

    // Green arc (bottom-right, 315° to 45°)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      3.75,
      1.5,
      true,
      greenPaint,
    );

    // Draw white center circle
    final Paint whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(centerX, centerY), radius * 0.45, whitePaint);

    // Draw Google "G" letter shape (simplified)
    final Paint letterPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    // Right vertical bar of "G"
    canvas.drawRect(
      Rect.fromLTWH(
        centerX + radius * 0.15,
        centerY - radius * 0.25,
        radius * 0.35,
        radius * 0.5,
      ),
      letterPaint,
    );

    // Horizontal bar at middle
    canvas.drawRect(
      Rect.fromLTWH(
        centerX,
        centerY - radius * 0.1,
        radius * 0.5,
        radius * 0.2,
      ),
      letterPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
