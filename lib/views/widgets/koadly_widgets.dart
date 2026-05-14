import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../core/responsive.dart';
import '../../models/app_page.dart';
import '../../models/booking.dart';
import '../../models/review.dart';
import '../../models/ride_service.dart';
import '../../viewmodels/app_view_model.dart';

class KoadlyHeader extends StatelessWidget {
  const KoadlyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = KoadlyViewModelScope.of(context);
    final responsive = context.responsive;
    final logoSize = responsive.gap(50);
    return Row(
      children: [
        Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            color: KoadlyColors.orange,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26ff5a16),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'K',
              style: TextStyle(
                color: Colors.white,
                fontSize: responsive.font(28, min: 24, max: 32),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        SizedBox(width: responsive.gap(12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Koadly Associates',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: responsive.font(20, min: 18, max: 24),
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'Premium transport services',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: KoadlyColors.muted,
                  fontSize: responsive.font(14, min: 12, max: 16),
                ),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          onPressed: () => showModalBottomSheet<void>(
            context: context,
            showDragHandle: true,
            builder: (_) => _MoreMenu(viewModel: viewModel),
          ),
          icon: Icon(Icons.menu, size: responsive.icon(24)),
          tooltip: 'Menu',
        ),
      ],
    );
  }
}

class _MoreMenu extends StatelessWidget {
  const _MoreMenu({required this.viewModel});

  final KoadlyViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          responsive.horizontalPadding,
          4,
          responsive.horizontalPadding,
          responsive.gap(20),
        ),
        child: Wrap(
          runSpacing: responsive.gap(8),
          children: [
            for (final page in viewModel.menuPages)
              ListTile(
                leading: Icon(
                  page.icon,
                  color: KoadlyColors.orange,
                  size: responsive.icon(24),
                ),
                title: Text(
                  page.label,
                  style: TextStyle(
                    fontSize: responsive.font(16),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.goTo(page);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class PageScaffold extends StatelessWidget {
  const PageScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.hero,
  });

  final String title;
  final String subtitle;
  final Widget? hero;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final viewModel = KoadlyViewModelScope.of(context);
    final responsive = context.responsive;
    return ListView(
      padding: EdgeInsets.fromLTRB(
        responsive.horizontalPadding,
        responsive.gap(16),
        responsive.horizontalPadding,
        responsive.bottomPadding,
      ),
      children: [
        const KoadlyHeader(),
        SizedBox(height: responsive.gap(22)),
        if (viewModel.bannerMessage != null) ...[
          KoadlyBanner(message: viewModel.bannerMessage!),
          SizedBox(height: responsive.gap(14)),
        ],
        hero ??
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: responsive.font(34, min: 28, max: 42),
                    height: 1.08,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: responsive.gap(8)),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: KoadlyColors.muted,
                    fontSize: responsive.font(16, min: 14, max: 18),
                    height: 1.45,
                  ),
                ),
              ],
            ),
        SizedBox(height: responsive.gap(20)),
        for (var index = 0; index < children.length; index++)
          StaggeredReveal(index: index, child: children[index]),
      ],
    );
  }
}

