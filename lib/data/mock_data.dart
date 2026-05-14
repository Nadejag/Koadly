import 'package:flutter/material.dart';

import '../models/booking.dart';
import '../models/review.dart';
import '../models/ride_service.dart';

const rideServices = [
  RideService(
    id: 1,
    name: 'Airport Transfers',
    description: 'Timely pickups and drop-offs to all major airports.',
    baseFare: 18,
    ratePerKm: 1.75,
    icon: Icons.flight_takeoff,
  ),
  RideService(
    id: 2,
    name: 'Business Travel',
    description: 'Professional rides for corporate and executive travelers.',
    baseFare: 25,
    ratePerKm: 2.10,
    icon: Icons.business_center_outlined,
  ),
  RideService(
    id: 3,
    name: 'City Rides',
    description: 'Comfortable rides across the city, anytime.',
    baseFare: 10,
    ratePerKm: 1.45,
    icon: Icons.location_city_outlined,
  ),
  RideService(
    id: 4,
    name: 'Hourly Booking',
    description: 'Book by the hour for meetings, events, or custom plans.',
    baseFare: 35,
    ratePerKm: 0,
    icon: Icons.timer_outlined,
  ),
];

const initialReviews = [
  Review(
    name: 'Sarah Khan',
    comment: 'Clean vehicle, professional driver and on-time airport pickup.',
    rating: 5,
  ),
  Review(
    name: 'Ali Raza',
    comment: 'Booking was easy and the ride was comfortable.',
    rating: 5,
  ),
];

List<Booking> seedBookings() {
  final now = DateTime.now();
  return [
    Booking(
      id: 1042,
      customerName: 'Guest Customer',
      phone: '+92 300 0000000',
      pickup: 'Airport Terminal 3',
      dropoff: 'Downtown Hotel',
      pickupDate: now.add(const Duration(days: 1)),
      pickupTimeLabel: '10:30 AM',
      service: rideServices.first,
      distanceKm: 22.4,
      quote: 57.20,
      status: BookingStatus.confirmed,
      note: 'Flight pickup',
    ),
    Booking(
      id: 1038,
      customerName: 'Guest Customer',
      phone: '+92 300 0000000',
      pickup: 'City Center',
      dropoff: 'Business Bay',
      pickupDate: now.subtract(const Duration(days: 3)),
      pickupTimeLabel: '02:00 PM',
      service: rideServices[1],
      distanceKm: 8.6,
      quote: 43.06,
      status: BookingStatus.completed,
    ),
  ];
}
