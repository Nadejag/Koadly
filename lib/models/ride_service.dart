import 'package:flutter/material.dart';

class RideService {
  const RideService({
    required this.id,
    required this.name,
    required this.description,
    required this.baseFare,
    required this.ratePerKm,
    required this.icon,
  });

  final int id;
  final String name;
  final String description;
  final double baseFare;
  final double ratePerKm;
  final IconData icon;
}
