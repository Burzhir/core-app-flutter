import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../data/isms_data.dart';

/// Deterministic "random" from a string seed.
class _Seeded {
  final List<double> _vals;
  int _idx = 0;

  _Seeded(String seed)
      : _vals = List.generate(
          64,
          (i) => ((seed.codeUnitAt(i % seed.length) * 1234567 + i * 89101) % 10000) / 10000.0,
        );

  double next() => _vals[_idx++ % _vals.length];
  double range(double min, double max) => min + next() * (max - min);
  int nextInt(int max) => (next() * max).floor();
}

// ── Public widget ──────────────────────────────────────────────────────────
class IsmArtWidget extends StatefulWidget {
  final IsmMeta ism;
  final List<Color> colors;
  final double height;
  final double? width;
  final bool animated;

  const IsmArtWidget({
    super.key,
    required this.ism,
    required this.colors,
    this.height = 280,
    this.width,
    this.animated = true,
  });

  @override
  State<IsmArtWidget> createState() => _IsmArtWidgetState();
}

class _IsmArtWidgetState extends State<IsmArtWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 12));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.linear);
    if (widget.animated) _ctrl.repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _anim,
        builder: (_, __) => CustomPaint(
          painter: _ArtPainter(
            visualStyle: widget.ism.visualStyle,
            seed: widget.ism.id,
            colors: widget.colors,
            t: _anim.value,
          ),
        ),
      ),
    );
  }
}

// ── Master painter ─────────────────────────────────────────────────────────
class _ArtPainter extends CustomPainter {
  final ArtStyle visualStyle;
  final String seed;
  final List<Color> colors;
  final double t;

  _ArtPainter({
    required this.visualStyle,
    required this.seed,
    required this.colors,
    required this.t,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFF080612),
    );

    switch (visualStyle) {
      case ArtStyle.discipline: _paintDiscipline(canvas, size); break;
      case ArtStyle.creativity: _paintCreativity(canvas, size); break;
      case ArtStyle.mindfulness: _paintMindfulness(canvas, size); break;
      case ArtStyle.reason: _paintReason(canvas, size); break;
      case ArtStyle.existential: _paintExistential(canvas, size); break;
      case ArtStyle.relations: _paintRelations(canvas, size); break;
    }

