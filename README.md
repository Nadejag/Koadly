# Koadly

Flutter mobile app for Koadly Associates taxi, airport transfer, city ride, business travel, and hourly booking services.

## Architecture

The app now follows a lightweight MVVM structure:

- `models/` contains the immutable app models such as bookings, reviews, services, and page definitions.
- `viewmodels/` owns screen state, navigation, local form submission, quote calculation, tracking, and demo data mutations.
- `views/screens/` contains one frontend screen per website section.
- `views/widgets/` contains shared branded UI widgets.
- `data/` contains local seed content used until backend APIs are connected.

## What is included

- Android and iOS Flutter app shell
- Home, Book Now, Trips, Services, Reviews, About, Drive With Us, Contact, Track Booking, FAQ, Profile/Login, Privacy and Terms screens
- Mobile booking form with pickup, drop-off, date, time, phone, name, service type, notes, and route preview
- Live local quote preview using the published service rates
- Local working frontend actions for booking submission, review submission, contact message, driver application, login/register demo, and booking tracking
- Koadly orange/black visual style inspired by the existing website

## Run locally

```sh
flutter pub get
flutter run
```

## Test

```sh
flutter test
```

## Build

```sh
flutter build apk
flutter build ios
```

The current app uses local mock quote calculations. Connect the booking button to the production API when backend endpoints are ready.
# Koadly
