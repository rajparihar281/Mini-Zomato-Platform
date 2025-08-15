# Mini Zomato Platform - Flutter (BLoC-based)

## Project Overview

This project is a multi-application food delivery system built with **Flutter 3.x** and the **BLoC (Business Logic Component)** pattern for state management. It demonstrates a modular, scalable architecture by dividing the platform into three distinct, interconnected applications:

* **Restaurant App**: For managing the restaurant's menu, viewing incoming orders, and controlling order statuses.
* **Delivery Partner App**: For delivery personnel to view assigned tasks and update delivery statuses.
* **User App**: A basic application for customers to browse and place food orders.

The codebase is organized to promote a clear separation of concerns, making it easy to maintain and expand.

## BLoC Architecture Overview

The core of this project's architecture is the BLoC pattern. Each major feature in the applications is managed by its own BLoC, which handles the business logic independently from the UI. This ensures a predictable state flow and robust, testable code.

The BLoC-based structure adheres to the following principles:

* **Events**: User actions or external triggers are represented as `Events`.
* **BLoCs**: The BLoC processes these events and contains the business logic.
* **States**: The BLoC emits `States` that the UI listens to in order to rebuild itself.

Each app's folder structure is consistent, with dedicated directories for `bloc`, `models`, `presentation`, and `data` to ensure a clean and organized project.

## Setup and Run Instructions

Follow these steps to set up and run the applications on your local machine.

### Prerequisites

* **Flutter SDK**: Version `3.32.8` or higher installed.
* **Git**: Version `2.45.1` or higher installed.

### Step 1: Clone the Repository

Clone the project from GitHub to your local machine.

```bash
git clone [https://github.com/rajparihar281/Mini-Zomato-Platform.git](https://github.com/rajparihar281/Mini-Zomato-Platform.git)
cd Mini-Zomato-Platform
Step 2: Install Dependencies
Navigate into each app's directory and install the necessary dependencies.

Restaurant App

Bash

cd restaurant_app
flutter pub get
Delivery Partner App

Bash

cd delivery_partner_app
flutter pub get
User App

Bash

cd user_app
flutter pub get
Step 3: Run the Applications
You can run each application from its respective folder.

Restaurant App

Bash

cd restaurant_app
flutter run
Login Credentials: test@restaurant.com / password123

Delivery Partner App

Bash

cd delivery_partner_app
flutter run
Login Credentials: delivery@partner.com / delivery123

User App

Bash

cd user_app
flutter run
Login Credentials: test@test.com / password
