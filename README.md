# coffee_shop
# Android Project
## Student Information

Name: Czellecz Andrea - Julia
Student ID: 82
Course: Android Development

## Project Title
Example: CoffeeShop App

## Description
The Coffee Shop App is a modern, high-performance mobile application developed using the Flutter framework. It serves as a digital storefront where users can browse various categories of beverages (coffees, teas, drinks) and desserts. The app features a sophisticated dark-themed UI designed to provide a "premium cafe" feel, integrated with a cloud-based backend for real-time data management.

## Features
Aesthetic Welcome Screen: High-quality visual introduction with smooth navigation.

User Authentication: Secure Login and Sign-up functionality to manage personal profiles.

Dynamic Product Discovery: - Daily Specials: Automatically highlights a "Today's special offer" from the database.

Category Filtering: Easily switch between Coffees, Teas, Drinks, and Cakes.

Intelligent Search: Real-time filtering system to find products by name or description.

Favorites System: Users can save their preferred items to a personalized wishlist.

Shopping Cart Management: Add items, view totals, and manage quantities before "ordering."

Profile Management: View and edit user-specific information.

## Screenshots

![alt text](image.png)
![alt text](image-1.png)
![alt text](image-2.png)
![alt text](image-3.png)
![alt text](image-4.png)
![alt text](image-5.png)
![alt text](image-6.png)
![alt text](image-7.png)
![alt text](image-8.png)

## Technologies Used

Framework: Flutter (Dart)

Backend & Database: Firebase (Cloud Firestore & Firebase Core)

State Management: Provider

Networking: HTTP package for REST API communication

Design Tokens: Material Design 3, Poppins Typography

## Code Organization
lib/
├── constants/     # Global theme colors and style definitions
├── models/        # Data classes (Products, Users)
├── network/       # Firebase services and API client logic
├── provider/      # App-wide state management (Cart logic, User state)
├── screens/       # UI Pages (Home, Login, Favorites, Cart)
├── widgets/       # Reusable UI components (CoffeeCard, etc.)
└── main.dart      # App entry point and initialization

## How to Run
Clone the repository:
git clone [repository-url]

Install dependencies:
flutter pub get

Navigate to the backend file and run the following command:
node server.js

Then run the flutter app:
F5(Run&Debug) or just flutter run'

