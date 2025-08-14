# login

A new Flutter project.

## Getting Started

## Project Setup

This project requires both **Firebase** and **Supabase** configuration files and keys, which are **not included** in this repository for security reasons.

---

### 1️⃣ Firebase Setup
You need to provide your own Firebase configuration files:

- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

#### How to get them:
1. Go to [Firebase Console](https://console.firebase.google.com/).
2. Select your project.
3. Navigate to **Project settings**.
4. Scroll down to **Your apps** and select Android/iOS.
5. Download the required config file and place it in the correct folder in your Flutter project.

---

### 2️⃣ Supabase Setup
You also need your own Supabase **Project URL** and **Anon/Public API Key**.

In your code, replace:

```dart
await Supabase.initialize(
  // TODO: Replace with your own Supabase project URL
  url: 'https://YOUR_PROJECT_URL.supabase.co',

  // TODO: Replace with your own Supabase anon/public API key
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
);
How to get them:
Go to Supabase.

Select your project.

Navigate to Project Settings → API.

Copy the Project URL and anon/public API key.


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
