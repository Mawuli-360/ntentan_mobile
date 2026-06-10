# Ntentan — Health Track App for Accessibility

Ntentan is an advanced, accessibility-focused health tracking application built with **Flutter**. It is engineered from the ground up to empower visually impaired users and provide seamless health monitoring through a combination of voice assistance, camera-based readers, and real-time dashboard analytics. 

This repository stands as a testament to scalable, maintainable, and highly modular software design principles, crafted specifically for the complexities of a modern cross-platform application.

---

## 🏗 Architecture Overview

Ntentan employs a **Feature-First Clean Architecture**. This architectural choice ensures that the codebase remains highly cohesive and loosely coupled. By slicing the app into independent feature modules and layering the responsibilities within those modules, the app achieves maximum scalability and ease of testing.

### The "Feature-First" Paradigm
Instead of grouping files by their technical type (e.g., all models in one folder, all controllers in another), Ntentan groups files by their **business domain** (e.g., `auth`, `dashboard`, `visually_impaired`). This ensures that developers can work on a specific feature without jumping across the entire codebase.

### Layered Approach (Clean Architecture)
Inside every feature, the code is meticulously separated into layers:
- **Domain Layer**: The heart of the business logic. Contains pure Dart code, including Entities, Repositories (Interfaces), and UseCases. It has zero dependencies on UI or external frameworks.
- **Data Layer**: Responsible for interacting with the outside world. It includes Repository Implementations, Data Sources (Remote APIs, Local SQLite), and Data Transfer Objects (DTOs).
- **Presentation Layer**: Houses the UI and State Management. It uses Controllers (Provider/Notifier patterns) to interact with the Domain Layer and present data via Flutter Widgets.

---

## 📂 Codebase Structure

The `lib/` directory is logically divided into core components and distinct feature modules.

```text
lib/
├── core/                   # The backbone of the application (Shared across all features)
│   ├── api/                # API configurations and interceptors
│   ├── app_route/          # Global navigation routing (GoRouter)
│   ├── constants/          # App-wide constants (Keys, Strings, Dimensions)
│   ├── db/                 # Local database configurations (Drift SQLite)
│   ├── exception/          # Centralized error handling and custom exceptions
│   ├── network/            # HTTP clients (Dio), WebSockets
│   ├── theme/              # Design System, Colors, and Typography
│   └── widgets/            # Highly reusable atomic UI components
│
├── features/               # Independent feature modules
│   ├── auth/               # User Authentication & Authorization
│   ├── dashboard/          # Health tracking overview & analytics
│   ├── emergency/          # SOS and Emergency contact handling
│   ├── onboarding/         # User setup and language preference
│   ├── settings/           # User configuration and app preferences
│   └── visually_impaired/  # Specialized accessibility tools
│       ├── camera_reader/  # Medication/Document scanning capabilities
│       └── voice_assistant/# Voice-driven interactions and TTS
│
├── shared/                 # Utilities and extensions shared selectively
├── flavors.dart            # Environment configuration (Dev, Staging, Prod)
└── main.dart               # Application entry point and bootstrapping
```

---

## 🛠 Tech Stack & Engineering Choices

Every library and tool in Ntentan was carefully selected to solve specific engineering challenges efficiently.

### 1. State Management & Reactivity
- **Provider**: Used for predictable and reactive UI state management.
- **Freezed**: Ensures state immutability, enabling safe state transitions and eliminating hard-to-track mutation bugs.
- **FpDart**: Embraces Functional Programming paradigms. Functions return `Either<Failure, Success>`, forcing the presentation layer to handle potential errors gracefully rather than relying on unpredictable `try-catch` blocks.

### 2. Dependency Injection
- **GetIt**: Operates as our Service Locator. Each feature is responsible for its own dependency registration (e.g., `auth_injection.dart`). This decoupled approach ensures that dependencies are lazy-loaded when the feature is accessed, reducing the app's startup footprint.

