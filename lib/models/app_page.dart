import 'package:flutter/material.dart';

enum AppPage {
  home,
  book,
  trips,
  services,
  reviews,
  about,
  drive,
  contact,
  track,
  faq,
  login,
  legal,
}

extension AppPageDetails on AppPage {
  String get label {
    switch (this) {
      case AppPage.home:
        return 'Home';
      case AppPage.book:
        return 'Book';
      case AppPage.trips:
        return 'Trips';
      case AppPage.services:
        return 'Services';
      case AppPage.reviews:
        return 'Reviews';
      case AppPage.about:
        return 'About';
      case AppPage.drive:
        return 'Drive';
      case AppPage.contact:
        return 'Support';
      case AppPage.track:
        return 'Track';
      case AppPage.faq:
        return 'FAQ';
      case AppPage.login:
        return 'Profile';
      case AppPage.legal:
        return 'Legal';
    }
  }

  IconData get icon {
    switch (this) {
      case AppPage.home:
        return Icons.home_outlined;
      case AppPage.book:
        return Icons.local_taxi_outlined;
      case AppPage.trips:
        return Icons.route_outlined;
      case AppPage.services:
        return Icons.grid_view_outlined;
      case AppPage.reviews:
        return Icons.star_outline;
      case AppPage.about:
        return Icons.info_outline;
      case AppPage.drive:
        return Icons.drive_eta_outlined;
      case AppPage.contact:
        return Icons.support_agent_outlined;
      case AppPage.track:
        return Icons.manage_search_outlined;
      case AppPage.faq:
        return Icons.help_outline;
      case AppPage.login:
        return Icons.person_outline;
      case AppPage.legal:
        return Icons.gavel_outlined;
    }
  }
}
