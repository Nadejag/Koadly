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
          onPressed: () => _showMoreMenu(context, viewModel),
          icon: Icon(Icons.menu, size: responsive.icon(24)),
          tooltip: 'Menu',
        ),
      ],
    );
  }

  void _showMoreMenu(BuildContext context, KoadlyViewModel viewModel) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withValues(alpha: 0.42),
      transitionDuration: const Duration(milliseconds: 380),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _MoreMenu(viewModel: viewModel);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.34, 0),
              end: Offset.zero,
            ).animate(curved),
            child: ScaleTransition(
              alignment: Alignment.centerRight,
              scale: Tween<double>(begin: 0.96, end: 1).animate(curved),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class _MoreMenu extends StatelessWidget {
  const _MoreMenu({required this.viewModel});

  final KoadlyViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final drawerWidth = responsive.isCompact
        ? screenWidth * 0.88
        : (screenWidth * 0.5).clamp(360.0, 560.0);
    return SafeArea(
      child: Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: drawerWidth,
            height: double.infinity,
            padding: EdgeInsets.fromLTRB(
              responsive.gap(16),
              responsive.gap(16),
              responsive.gap(16),
              responsive.gap(20),
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x33171a20),
                  blurRadius: 38,
                  offset: Offset(-18, 0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _MenuHeader(onClose: () => Navigator.pop(context)),
                SizedBox(height: responsive.gap(16)),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: viewModel.menuPages.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: responsive.gap(6)),
                    itemBuilder: (context, index) {
                      final page = viewModel.menuPages[index];
                      final selected = viewModel.currentPage == page;
                      return _AnimatedMenuTile(
                        index: index,
                        child: _MenuTile(
                          page: page,
                          selected: selected,
                          onTap: () {
                            Navigator.pop(context);
                            viewModel.goTo(page);
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: responsive.gap(12)),
                const _MenuFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuHeader extends StatelessWidget {
  const _MenuHeader({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      padding: EdgeInsets.all(responsive.gap(16)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xfffff5ef), Color(0xffffe0d1), Color(0xffffffff)],
        ),
        borderRadius: BorderRadius.circular(responsive.radius(20)),
        border: Border.all(color: const Color(0xffffd9c8)),
      ),
      child: Row(
        children: [
          Container(
            width: responsive.gap(48),
            height: responsive.gap(48),
            decoration: BoxDecoration(
              color: KoadlyColors.orange,
              borderRadius: BorderRadius.circular(responsive.radius(14)),
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
                  fontSize: responsive.font(26, min: 22, max: 30),
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
                  'Koadly Menu',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: responsive.font(20, min: 18, max: 24),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: responsive.gap(3)),
                Text(
                  'Quick access to every service',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: KoadlyColors.muted,
                    fontSize: responsive.font(13, min: 12, max: 15),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          IconButton.filled(
            onPressed: onClose,
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: KoadlyColors.ink,
            ),
            icon: Icon(Icons.close, size: responsive.icon(21)),
            tooltip: 'Close menu',
          ),
        ],
      ),
    );
  }
}

class _AnimatedMenuTile extends StatelessWidget {
  const _AnimatedMenuTile({required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 240 + (index.clamp(0, 7) * 34)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset((1 - value) * 28, 0),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.page,
    required this.selected,
    required this.onTap,
  });

  final AppPage page;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Material(
      color: selected ? const Color(0xffffeee6) : Colors.transparent,
      borderRadius: BorderRadius.circular(responsive.radius(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(responsive.radius(16)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: responsive.gap(14),
            vertical: responsive.gap(12),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(responsive.radius(16)),
            border: Border.all(
              color: selected ? const Color(0xffffcbb6) : KoadlyColors.line,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: responsive.gap(42),
                height: responsive.gap(42),
                decoration: BoxDecoration(
                  color: selected
                      ? KoadlyColors.orange
                      : const Color(0xfffff4ee),
                  borderRadius: BorderRadius.circular(responsive.radius(13)),
                ),
                child: Icon(
                  page.icon,
                  color: selected ? Colors.white : KoadlyColors.orange,
                  size: responsive.icon(22),
                ),
              ),
              SizedBox(width: responsive.gap(12)),
              Expanded(
                child: Text(
                  page.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: responsive.font(16),
                    fontWeight: FontWeight.w900,
                    color: selected
                        ? KoadlyColors.orangeDark
                        : KoadlyColors.ink,
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: selected ? 1 : 0.42,
                duration: const Duration(milliseconds: 180),
                child: Icon(
                  selected ? Icons.check_circle : Icons.chevron_right,
                  color: selected ? KoadlyColors.orange : KoadlyColors.muted,
                  size: responsive.icon(selected ? 21 : 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuFooter extends StatelessWidget {
  const _MenuFooter();

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      padding: EdgeInsets.all(responsive.gap(14)),
      decoration: BoxDecoration(
        color: const Color(0xfff7f8f8),
        borderRadius: BorderRadius.circular(responsive.radius(16)),
        border: Border.all(color: KoadlyColors.line),
      ),
      child: Row(
        children: [
          Icon(
            Icons.support_agent,
            color: KoadlyColors.orange,
            size: responsive.icon(24),
          ),
          SizedBox(width: responsive.gap(10)),
          Expanded(
            child: Text(
              'Support and booking help are one tap away.',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: KoadlyColors.muted,
                fontSize: responsive.font(13, min: 12, max: 15),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
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
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: KoadlyColors.orangeDark,
                fontSize: responsive.font(14, min: 12, max: 15),
                fontWeight: FontWeight.w800,
              ),
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
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: responsive.font(14, min: 12, max: 15),
                fontWeight: FontWeight.w800,
              ),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final tightCard =
            constraints.maxWidth < 190 || constraints.maxHeight < 220;
        final cardPadding = tightCard ? 10.0 : 14.0;
        final contentGap = responsive.gap(tightCard ? 8 : 12);
        return KoadlyCard(
          padding: EdgeInsets.all(cardPadding),
          child: KoadlyTapEffect(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleIcon(icon: service.icon, compact: true),
                    SizedBox(width: responsive.gap(tightCard ? 8 : 10)),
                    Expanded(
                      child: Text(
                        service.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: responsive.font(
                            tightCard ? 15 : 16,
                            min: 13,
                            max: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: contentGap),
                Expanded(
                  child: Text(
                    service.description,
                    maxLines: tightCard ? 2 : 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: KoadlyColors.muted,
                      fontSize: responsive.font(
                        tightCard ? 13 : 14,
                        min: 12,
                        max: 15,
                      ),
                      height: 1.28,
                    ),
                  ),
                ),
                SizedBox(height: responsive.gap(tightCard ? 8 : 12)),
                Row(
                  children: [
                    Expanded(
                      child: MiniBadge(
                        label: 'From \$${service.baseFare.toStringAsFixed(2)}',
                        compact: tightCard,
                      ),
                    ),
                    SizedBox(width: responsive.gap(7)),
                    Expanded(
                      child: MiniBadge(
                        label: service.ratePerKm == 0
                            ? 'Hourly plan'
                            : '\$${service.ratePerKm.toStringAsFixed(2)} / km',
                        compact: tightCard,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MiniBadge extends StatelessWidget {
  const MiniBadge({super.key, required this.label, this.compact = false});

  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.gap(compact ? 7 : 10),
        vertical: responsive.gap(compact ? 6 : 7),
      ),
      decoration: BoxDecoration(
        color: const Color(0xfffff4ee),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xffffdfd0)),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: KoadlyColors.orangeDark,
          fontSize: responsive.font(compact ? 11 : 12, min: 10, max: 13),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final tight = constraints.maxWidth < 290;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          height: responsive.gap(tight ? 118 : 132).clamp(112, 150),
          padding: EdgeInsets.all(responsive.gap(tight ? 10 : 14)),
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
                      size: responsive.icon(tight ? 28 : 34),
                    ),
                  ),
                ),
              ),
              SizedBox(width: responsive.gap(tight ? 8 : 12)),
              Flexible(
                flex: tight ? 2 : 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Route estimate',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: responsive.font(
                          tight ? 12 : 14,
                          min: 11,
                          max: 16,
                        ),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    AnimatedNumberText(
                      value: distance,
                      builder: (context, value) => Text(
                        '${value.toStringAsFixed(1)} km',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: KoadlyColors.muted,
                          fontSize: responsive.font(
                            tight ? 12 : 13,
                            min: 11,
                            max: 15,
                          ),
                        ),
                      ),
                    ),
                    AnimatedNumberText(
                      value: quote,
                      builder: (context, value) => FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          '\$${value.toStringAsFixed(2)}',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: responsive.font(
                              tight ? 20 : 24,
                              min: 18,
                              max: 28,
                            ),
                            color: KoadlyColors.orange,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
