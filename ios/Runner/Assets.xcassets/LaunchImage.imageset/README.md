# Grocery App

## Overview

This is a Flutter-based grocery application designed to provide a seamless shopping experience. It features a dynamic category browsing system, product listings with subcategory filtering, and a robust authentication flow. The app leverages BLoC/Cubit for state management, Dio for network requests, and GetIt for dependency injection to ensure a clean, scalable, and maintainable architecture.

## Key Features

-   **Splash Screen with Authentication Check**: Smooth app startup with automatic redirection based on user login status.
-   **User Authentication**: Secure login, signup, and forgot password functionalities.
-   **Category Browsing**: Explore main product categories with associated meal/product listings.
-   **Product Listing with Subcategory Filtering**: View products organized by subcategories, dynamically filtered based on the selected main category.
-   **Product Details**: (Implied) Detailed view for individual products.
-   **Cart Management**: (Implied) Add products to cart.
-   **Dependency Injection**: Using GetIt for efficient service location.
-   **State Management**: Implemented with Flutter BLoC/Cubit for predictable state handling.
-   **Networking**: Handled by Dio with custom interceptors for authentication and logging.

## Architecture

The application follows a modular architecture, separating concerns into `features` and `core` modules.

-   **`core`**: Contains shared components like constants (API, colors, sizes), utility functions, dependency injection setup, and network helpers.
-   **`features`**: Each major functionality (e.g., `splash`, `category`, `product_list`, `auth`) is encapsulated within its own feature module, promoting reusability and maintainability.

## Core Application Flow

Here's a detailed breakdown of the main user journey:

### 1. Application Startup

-   `main.dart` initializes essential services (`PreferenceManager`, `DioHelper`, `GetIt`).
-   The app starts with `SplashScreen`.

### 2. Splash Screen & Authentication

-   `SplashScreen` displays an animation.
-   Upon animation completion, it checks `PreferenceManager` for the user's login status (`isLoggedIn`).
-   **If `isLoggedIn` is `true`**: Navigates to `HomeView`.
-   **If `isLoggedIn` is `false`**: Navigates to `FirstBoard` (Onboarding), which then leads to `LoginScreen` or `SignupScreen`.

### 3. Navigating to Categories (from `HomeView`)

-   (Assumed) From the `HomeView`, the user can navigate to the `CategoryScreen`.

### 4. Category Screen (`category_screen.dart`)

-   Displays main product categories horizontally (`SubCategoriesHorizontalList`).
-   Uses `CategoryCubit` to fetch main categories and their initial associated "meals" (products).
-   When a main category is selected, `CategoryCubit` fetches and updates the list of "meals" for that category.
-   These "meals" are displayed vertically using `CategoryMealListItem`.

### 5. Navigating to Product List Screen

-   Tapping on a `CategoryMealListItem` in `CategoryScreen` triggers navigation to `ProductListScreen`.
-   **Crucially, the `categoryId` of the *currently selected main category* is passed to `ProductListScreen`**. This links the product list to the parent category.

### 6. Product List Screen (`product_list_screen.dart`)

-   Receives the `categoryId` from `CategoryScreen`.
-   Initializes `ProductListCubit` with this `categoryId`.
-   Displays a horizontal list of subcategories (`SubcategoryHorizontalList`).
-   Displays a grid of products (`ProductItemWidget`).

### 7. Product List Cubit (`product_list_cubit.dart`) Logic

-   **`_fetchSubcategories()`**:
    -   Fetches *all* available subcategories.
    -   **Filters these subcategories** to show only those belonging to the `categoryId` received from `CategoryScreen` (using `s.category?.id == _initialCategoryId`).
    -   Automatically selects the first relevant subcategory and fetches its associated meals.
-   **`selectSubcategory(int id)`**:
    -   Updates the selected subcategory.
    -   Triggers `getMeals()` to fetch products specifically for the newly selected subcategory.
-   **`getMeals()`**: Fetches products for the currently selected subcategory, handling pagination.

### 8. Subcategory Horizontal List (`subcategory_horizontal_list.dart`) Logic

-   Receives the `categoryId` from `ProductListScreen`.
-   **Filters the subcategories** it displays to only show those that match the received `categoryId`, ensuring only relevant subcategories are visible.
-   Tapping a subcategory calls `ProductListCubit.selectSubcategory()`, updating the product grid.