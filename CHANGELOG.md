# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2026-05-25

### Changed
- Updated `README.md` to accurately reflect the current state of implemented vs. planned features.
- Marked core features (Google Sign-In, Family Profiles, Health Dashboard, Medicine Tracker, Vaccinations) as **Implemented**.
- Clarified AI-powered features (Chat Assistant, Document Analysis, Symptom Checker, Health Insights) as **Planned**.
- Removed misleading `.env` setup step from installation instructions (OpenRouter not yet integrated).
- Updated project structure to accurately label `backend/` and `frontend/` directories as planned.
- Fixed stray CDATA XML wrapper in README markup.

## [1.1.0] - 2026-05-20

### Changed
- Overhauled `README.md` with comprehensive project documentation, architecture overview, tech stack, project structure, setup instructions, and contributing guidelines.
- Updated `CHANGELOG.md` to follow Keep a Changelog format with detailed release notes.

## [1.0.0] - 2026-05-16

### Added
- **Authentication**: Firebase Auth with Google Sign-In integration for secure access.
- **Login Screen**: Branded login page with Google Sign-In button, email sign-in option, and terms/privacy agreement text.
- **Family Profile Management**: Multi-user profile system with avatar, blood type, date of birth, and relationship tracking. Includes add-profile dialog.
- **Health Dashboard**: Home screen with personalized greeting, health metric cards (Heart Rate, Blood Pressure, Sleep, Stress) with sparkline trend charts.
- **Medicine Tracker**: Daily medication list with dosage, scheduled times, due status highlighting, and mark-as-taken checkboxes.
- **Upcoming Vaccinations**: Vaccination appointment card on the dashboard.
- **Reusable Components**: Custom AppBar, AppBody wrapper, Google Sign-In button, and Agreement Text components.
- **Design System**: Centralized color palette (`AppColors`) and responsive screen utilities (`ScreenSizes`). Dark-themed UI with Poppins typography via Google Fonts.
- **Firebase Configuration**: Firebase Core initialization with platform-specific options.
- **Project Configuration**: `.gitignore` for Flutter and Python environments, Apache 2.0 license, launcher icon setup.