### 3. Navigation
- **GoRouter**: A robust, declarative routing solution. It handles deep linking, guards (e.g., redirecting unauthenticated users from the dashboard), and nested navigation effortlessly.

### 4. Local Persistence
- **Drift**: A reactive, type-safe SQLite persistence library. It provides offline-first capabilities, ensuring the app remains fully functional in poor network conditions.
- **Flutter Secure Storage**: Encrypts sensitive data (like authentication tokens) using the platform's native keychain mechanisms.

### 5. Networking
- **Dio**: A powerful HTTP client used for its interception capabilities (ideal for token refreshing and global logging).
- **Socket.io / WebSockets**: Powers real-time telemetry and immediate emergency signaling.

### 6. Accessibility & Hardware Integration
- **Camera & ML Vision**: Integrated for medication scanning to aid visually impaired users.
- **Flutter TTS & Audio**: Provides native text-to-speech feedback and plays localized audio cues (via `audioplayers` and `audio_waveforms`).
- **Haptic Feedback**: Utilizes device vibration patterns (`vibration`) to communicate system states non-visually.

---

## 🗺 User Flow & Experience

Ntentan is designed to offer a frictionless, highly accessible journey tailored to individual user needs.

### 1. Onboarding & Personalization
- **Language Selection:** Users choose their preferred language (e.g., English or Twi).

### 2. Authentication & Profile
- **Secure Access:** Users can sign up or log in securely using Email/Password or Google SSO.
- **Profile Setup:** Initial collection of basic profile information and emergency contacts to personalize the experience.

### 3. Dashboard (The Hub)
- **Overview:** Serves as the central hub presenting vital health metrics and upcoming medication reminders.
- **Quick Actions:** Easy access to core features like the Voice Assistant, Scanner, and Settings.

### 4. Specialized Accessibility Features
- **Voice Assistant:** An accessible conversational AI interface. Users can record and send audio queries, and the backend AI processes the audio and responds. The app then reads the response aloud using native Text-to-Speech (TTS) or plays the server-provided audio directly.
- **Medication Scanner:** Integrates the device's camera with real-time sockets and ML vision to read medication labels aloud, assisting with safe dosage management.

### 5. Emergency (SOS) Flow
- **Activation:** Can be triggered via a dedicated button, voice command, or specific gesture.
- **Process:** Initiates a brief countdown (to prevent false alarms). If not canceled, it automatically shares the user's GPS location and critical medical info with predefined emergency contacts.
- **Post-Emergency:** Provides a clear path to confirm safety and return the app to a normal state.

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`^3.6.1`)
- IDE (VSCode or Android Studio) with Flutter extensions.
- Properly configured Android SDK / iOS Xcode environments.

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Mawuli-360/ntentan_mobile.git
   cd ntentan
   ```

2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Code Generation:**
   Because we rely heavily on Freezed, Drift, and JSON Serializable, you must generate the boilerplate code before compiling:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Environment Setup:**
   Ensure you have the required `.env` configuration file at the root.

5. **Run the Application:**
   ```bash
   flutter run
   ```

---

## 🧪 Testing Strategy

Ntentan is built with a robust, fully-covered test suite emphasizing reliability across all architectural layers. We utilize `mocktail` for dependency mocking and `flutter_test` for execution.

- **Presentation Layer (State Management):** Extensive unit tests cover every Controller. Tests validate precise state transitions (e.g., `Idle` -> `Loading` -> `Success`), error handling logic, and `SessionLifecycle` orchestration without the overhead of spinning up the widget tree.
- **Data Layer:** Repository implementations are thoroughly tested by mocking underlying data sources (Firebase, Drift, HTTP APIs, WebSockets). This ensures accurate data parsing, DTO conversions, and robust `Either<Failure, Success>` functional error mapping.
- **Domain Layer:** Because the domain layer consists of 100% pure Dart logic, business rules and entities are isolated and easily testable independently of any Flutter or external dependencies.

To run the entire test suite:
```bash
flutter test
```

---


