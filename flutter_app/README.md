# flutter_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Environment Setup

To keep sensitive information like API keys and configuration out of the repository, this project uses environment variables.

1. Copy the `.env.example` file to `.env`:
   ```
   cp .env.example .env
   ```

2. Fill in the actual values in `.env` with your secrets (e.g., API keys, Firebase config, etc.).

3. Ensure `.env` is never committed to the repository (it is already in `.gitignore`).

### Required Environment Variables

- `API_BASE_URL`: The base URL for your backend API (default: `http://10.0.2.2:8080/api` for Android emulator).
- Add other secrets as needed based on your implementation.

### Firebase Setup

- Place your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) in the respective platform directories.
- These files are ignored by `.gitignore` to prevent accidental commits.

### Running the App

After setting up the environment:

```bash
flutter pub get
flutter run
```