    _paintVignette(canvas, size);
  }

  // ── DISCIPLINE ───────────────────────────────────────────────────────────
  void _paintDiscipline(Canvas canvas, Size size) {
    final rng = _Seeded(seed);
    final c1 = colors[0];
    final c2 = colors[1];
    final cx = size.width / 2;
    final cy = size.height / 2;

    final bgPaint = Paint()
      ..shader = RadialGradient(
        colors: [c1.withValues(alpha: 0.25), Colors.transparent],
      ).createShader(Rect.fromCircle(center: Offset(cx * 0.3, cy * 0.4), radius: size.width * 0.6));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final pillars = 5 + rng.nextInt(3);
    for (int i = 0; i < pillars; i++) {
      final x = size.width * (i + 1) / (pillars + 1);
      final anim = math.sin(t * 2 * math.pi + i * 0.8) * 0.5 + 0.5;
      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            c1.withValues(alpha: 0.0),
            c1.withValues(alpha: 0.18 + anim * 0.12),
            c2.withValues(alpha: 0.22 + anim * 0.1),
            c1.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ).createShader(Rect.fromLTWH(x - 1, 0, 2, size.height))
        ..strokeWidth = 1.2 + rng.range(0, 1.5)
        ..style = PaintingStyle.stroke;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    final lines = 8 + rng.nextInt(6);
    for (int i = 0; i < lines; i++) {
      final y = size.height * (i + 1) / (lines + 1);
      final anim = math.sin(t * 2 * math.pi * 0.7 + i * 1.1) * 0.5 + 0.5;
      final paint = Paint()
        ..color = c2.withValues(alpha: 0.06 + anim * 0.06)
        ..strokeWidth = 0.5;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final beamAngle = rng.range(-math.pi / 6, math.pi / 6);
    final beamX = cx + math.cos(beamAngle + t * math.pi * 0.2) * size.width * 0.3;
    final beamPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.transparent, c1.withValues(alpha: 0.35), Colors.transparent],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(beamX - 60, 0, 120, size.height))
      ..blendMode = BlendMode.screen;
    canvas.save();
    canvas.translate(beamX, cy);
    canvas.rotate(beamAngle);
    canvas.drawRect(
      Rect.fromCenter(center: Offset.zero, width: 120, height: size.height * 1.5),
      beamPaint,
    );
    canvas.restore();

    _paintCentralGeometry(canvas, size, c1, c2, rng, t);
  }

  void _paintCentralGeometry(Canvas canvas, Size size, Color c1, Color c2, _Seeded rng, double t) {
    final cx = size.width / 2;
    final cy = size.height * 0.45;
    final r = size.width * 0.18;
    final sides = 3 + rng.nextInt(3) * 2;
    final rot = t * math.pi * 0.4;

    final path = Path();
    for (int i = 0; i < sides; i++) {
      final angle = rot + (2 * math.pi * i / sides) - math.pi / 2;
      final px = cx + r * math.cos(angle);
      final py = cy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(px, py);
      } else {
        path.lineTo(px, py);
      }
    }
    path.close();

    canvas.drawPath(path, Paint()
      ..color = c1.withValues(alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 24));
    canvas.drawPath(path, Paint()
      ..color = c1.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5);

    final innerPath = Path();
    for (int i = 0; i < sides; i++) {
      final angle = -rot * 1.5 + (2 * math.pi * i / sides) - math.pi / 2;
      final px = cx + r * 0.55 * math.cos(angle);
      final py = cy + r * 0.55 * math.sin(angle);
      if (i == 0) {
        innerPath.moveTo(px, py);
      } else {
        innerPath.lineTo(px, py);
      }
    }
    innerPath.close();
    canvas.drawPath(innerPath, Paint()
      ..color = c2.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0);
  }

  // ── CREATIVITY ───────────────────────────────────────────────────────────
  void _paintCreativity(Canvas canvas, Size size) {
    final rng = _Seeded(seed);
    final c1 = colors[0];
    final c2 = colors[1];

    final strokeCount = 12 + rng.nextInt(8);
    for (int i = 0; i < strokeCount; i++) {
      final startX = rng.range(0, size.width);
      final startY = rng.range(0, size.height);
      final cp1x = rng.range(0, size.width);
      final cp1y = rng.range(0, size.height);
      final cp2x = rng.range(0, size.width);
      final cp2y = rng.range(0, size.height);
      final endX  = rng.range(0, size.width);
      final endY  = rng.range(0, size.height);

      final phase = t * 2 * math.pi + i * 0.6;
      final opacity = 0.08 + math.sin(phase) * 0.06;
      final color = Color.lerp(c1, c2, rng.next())!;

      final path = Path()
        ..moveTo(startX, startY)
        ..cubicTo(cp1x, cp1y, cp2x, cp2y, endX, endY);
      canvas.drawPath(path, Paint()
        ..color = color.withValues(alpha: opacity.clamp(0, 0.3))
        ..style = PaintingStyle.stroke
        ..strokeWidth = rng.range(1.0, 4.0)
        ..strokeCap = StrokeCap.round);
    }

    final burstCount = 5 + rng.nextInt(4);
    for (int i = 0; i < burstCount; i++) {
      final bx = rng.range(size.width * 0.1, size.width * 0.9);
      final by = rng.range(size.height * 0.1, size.height * 0.9);
      final phase = t * 2 * math.pi + i * 1.3;
      final br = size.width * rng.range(0.04, 0.14) * (0.8 + math.sin(phase) * 0.2);
      final color = Color.lerp(c1, c2, rng.next())!;
      canvas.drawCircle(Offset(bx, by), br, Paint()
        ..shader = RadialGradient(
          colors: [color.withValues(alpha: 0.3), Colors.transparent],
        ).createShader(Rect.fromCircle(center: Offset(bx, by), radius: br)));
    }

    final dotCount = 40 + rng.nextInt(30);
    for (int i = 0; i < dotCount; i++) {
      final r = rng.range(0, size.width * 0.28);
      final angle = rng.range(0, 2 * math.pi);
      final dx = size.width * 0.5 + r * math.cos(angle);
      final dy = size.height * 0.5 + r * math.sin(angle);
      final ds = rng.range(1.0, 4.0);
      final color = Color.lerp(c1, c2, rng.next())!;
      canvas.drawCircle(Offset(dx, dy), ds, Paint()..color = color.withValues(alpha: rng.range(0.15, 0.5)));
    }
  }

  // ── MINDFULNESS ──────────────────────────────────────────────────────────
  void _paintMindfulness(Canvas canvas, Size size) {
    final rng = _Seeded(seed);
    final c1 = colors[0];
    final c2 = colors[1];
    final cx = size.width * rng.range(0.35, 0.65);
    final cy = size.height * rng.range(0.3, 0.55);

    final ringCount = 10 + rng.nextInt(8);
    for (int i = 0; i < ringCount; i++) {
      final frac = i / ringCount;
      final phase = t * 2 * math.pi * 0.3;
      final r = (frac + phase * 0.05) % 1.0;
      final radius = r * size.width * 0.75;
      final opacity = (1.0 - r) * 0.18;
      final color = Color.lerp(c1, c2, frac)!;
      canvas.drawCircle(Offset(cx, cy), radius, Paint()
        ..color = color.withValues(alpha: opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8 + (1.0 - frac) * 1.2);
    }

    canvas.drawCircle(Offset(cx, cy), size.width * 0.12, Paint()
      ..shader = RadialGradient(
        colors: [c1.withValues(alpha: 0.35), Colors.transparent],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: size.width * 0.12)));

    final particleCount = 20 + rng.nextInt(15);
    for (int i = 0; i < particleCount; i++) {
      final angle = rng.range(0, 2 * math.pi);
      final speed = rng.range(0.1, 0.4);
      final r = ((t * speed + rng.next()) % 1.0) * size.width * 0.5;
      final px = cx + r * math.cos(angle);
      final py = cy + r * math.sin(angle);
      final pr = rng.range(1.0, 3.0);
      final opacity = (1.0 - r / (size.width * 0.5)) * 0.5;
      canvas.drawCircle(Offset(px, py), pr, Paint()..color = c1.withValues(alpha: opacity.clamp(0, 0.5)));
    }

    for (int w = 0; w < 5; w++) {
      final y0 = cy + size.height * (0.15 + w * 0.07);
      final path = Path();
      path.moveTo(0, y0);
      for (double x = 0; x <= size.width; x += 4) {
        final wave = math.sin(x / size.width * math.pi * 4 + t * 2 * math.pi + w * 0.7);
        path.lineTo(x, y0 + wave * 6 * (1 - w * 0.15));
      }
      canvas.drawPath(path, Paint()
        ..color = c2.withValues(alpha: 0.08 + w * 0.01)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8);
    }
  }

  // ── REASON ───────────────────────────────────────────────────────────────
  void _paintReason(Canvas canvas, Size size) {
    // ignore: unused_local_variable
    final rng = _Seeded(seed);
    final c1 = colors[0];
    final c2 = colors[1];
    final cx = size.width / 2;
    final cy = size.height / 2;

    const spacing = 28.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), Paint()..color = c1.withValues(alpha: 0.04)..strokeWidth = 0.5);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), Paint()..color = c1.withValues(alpha: 0.04)..strokeWidth = 0.5);
    }

    final spiralPath = Path();
    var spiralX = cx, spiralY = cy;
    var r = 2.0;
    const phiRecip = 1.0 / 1.618;
    spiralPath.moveTo(spiralX, spiralY);
    for (double angle = 0; angle < 8 * math.pi; angle += 0.08) {
      final animAngle = angle + t * math.pi * 0.5;
      spiralX = cx + r * math.cos(animAngle);
      spiralY = cy + r * math.sin(animAngle);
      spiralPath.lineTo(spiralX, spiralY);
      r *= 1.0 + phiRecip * 0.08;
      if (r > size.width * 0.55) break;
    }
    canvas.drawPath(spiralPath, Paint()
      ..color = c1.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round);

    for (double x = cx - spacing * 4; x < cx + spacing * 5; x += spacing) {
      for (double y = cy - spacing * 3; y < cy + spacing * 4; y += spacing) {
        final dist = math.sqrt(math.pow(x - cx, 2) + math.pow(y - cy, 2));
        final opacity = (1.0 - dist / (size.width * 0.6)).clamp(0.0, 1.0) * 0.35;
        canvas.drawCircle(Offset(x, y), 1.2, Paint()..color = c2.withValues(alpha: opacity));
      }
    }

    final pulseFrac = (t * 1.5) % 1.0;
    final pulseR = pulseFrac * size.width * 0.45;
    canvas.drawCircle(Offset(cx, cy), pulseR, Paint()
      ..color = c1.withValues(alpha: (1.0 - pulseFrac) * 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0);
  }

  // ── EXISTENTIAL ──────────────────────────────────────────────────────────
  void _paintExistential(Canvas canvas, Size size) {
    final rng = _Seeded(seed);
    final c1 = colors[0];
    final c2 = colors[1];

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()
      ..shader = const RadialGradient(
        center: Alignment(0, -0.4), radius: 1.2,
        colors: [Color(0xFF0A0518), Color(0xFF030108)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)));

    final starCount = 60 + rng.nextInt(40);
    for (int i = 0; i < starCount; i++) {
      final sx = rng.range(0, size.width);
      final sy = rng.range(0, size.height);
      final sr = rng.range(0.4, 1.8);
      final twinkle = math.sin(t * 2 * math.pi * rng.range(0.3, 1.5) + i) * 0.5 + 0.5;
      canvas.drawCircle(Offset(sx, sy), sr, Paint()..color = Colors.white.withValues(alpha: twinkle * 0.6 + 0.1));
    }

    final dotX = size.width * rng.range(0.3, 0.7);
    final dotY = size.height * rng.range(0.25, 0.55);
    final dotPulse = math.sin(t * 2 * math.pi * 0.4) * 0.5 + 0.5;

    canvas.drawCircle(Offset(dotX, dotY), size.width * 0.09, Paint()
      ..shader = RadialGradient(
        colors: [c1.withValues(alpha: 0.25 + dotPulse * 0.15), Colors.transparent],
      ).createShader(Rect.fromCircle(center: Offset(dotX, dotY), radius: size.width * 0.09)));
    canvas.drawCircle(Offset(dotX, dotY), size.width * 0.025, Paint()
      ..shader = RadialGradient(
        colors: [Colors.white.withValues(alpha: 0.9), c1.withValues(alpha: 0.5), Colors.transparent],
      ).createShader(Rect.fromCircle(center: Offset(dotX, dotY), radius: size.width * 0.025)));

    for (int ray = 0; ray < 6; ray++) {
      final angle = t * math.pi * 0.3 + ray * math.pi / 3;
      final len = size.width * rng.range(0.1, 0.3);
      canvas.drawLine(Offset(dotX, dotY), Offset(dotX + len * math.cos(angle), dotY + len * math.sin(angle)),
        Paint()..color = c1.withValues(alpha: 0.06 + dotPulse * 0.04)..strokeWidth = 0.6);
    }

    final smearX = size.width * rng.range(0.1, 0.4);
    final smearY = size.height * rng.range(0.1, 0.4);
    canvas.save();
    canvas.translate(smearX, smearY);
    canvas.rotate(rng.range(-0.5, 0.5));
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: size.width * rng.range(0.12, 0.22), height: size.height * rng.range(0.03, 0.07)),
      Paint()..shader = RadialGradient(
        colors: [c2.withValues(alpha: 0.18), Colors.transparent],
      ).createShader(Rect.fromCenter(center: Offset.zero, width: size.width * 0.2, height: size.height * 0.06)));
    canvas.restore();
  }

  // ── RELATIONS ────────────────────────────────────────────────────────────
  void _paintRelations(Canvas canvas, Size size) {
    final rng = _Seeded(seed);
    final c1 = colors[0];
    final c2 = colors[1];

    final nodeCount = 7 + rng.nextInt(5);
    final nodes = List.generate(nodeCount, (i) {
      final r = size.width * rng.range(0.1, 0.42);
      final angle = (2 * math.pi * i / nodeCount) + rng.range(-0.3, 0.3);
      return Offset(size.width * 0.5 + r * math.cos(angle), size.height * 0.5 + r * math.sin(angle));
    });

    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final dist = (nodes[i] - nodes[j]).distance;
        final maxDist = size.width * 0.65;
        if (dist > maxDist) continue;
        final opacity = (1.0 - dist / maxDist) * 0.15;
        final phase = t * 2 * math.pi * 0.4 + i * 0.7 + j * 0.3;
        final pulse = math.sin(phase) * 0.5 + 0.5;

        final mid = Offset(
          (nodes[i].dx + nodes[j].dx) / 2 + rng.range(-20, 20),
          (nodes[i].dy + nodes[j].dy) / 2 + rng.range(-20, 20));
        final path = Path()
          ..moveTo(nodes[i].dx, nodes[i].dy)
          ..quadraticBezierTo(mid.dx, mid.dy, nodes[j].dx, nodes[j].dy);
        canvas.drawPath(path, Paint()
          ..color = Color.lerp(c1, c2, rng.next())!.withValues(alpha: (opacity + pulse * 0.08).clamp(0, 0.3))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8 + pulse * 0.4);
      }
    }

    for (int i = 0; i < nodes.length; i++) {
      final phase = t * 2 * math.pi * 0.6 + i * 1.1;
      final pulse = math.sin(phase) * 0.5 + 0.5;
      final nr = 4.0 + pulse * 3.0;
      final color = Color.lerp(c1, c2, i / nodeCount)!;
      canvas.drawCircle(nodes[i], nr * 3, Paint()
        ..color = color.withValues(alpha: 0.1 + pulse * 0.08)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8));
      canvas.drawCircle(nodes[i], nr, Paint()..color = color.withValues(alpha: 0.7 + pulse * 0.3));
    }

    final hubPulse = math.sin(t * 2 * math.pi * 0.8) * 0.5 + 0.5;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 16 + hubPulse * 6, Paint()
      ..shader = RadialGradient(
        colors: [c1.withValues(alpha: 0.6), c2.withValues(alpha: 0.2), Colors.transparent],
      ).createShader(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 22 + hubPulse * 6)));
  }

  // ── Vignette ─────────────────────────────────────────────────────────────
  void _paintVignette(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()
      ..shader = RadialGradient(
        center: Alignment.center, radius: 0.85,
        colors: [Colors.transparent, Colors.black.withValues(alpha: 0.55)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)));
  }

  @override
  bool shouldRepaint(covariant _ArtPainter old) =>
      old.t != t || old.seed != seed || old.visualStyle != visualStyle;
}