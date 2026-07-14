# 🏥 VitalVault — AI-Powered Health Companion

> _"Your Health Records, Secured & Analyzed with AI Intelligence"_

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.24+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9+-0175C2?logo=dart)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Backend-FFCA28?logo=firebase)](https://firebase.google.com)

VitalVault is a **Flutter-based cross-platform mobile application** designed to securely manage personal and family health records. It integrates **Firebase** for authentication and real-time data handling, **Google ML Kit** for on-device OCR, and **Qwen AI (via OpenRouter)** for intelligent health document analysis and a conversational health assistant.

---

## ✨ Features

### 🔑 Core

- **Google Sign-In** — Seamless authentication powered by Firebase Auth.
- **Family Profile Management** — Create and switch between multiple family member profiles with avatar, blood type, DOB, and relationship tracking.
- **Health Dashboard** — At-a-glance view of heart rate, blood pressure, sleep, and stress with sparkline trend charts.
- **Medicine Tracker** — Track daily medications with dosage, schedule, and mark-as-taken functionality.
- **Upcoming Vaccinations** — View next vaccination appointments at a glance.

### 🤖 AI-Powered (Planned / In Progress)

- **AI Chat Assistant** — Conversational health companion powered by Qwen via OpenRouter.
- **Document Analysis** — Upload health documents for OCR extraction (ML Kit) and AI-powered report analysis.
- **Symptom Checker** — Discuss symptoms with AI (with medical disclaimers).
- **Health Insights** — Personalized health tips and record-based Q&A.

### 🔮 Roadmap

- Wearable Integration (Google Fit / Apple HealthKit)
- Emergency SOS with live location sharing
- Nearby Healthcare Facilities finder (Google Maps)
- Health News & Information Hub
- Vaccination Certificate management
- Offline-first with sync queue

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────┐
│                 FLUTTER MOBILE APP                  │
│                                                     │
│  LoginScreen → ProfileSelectionScreen → HomeScreen  │
│                                                     │
│  Components: AppBar, AppBody, GoogleSignIn,          │
│              AgreementText                          │
│  Constants:  AppColors, ScreenSizes                 │
├─────────────────────────────────────────────────────┤
│              STATE MANAGEMENT                       │
│            StreamBuilder + setState                 │
├─────────────────────────────────────────────────────┤
│              FIREBASE BACKEND                       │
│  Auth (Google Sign-In) · Firestore · Storage · FCM  │
└─────────────────────────────────────────────────────┘
```

---

## 📁 Project Structure

```
Vital-Vault/
├── lib/
│   ├── main.dart                    # App entry point & Firebase init
│   ├── loginScreen.dart             # Google Sign-In login screen
│   ├── profileSelectionScreen.dart  # Family profile manager
│   ├── homeScreen.dart              # Health dashboard with metrics
│   ├── firebase_options.dart        # Firebase configuration
│   ├── components/
│   │   ├── Appbar.dart              # Custom app bar
│   │   ├── appBody.dart             # Shared body wrapper
│   │   ├── googlesignin.dart        # Google Sign-In button & logic
│   │   └── agreementText.dart       # Terms & privacy agreement text
│   └── constants/
│       ├── appColors.dart           # App color palette
│       └── screensSizes.dart        # Responsive screen utilities
├── assets/                          # App icons and images
├── android/                         # Android platform config
├── ios/                             # iOS platform config
├── web/                             # Web platform config
├── pubspec.yaml                     # Dependencies & app metadata
├── firebase.json                    # Firebase hosting config
├── Info.txt                         # Detailed project specification
├── CHANGELOG.md                     # Release history
└── LICENSE                          # Apache 2.0
```

---

## 🛠️ Tech Stack

| Layer          | Technology                         | Purpose                            |
| -------------- | ---------------------------------- | ---------------------------------- |
| **Framework**  | Flutter 3.24+                      | Cross-platform UI                  |
| **Language**   | Dart 3.9+                          | Application logic                  |
| **Auth**       | Firebase Auth + Google Sign-In     | Authentication                     |
| **Backend**    | Firebase (Firestore, Storage, FCM) | Cloud services                     |
| **Typography** | Google Fonts (Poppins)             | Modern typography                  |
| **Charts**     | Chart Sparkline                    | Health metric visualization        |
| **AI**         | Qwen via OpenRouter                | Chat & document analysis (planned) |
| **OCR**        | Google ML Kit                      | Text extraction (planned)          |

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.24+)
- [Dart](https://dart.dev/get-dart) (3.9+)
- A Firebase project with Authentication enabled
- Google Sign-In configured for your platform

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/KhushneetSingh/Vital-Vault.git
   ```

2. **Navigate to the project directory:**

   ```bash
   cd Vital-Vault
   ```

3. **Set up environment variables:**
   Create a `.env` file in the root with your API keys:

   ```env
   OPENROUTER_API_KEY=your_key_here
   ```

4. **Install dependencies:**

   ```bash
   flutter pub get
   ```

5. **Run the app:**
   ```bash
   flutter run
   ```

> **Note:** You'll need a valid `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) from your Firebase project.

---

## 📱 Screenshots

_Coming soon — the app features a dark-themed UI with gradient backgrounds, sparkline health metrics, family profile cards, and a modern medicine tracker._

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **Apache License 2.0** — see the [LICENSE](LICENSE) file for details.

---

## 👥 Team

Built with ❤️ by the VitalVault team.

---

<p align="center">
  <b>VitalVault</b> — Your Health, Secured. 🛡️
</p>
