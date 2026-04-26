# Grocery App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![BLoC](https://img.shields.io/badge/BLoC-4CAF50?style=flat-square&logo=bloc&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)
![Version](https://img.shields.io/badge/Version-1.0.0-blue?style=flat-square)

**A modern, feature-rich grocery shopping mobile application built with Flutter.**

[Features](#features) · [Tech Stack](#tech-stack) · [Installation](#installation) · [Folder Structure](#folder-structure) · [Contributing](#contributing) · [License](#license)

</div>

---

## Overview

Grocery App is a production-ready Flutter mobile application that provides a complete grocery shopping experience. It features a clean architecture with BLoC state management, REST API integration, secure authentication, and a polished Material 3 UI with light and dark theme support.

---

## Features

- **Home Screen** — Today's deals carousel, category browsing, and personalized recommendations
- **Product Catalog** — Categories, subcategories, and meal/product listings with search
- **Product Details** — Full product info with images, descriptions, pricing, and quantity selection
- **Smart Lists** — Create, manage, and track your grocery lists with favorites
- **Shopping Cart** — Add/remove items, quantity management (API-ready)
- **User Authentication** — Login, registration, forgot password with OTP verification
- **Profile & Settings** — User profile management with light/dark theme toggle
- **Order History** — View past orders and order details
- **Offline-Friendly** — Graceful handling with skeleton loading states
- **Dual Theme** — Full light and dark mode support using Material 3

---

## Tech Stack

| Category | Technology |
|---|---|
| **Framework** | Flutter |
| **Language** | Dart |
| **State Management** | flutter_bloc (BLoC pattern) |
| **Routing** | go_router |
| **Dependency Injection** | get_it |
| **HTTP Client** | Dio |
| **Local Storage** | shared_preferences, flutter_secure_storage |
| **Functional Utils** | fpdart |
| **UI Helpers** | flutter_screenutil, google_fonts, skeletonizer |
| **Phone Input** | flutter_intl_phone_field, intl_phone_field |
| **Architecture** | Clean Architecture (Data → Domain → Presentation) |

---

## Installation

### Prerequisites

- Flutter SDK `^3.10.1` or higher
- Dart SDK `^3.10.1` or higher
- Android Studio / Xcode (for platform builds)

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/yourusername/grocery2.git
cd grocery2

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

### Build Commands

```bash
# Debug build
flutter build apk --debug

# Release build (Android)
flutter build apk --release

# iOS build
flutter build ios --release
```

---

## Folder Structure

```
lib/
├── core/
│   ├── constants/          # App constants, API endpoints, storage keys
│   ├── di/                 # Dependency injection (get_it, service locator)
│   ├── errors/             # Failure classes and error handling
│   ├── functions/          # Utility functions (expiry calculator, etc.)
│   ├── shared_widgets/     # Reusable UI components
│   ├── theme/              # App theme (light/dark Material 3 themes)
│   └── utils/              # Validation, text styles, colors
│
├── features/
│   ├── add_new_list/       # New list creation feature
│   ├── category/           # Category browsing & listing
│   ├── Forg_pass/          # Forgot password & OTP flow
│   ├── home/               # Home screen (deals, recommendations)
│   ├── login/              # Authentication screens & logic
│   ├── on_boarding/        # Onboarding screens
│   ├── product_details/    # Product detail page
│   ├── product_list/       # Product listing
│   ├── profile&setting/    # Profile & theme settings
│   └── smart_lists/        # Smart lists (lists, favorites, history)
│
├── help_and_support/       # Help & support screens
├── shared/                 # Shared utilities across features
├── main.dart               # App entry point
└── grocery_app.dart        # App root widget (currently unused)
```

### Architecture Pattern

Each feature follows **Clean Architecture**:

```
feature/
├── data/
│   ├── models/             # Data models (JSON serialization)
│   ├── datasources/        # Remote data sources (API calls)
│   ├── logic/repo/         # Repository implementations
│   └── repo/               # Repository interfaces
├── domain/
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository contracts
│   └── usecases/          # Business logic use cases
└── presentation/
    ├── cubit/              # BLoC state management
    ├── ui/                 # Screens
    └── widgets/            # Feature-specific widgets
```

---

## Key Screens

| Screen | Description |
|---|---|
| **Splash** | App launch screen with branding |
| **Onboarding** | First-time user walkthrough |
| **Login / Register** | Email & phone authentication |
| **Home** | Deals, categories, recommendations |
| **Category** | Subcategory browsing and meal listings |
| **Product Details** | Full product view with add-to-cart |
| **Smart Lists** | User grocery lists management |
| **Profile** | Account settings and theme toggle |

---

## API Integration

The app connects to a REST API at `https://grocery.newcinderella.online/api`. Key endpoints include:

| Endpoint | Method | Description |
|---|---|---|
| `/auth/login` | POST | User login |
| `/auth/register` | POST | User registration |
| `/auth/forgot-password` | POST | Send OTP |
| `/auth/verify-otp` | POST | Verify OTP |
| `/auth/reset-password` | POST | Reset password |
| `/categories` | GET | All categories |
| `/categories/:id/meals` | GET | Meals in a subcategory |
| `/meals/today` | GET | Today's deals |
| `/favorites` | GET | User favorites |
| `/cart` | GET/POST | Shopping cart |
| `/orders` | GET | Order history |

---

## Theme

The app uses **Material 3** with a custom color scheme:

```
Primary Color: #014162 (Deep Navy Blue)
Light Background: #F5F7F7
Dark Background: #0F1720
```

Themes are fully switchable via the Profile screen using `ThemeCubit`.

---

## Contributing

Contributions are welcome! Please follow these steps:

1. **Fork** the repository
2. **Create a feature branch** (`git checkout -b feature/your-feature`)
3. **Commit your changes** (`git commit -m 'Add new feature'`)
4. **Push to the branch** (`git push origin feature/your-feature`)
5. **Open a Pull Request**

> Please ensure your code passes `flutter analyze` before submitting.

---

## Roadmap

- [ ] **Checkout Flow** — Complete purchase and payment integration
- [ ] Push Notifications — Real-time order updates
- [ ] Multi-language Support — i18n with ARB files
- [ ] Unit & Widget Tests — Comprehensive test coverage
- [ ] Performance Optimization — Lazy loading and caching
- [ ] Advanced Search — Filters, sorting, and voice search
- [ ] Apple Watch / Wear OS companion app
- [ ] Barcode Scanner — Scan products in-store
- [ ] Order Tracking — Real-time delivery status

---

## License

This project is licensed under the **MIT License**.

---

## Author

**Grocery App Team**

- GitHub: [github.com/yourusername](https://github.com/yourusername)
- Email: support@groceryapp.com

---

<div align="center">
Made with Flutter
</div>