class StaggeredReveal extends StatelessWidget {
  const StaggeredReveal({super.key, required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 260 + (index.clamp(0, 6) * 35)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 14),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class KoadlyBanner extends StatelessWidget {
  const KoadlyBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.96, end: 1),
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          alignment: Alignment.topCenter,
          child: child,
        );
      },
      child: Container(
        padding: EdgeInsets.all(responsive.gap(14)),
        decoration: BoxDecoration(
          color: const Color(0xfffff1e9),
          borderRadius: BorderRadius.circular(responsive.radius(14)),
          border: Border.all(color: const Color(0xffffd3bf)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: KoadlyColors.orange,
              size: responsive.icon(22),
            ),
            SizedBox(width: responsive.gap(10)),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: responsive.font(14),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeroPanel extends StatelessWidget {
  const HeroPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = KoadlyViewModelScope.of(context);
    final responsive = context.responsive;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.all(responsive.gap(22)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xfffff1e9), Color(0xff202228)],
          stops: [0, 0.58, 1],
        ),
        borderRadius: BorderRadius.circular(responsive.radius(24)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1f171a20),
            blurRadius: 28,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KoadlyPill(
            icon: Icons.flight_takeoff,
            label: 'Airport Transfers & More',
          ),
          SizedBox(height: responsive.gap(20)),
          Text(
            'Reliable rides,\nevery time.',
            style: TextStyle(
              fontSize: responsive.font(38, min: 32, max: 46),
              height: 1.05,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: responsive.gap(10)),
          Text(
            'Verified drivers, fast booking, clear quotes, and admin-controlled trip status for airport, city, business, and hourly rides.',
            style: TextStyle(
              fontSize: responsive.font(16, min: 14, max: 18),
              color: const Color(0xff454a52),
              height: 1.45,
            ),
          ),
          SizedBox(height: responsive.gap(18)),
          Wrap(
            spacing: responsive.gap(10),
            runSpacing: responsive.gap(10),
            children: [
              const TrustChip(
                icon: Icons.verified_user_outlined,
                label: 'Verified drivers',
              ),
              const TrustChip(icon: Icons.schedule, label: 'On-time pickup'),
              const TrustChip(icon: Icons.star_outline, label: 'Top rated'),
              ActionChip(
                avatar: Icon(
                  Icons.local_taxi_outlined,
                  color: KoadlyColors.orange,
                  size: responsive.icon(18),
                ),
                label: const Text('Book now'),
                onPressed: () => viewModel.goTo(AppPage.book),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class KoadlyCard extends StatelessWidget {
  const KoadlyCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.98, end: 1),
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.only(
          left: responsive.gap(padding.left),
          top: responsive.gap(padding.top),
          right: responsive.gap(padding.right),
          bottom: responsive.gap(padding.bottom),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(responsive.radius(20)),
          border: Border.all(color: KoadlyColors.line),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0f171a20),
              blurRadius: 24,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class KoadlyTapEffect extends StatefulWidget {
  const KoadlyTapEffect({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<KoadlyTapEffect> createState() => _KoadlyTapEffectState();
}

class _KoadlyTapEffectState extends State<KoadlyTapEffect> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap == null
          ? null
          : (_) => setState(() => _pressed = true),
      onTapCancel: widget.onTap == null
          ? null
          : () => setState(() => _pressed = false),
      onTapUp: widget.onTap == null
          ? null
          : (_) {
              setState(() => _pressed = false);
              widget.onTap?.call();
            },
      child: AnimatedScale(
        scale: _pressed ? 0.975 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

class AnimatedNumberText extends StatelessWidget {
  const AnimatedNumberText({
    super.key,
    required this.value,
    required this.builder,
    this.duration = const Duration(milliseconds: 360),
  });

  final double value;
  final Widget Function(BuildContext context, double value) builder;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: value),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) => builder(context, value),
    );
  }
}

class ResponsiveIcon extends StatelessWidget {
  const ResponsiveIcon(this.icon, {super.key, this.color, this.size = 24});

  final IconData icon;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: color, size: context.responsive.icon(size));
  }
}

class KoadlyPill extends StatelessWidget {
  const KoadlyPill({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.gap(12),
        vertical: responsive.gap(8),
      ),
      decoration: BoxDecoration(
        color: const Color(0xffffeee6),
        borderRadius: BorderRadius.circular(responsive.radius(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: KoadlyColors.orange, size: responsive.icon(18)),
          SizedBox(width: responsive.gap(8)),
          Text(
            label,
            style: TextStyle(
              color: KoadlyColors.orangeDark,
              fontSize: responsive.font(14, min: 12, max: 15),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class TrustChip extends StatelessWidget {
  const TrustChip({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.gap(12),
        vertical: responsive.gap(9),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: KoadlyColors.orange, size: responsive.icon(18)),
          SizedBox(width: responsive.gap(7)),
          Text(
            label,
            style: TextStyle(
              fontSize: responsive.font(14, min: 12, max: 15),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class CircleIcon extends StatelessWidget {
  const CircleIcon({super.key, required this.icon, this.compact = false});

  final IconData icon;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final size = responsive.gap(compact ? 42 : 54);
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xffff6a21), Color(0xffff4a00)],
        ),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: responsive.icon(compact ? 21 : 27),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service, this.onTap});

  final RideService service;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return KoadlyCard(
      padding: const EdgeInsets.all(14),
      child: KoadlyTapEffect(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleIcon(icon: service.icon, compact: true),
                SizedBox(width: responsive.gap(10)),
                Expanded(
                  child: Text(
                    service.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: responsive.font(16, min: 14, max: 18),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: responsive.gap(12)),
            Text(
              service.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: KoadlyColors.muted,
                fontSize: responsive.font(14, min: 12, max: 15),
                height: 1.35,
              ),
            ),
            SizedBox(height: responsive.gap(14)),
            Wrap(
              spacing: responsive.gap(8),
              runSpacing: responsive.gap(8),
              children: [
                MiniBadge(
                  label: 'From \$${service.baseFare.toStringAsFixed(2)}',
                ),
                MiniBadge(
                  label: service.ratePerKm == 0
                      ? 'Hourly plan'
                      : '\$${service.ratePerKm.toStringAsFixed(2)} / km',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MiniBadge extends StatelessWidget {
  const MiniBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.gap(10),
        vertical: responsive.gap(7),
      ),
      decoration: BoxDecoration(
        color: const Color(0xfffff4ee),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xffffdfd0)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: KoadlyColors.orangeDark,
          fontSize: responsive.font(12, min: 11, max: 13),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class BookingTile extends StatelessWidget {
  const BookingTile({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return KoadlyCard(
      child: Row(
        children: [
          CircleIcon(icon: booking.service.icon, compact: true),
          SizedBox(width: responsive.gap(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#${booking.id} • ${booking.status.label}',
                  style: TextStyle(
                    color: KoadlyColors.orange,
                    fontSize: responsive.font(14, min: 12, max: 15),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: responsive.gap(4)),
                Text(
                  '${booking.pickup} → ${booking.dropoff}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: responsive.font(15, min: 13, max: 17),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '${booking.service.name} • ${booking.pickupTimeLabel}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: KoadlyColors.muted,
                    fontSize: responsive.font(13, min: 12, max: 14),
                  ),
                ),
              ],
            ),
          ),
          AnimatedNumberText(
            value: booking.quote,
            builder: (context, value) => Text(
              '\$${value.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: responsive.font(15, min: 13, max: 17),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return KoadlyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '★' * review.rating,
            style: TextStyle(
              color: KoadlyColors.orange,
              fontSize: responsive.font(20, min: 18, max: 24),
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: responsive.gap(10)),
          Text(
            '"${review.comment}"',
            style: TextStyle(
              fontSize: responsive.font(16, min: 14, max: 18),
              height: 1.35,
            ),
          ),
          SizedBox(height: responsive.gap(10)),
          Text(
            '— ${review.name}',
            style: TextStyle(
              color: KoadlyColors.muted,
              fontSize: responsive.font(14, min: 12, max: 16),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class RoutePreview extends StatelessWidget {
  const RoutePreview({super.key, required this.distance, required this.quote});

  final double distance;
  final double quote;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      height: responsive.gap(132).clamp(118, 150),
      padding: EdgeInsets.all(responsive.gap(14)),
      decoration: BoxDecoration(
        color: const Color(0xfff2f5f3),
        borderRadius: BorderRadius.circular(responsive.radius(18)),
        border: Border.all(color: KoadlyColors.line),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomPaint(
              painter: _RoutePainter(),
              child: Center(
                child: Icon(
                  Icons.local_taxi,
                  color: KoadlyColors.black,
                  size: responsive.icon(34),
                ),
              ),
            ),
          ),
          SizedBox(width: responsive.gap(12)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Route estimate',
                style: TextStyle(
                  fontSize: responsive.font(14, min: 12, max: 16),
                  fontWeight: FontWeight.w900,
                ),
              ),
              AnimatedNumberText(
                value: distance,
                builder: (context, value) => Text(
                  '${value.toStringAsFixed(1)} km',
                  style: TextStyle(
                    color: KoadlyColors.muted,
                    fontSize: responsive.font(13, min: 12, max: 15),
                  ),
                ),
              ),
              AnimatedNumberText(
                value: quote,
                builder: (context, value) => Text(
                  '\$${value.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: responsive.font(24, min: 20, max: 28),
                    color: KoadlyColors.orange,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final road = Paint()
      ..color = KoadlyColors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(size.width * 0.12, size.height * 0.74)
      ..cubicTo(
        size.width * 0.3,
        size.height * 0.08,
        size.width * 0.68,
        size.height * 0.95,
        size.width * 0.9,
        size.height * 0.24,
      );
    canvas.drawPath(path, road);
    final marker = Paint()..color = KoadlyColors.black;
    canvas.drawCircle(Offset(size.width * 0.12, size.height * 0.74), 6, marker);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.24), 6, marker);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TextFieldBlock extends StatelessWidget {
  const TextFieldBlock({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.icon,
    this.maxLines = 1,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? icon;
  final int maxLines;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return TextField(
      controller: controller,
      maxLines: obscureText ? 1 : maxLines,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon == null ? null : Icon(icon, size: responsive.icon(22)),
      ),
      style: TextStyle(fontSize: responsive.font(15, min: 13, max: 17)),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: responsive.font(22, min: 19, max: 26),
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        ?action,
      ],
    );
  }
}
