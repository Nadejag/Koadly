import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../core/responsive.dart';
import '../models/app_page.dart';
import '../viewmodels/app_view_model.dart';
import 'screens/about_screen.dart';
import 'screens/book_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/drive_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/home_screen.dart';
import 'screens/legal_screen.dart';
import 'screens/login_screen.dart';
import 'screens/reviews_screen.dart';
import 'screens/services_screen.dart';
import 'screens/track_screen.dart';
import 'screens/trips_screen.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = KoadlyViewModelScope.of(context);
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) {
        final responsive = context.responsive;
        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 320),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                final offset = Tween<Offset>(
                  begin: const Offset(0.035, 0),
                  end: Offset.zero,
                ).animate(animation);
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(position: offset, child: child),
                );
              },
              child: KeyedSubtree(
                key: ValueKey(viewModel.currentPage),
                child: _screenFor(viewModel.currentPage),
              ),
            ),
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              height: responsive.gap(70),
              labelTextStyle: WidgetStateProperty.resolveWith(
                (states) => TextStyle(
                  fontSize: responsive.font(12, min: 11, max: 14),
                  fontWeight: states.contains(WidgetState.selected)
                      ? FontWeight.w900
                      : FontWeight.w700,
                ),
              ),
              iconTheme: WidgetStateProperty.resolveWith(
                (states) => IconThemeData(
                  size: responsive.icon(24),
                  color: states.contains(WidgetState.selected)
                      ? KoadlyColors.orange
                      : KoadlyColors.ink,
                ),
              ),
            ),
            child: NavigationBar(
              selectedIndex: _selectedIndex(viewModel),
              onDestinationSelected: (index) =>
                  viewModel.goTo(viewModel.primaryPages[index]),
              indicatorColor: const Color(0xffffeee6),
              labelBehavior: responsive.isCompact
                  ? NavigationDestinationLabelBehavior.onlyShowSelected
                  : NavigationDestinationLabelBehavior.alwaysShow,
              destinations: [
                for (final page in viewModel.primaryPages)
                  NavigationDestination(
                    icon: Icon(page.icon),
                    selectedIcon: Icon(page.icon),
                    label: page.label,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  int _selectedIndex(KoadlyViewModel viewModel) {
    final index = viewModel.primaryPages.indexOf(viewModel.currentPage);
    return index < 0 ? 0 : index;
  }

  Widget _screenFor(AppPage page) {
    switch (page) {
      case AppPage.home:
        return const HomeScreen();
      case AppPage.book:
        return const BookScreen();
      case AppPage.trips:
        return const TripsScreen();
      case AppPage.services:
        return const ServicesScreen();
      case AppPage.reviews:
        return const ReviewsScreen();
      case AppPage.about:
        return const AboutScreen();
      case AppPage.drive:
        return const DriveScreen();
      case AppPage.contact:
        return const ContactScreen();
      case AppPage.track:
        return const TrackScreen();
      case AppPage.faq:
        return const FaqScreen();
      case AppPage.login:
        return const LoginScreen();
      case AppPage.legal:
        return const LegalScreen();
    }
  }
}
