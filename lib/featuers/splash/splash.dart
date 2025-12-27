import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tourist_guide/featuers/auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _waveController;
  late AnimationController _particlesController;
  late AnimationController _fadeController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotationAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _waveAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
    _startTimer();
  }

  void _initializeAnimations() {
    // Logo animations
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoRotationAnimation = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: const Interval(0.0, 0.5)),
    );

    // Text animations
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
          CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
        );

    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    // Wave animation
    _waveController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _waveAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_waveController);

    // Particles animation
    _particlesController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    // Fade out animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() {
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _textController.forward();
    });
  }

  void _startTimer() {
    Timer(const Duration(milliseconds: 2500), () async {
      await _fadeController.forward();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginScreenLight(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _waveController.dispose();
    _particlesController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          children: [
            // Animated gradient background
            _buildAnimatedGradient(),

            // Animated waves
            _buildAnimatedWaves(),

            // Floating particles
            _buildFloatingParticles(),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated logo
                  _buildAnimatedLogo(),

                  const SizedBox(height: 40),

                  // Animated text
                  _buildAnimatedText(),

                  const SizedBox(height: 20),

                  // Animated subtitle
                  _buildAnimatedSubtitle(),

                  const SizedBox(height: 60),

                  // Loading indicator
                  _buildLoadingIndicator(),
                ],
              ),
            ),

            // Decorative circles
            _buildDecorativeCircles(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedGradient() {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                  const Color(0xFF0098DB),
                  const Color(0xFF00BCD4),
                  (_waveAnimation.value / (2 * math.pi)).abs(),
                )!,
                Color.lerp(
                  const Color(0xFF00BCD4),
                  const Color(0xFF0098DB),
                  (_waveAnimation.value / (2 * math.pi)).abs(),
                )!,
                const Color(0xFF006BA6),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedWaves() {
    return AnimatedBuilder(
      animation: _waveAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(_waveAnimation.value),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildFloatingParticles() {
    return AnimatedBuilder(
      animation: _particlesController,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlesPainter(_particlesController.value),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _logoRotationAnimation.value,
          child: Transform.scale(
            scale: _logoScaleAnimation.value,
            child: Opacity(
              opacity: _logoOpacityAnimation.value,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/tourist.png',
                  width: 120,
                  height: 120,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedText() {
    return SlideTransition(
      position: _textSlideAnimation,
      child: FadeTransition(
        opacity: _textOpacityAnimation,
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Color(0xFFE3F2FD), Colors.white],
          ).createShader(bounds),
          child: const Text(
            'دليلك السياحي',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2.0,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSubtitle() {
    return FadeTransition(
      opacity: _textOpacityAnimation,
      child: const Text(
        'Your Tourist Guide',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          color: Colors.white,
          letterSpacing: 3.0,
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return FadeTransition(
      opacity: _textOpacityAnimation,
      child: SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.white.withOpacity(0.8),
          ),
          strokeWidth: 3,
        ),
      ),
    );
  }

  Widget _buildDecorativeCircles() {
    return Stack(
      children: [
        Positioned(
          top: -50,
          right: -50,
          child: _buildCircle(150, Colors.white.withOpacity(0.1)),
        ),
        Positioned(
          top: 100,
          left: -30,
          child: _buildCircle(80, Colors.white.withOpacity(0.08)),
        ),
        Positioned(
          bottom: -80,
          left: -40,
          child: _buildCircle(200, Colors.white.withOpacity(0.12)),
        ),
        Positioned(
          bottom: 100,
          right: -50,
          child: _buildCircle(120, Colors.white.withOpacity(0.09)),
        ),
      ],
    );
  }

  Widget _buildCircle(double size, Color color) {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (math.sin(_waveAnimation.value) * 0.1),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
        );
      },
    );
  }
}

// Wave Painter
class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.7);

    for (double i = 0; i < size.width; i++) {
      path.lineTo(
        i,
        size.height * 0.7 +
            math.sin((i / size.width * 2 * math.pi) + animationValue) * 20,
      );
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Second wave
    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.75);

    for (double i = 0; i < size.width; i++) {
      path2.lineTo(
        i,
        size.height * 0.75 +
            math.sin((i / size.width * 2 * math.pi) - animationValue) * 15,
      );
    }

    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;
}

// Particles Painter
class ParticlesPainter extends CustomPainter {
  final double animationValue;

  ParticlesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final random = math.Random(42);

    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y =
          (random.nextDouble() * size.height + animationValue * size.height) %
          size.height;
      final radius = random.nextDouble() * 2 + 1;

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint..color = Colors.white.withOpacity(random.nextDouble() * 0.5),
      );
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) => true;
}
