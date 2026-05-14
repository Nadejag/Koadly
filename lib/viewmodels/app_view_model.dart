import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/app_page.dart';
import '../models/booking.dart';
import '../models/review.dart';
import '../models/ride_service.dart';

class KoadlyViewModelScope extends InheritedNotifier<KoadlyViewModel> {
  const KoadlyViewModelScope({
    super.key,
    required KoadlyViewModel super.notifier,
    required super.child,
  });

  static KoadlyViewModel of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<KoadlyViewModelScope>();
    assert(scope?.notifier != null, 'KoadlyViewModelScope is missing.');
    return scope!.notifier!;
  }
}

class KoadlyViewModel extends ChangeNotifier {
  KoadlyViewModel()
    : reviews = List.of(initialReviews),
      bookings = seedBookings();

  AppPage currentPage = AppPage.home;
  final List<Review> reviews;
  final List<Booking> bookings;

  final pickupController = TextEditingController();
  final dropoffController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final noteController = TextEditingController();

  final contactNameController = TextEditingController();
  final contactEmailController = TextEditingController();
  final contactPhoneController = TextEditingController();
  final contactSubjectController = TextEditingController();
  final contactMessageController = TextEditingController();

  final reviewNameController = TextEditingController();
  final reviewEmailController = TextEditingController();
  final reviewCommentController = TextEditingController();

  final driverNameController = TextEditingController();
  final driverEmailController = TextEditingController();
  final driverPhoneController = TextEditingController();
  final vehicleTypeController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  final licenseController = TextEditingController();
  final driverMessageController = TextEditingController();

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerPasswordController = TextEditingController();

  final trackIdController = TextEditingController();
  final trackPhoneController = TextEditingController();

  RideService selectedService = rideServices.first;
  DateTime pickupDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay pickupTime = const TimeOfDay(hour: 10, minute: 30);
  int reviewRating = 5;
  Booking? trackedBooking;
  String? bannerMessage;

  List<AppPage> get primaryPages => const [
    AppPage.home,
    AppPage.book,
    AppPage.trips,
    AppPage.contact,
    AppPage.login,
  ];

  List<AppPage> get menuPages => const [
    AppPage.services,
    AppPage.reviews,
    AppPage.about,
    AppPage.drive,
    AppPage.track,
    AppPage.faq,
    AppPage.legal,
  ];

  double get distanceKm {
    final textLength =
        pickupController.text.trim().length +
        dropoffController.text.trim().length;
    return (textLength * 0.72).clamp(6, 48).toDouble();
  }

  double get quote {
    final distancePart = selectedService.ratePerKm == 0
        ? 0
        : distanceKm * selectedService.ratePerKm;
    return selectedService.baseFare + distancePart;
  }

  bool get hasBookingFields {
    return pickupController.text.trim().isNotEmpty &&
        dropoffController.text.trim().isNotEmpty &&
        nameController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty;
  }

  String get pickupTimeLabel {
    final hour = pickupTime.hourOfPeriod == 0 ? 12 : pickupTime.hourOfPeriod;
    final minute = pickupTime.minute.toString().padLeft(2, '0');
    final period = pickupTime.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  void goTo(AppPage page) {
    currentPage = page;
    bannerMessage = null;
    notifyListeners();
  }

  void setService(RideService service) {
    selectedService = service;
    notifyListeners();
  }

  void setPickupDate(DateTime date) {
    pickupDate = date;
    notifyListeners();
  }

  void setPickupTime(TimeOfDay time) {
    pickupTime = time;
    notifyListeners();
  }

  void setReviewRating(int rating) {
    reviewRating = rating;
    notifyListeners();
  }

  void refreshQuote() {
    notifyListeners();
  }

  bool submitBooking() {
    if (!hasBookingFields) {
      bannerMessage = 'Please complete pickup, drop-off, name, and phone.';
      notifyListeners();
      return false;
    }

    bookings.insert(
      0,
      Booking(
        id: 1100 + bookings.length,
        customerName: nameController.text.trim(),
        phone: phoneController.text.trim(),
        pickup: pickupController.text.trim(),
        dropoff: dropoffController.text.trim(),
        pickupDate: pickupDate,
        pickupTimeLabel: pickupTimeLabel,
        service: selectedService,
        distanceKm: distanceKm,
        quote: quote,
        status: BookingStatus.pending,
        note: noteController.text.trim(),
      ),
    );
    bannerMessage = 'Booking request submitted. Admin confirmation is next.';
    goTo(AppPage.trips);
    return true;
  }

  void submitReview() {
    final name = reviewNameController.text.trim().isEmpty
        ? 'Guest Customer'
        : reviewNameController.text.trim();
    final comment = reviewCommentController.text.trim().isEmpty
        ? 'Great service and smooth booking experience.'
        : reviewCommentController.text.trim();
    reviews.insert(
      0,
      Review(name: name, comment: comment, rating: reviewRating),
    );
    reviewNameController.clear();
    reviewEmailController.clear();
    reviewCommentController.clear();
    reviewRating = 5;
    bannerMessage = 'Review submitted for approval.';
    notifyListeners();
  }

  void submitContactMessage() {
    contactNameController.clear();
    contactEmailController.clear();
    contactPhoneController.clear();
    contactSubjectController.clear();
    contactMessageController.clear();
    bannerMessage = 'Message sent. Support will follow up shortly.';
    notifyListeners();
  }

  void submitDriverApplication() {
    driverNameController.clear();
    driverEmailController.clear();
    driverPhoneController.clear();
    vehicleTypeController.clear();
    vehicleNumberController.clear();
    licenseController.clear();
    driverMessageController.clear();
    bannerMessage = 'Driver application submitted for admin review.';
    notifyListeners();
  }

  void login() {
    bannerMessage = 'Demo login accepted. Connect backend auth when ready.';
    notifyListeners();
  }

  void register() {
    registerNameController.clear();
    registerEmailController.clear();
    registerPhoneController.clear();
    registerPasswordController.clear();
    bannerMessage = 'Customer account created locally for this demo.';
    notifyListeners();
  }

  void trackBooking() {
    final id = int.tryParse(trackIdController.text.trim());
    final phone = trackPhoneController.text.trim();
    final matches = bookings.where((booking) {
      final idMatches = id == null || booking.id == id;
      final phoneMatches = phone.isEmpty || booking.phone.contains(phone);
      return idMatches && phoneMatches;
    }).toList();
    trackedBooking = matches.isEmpty ? null : matches.first;
    bannerMessage = trackedBooking == null
        ? 'No booking found for those details.'
        : 'Booking found.';
    notifyListeners();
  }

  @override
  void dispose() {
    for (final controller in [
      pickupController,
      dropoffController,
      nameController,
      phoneController,
      noteController,
      contactNameController,
      contactEmailController,
      contactPhoneController,
      contactSubjectController,
      contactMessageController,
      reviewNameController,
      reviewEmailController,
      reviewCommentController,
      driverNameController,
      driverEmailController,
      driverPhoneController,
      vehicleTypeController,
      vehicleNumberController,
      licenseController,
      driverMessageController,
      loginEmailController,
      loginPasswordController,
      registerNameController,
      registerEmailController,
      registerPhoneController,
      registerPasswordController,
      trackIdController,
      trackPhoneController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }
}
