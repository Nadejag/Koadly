import 'ride_service.dart';

enum BookingStatus { draft, pending, confirmed, completed, cancelled }

extension BookingStatusLabel on BookingStatus {
  String get label {
    switch (this) {
      case BookingStatus.draft:
        return 'Draft';
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class Booking {
  const Booking({
    required this.id,
    required this.customerName,
    required this.phone,
    required this.pickup,
    required this.dropoff,
    required this.pickupDate,
    required this.pickupTimeLabel,
    required this.service,
    required this.distanceKm,
    required this.quote,
    required this.status,
    this.note = '',
  });

  final int id;
  final String customerName;
  final String phone;
  final String pickup;
  final String dropoff;
  final DateTime pickupDate;
  final String pickupTimeLabel;
  final RideService service;
  final double distanceKm;
  final double quote;
  final BookingStatus status;
  final String note;
}
