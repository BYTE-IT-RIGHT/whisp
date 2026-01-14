<p align="center">
  <img src="assets/images/png/play_store_512.png" width="120" height="120" alt="Whisp Logo"/>
</p>

<h1 align="center">Whisp</h1>

<p align="center">
  <strong>Serverless • End-to-End Encrypted • Anonymous</strong>
</p>

<p align="center">
  A privacy-first messenger that routes all traffic through the TOR network.<br/>
  No servers. No metadata. No compromise.
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#how-it-works">How It Works</a> •
  <a href="#architecture">Architecture</a> •
  <a href="#getting-started">Getting Started</a> •
  <a href="#contributing">Contributing</a> •
  <a href="#license">License</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.10+-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-3.10+-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/Platform-Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android"/>
  <img src="https://img.shields.io/badge/License-Source%20Available-red?style=for-the-badge" alt="License"/>
</p>

---

## 🛡️ Why Whisp?

In a world where every message you send passes through corporate servers that mine your data, **Whisp** takes a different approach:

- **🚫 No Central Servers** — Messages travel directly between devices using TOR hidden services
- **🔑 Signal Protocol Encryption** — The same battle-tested encryption used by Signal, now over TOR
- **👻 True Anonymity** — Your IP address is never exposed; communication happens via `.onion` addresses
- **📱 Local-First** — All data stays on your device, encrypted at rest

---

## ✨ Features

### 🔒 Privacy & Security
- **End-to-End Encryption** via Signal Protocol (Double Ratchet Algorithm)
- **TOR Hidden Services** for all network communication
- **No Server Infrastructure** — Peer-to-peer architecture
- **Encrypted Local Storage** with Hive & Flutter Secure Storage
- **Biometric & PIN Authentication**

### 💬 Messaging
- Real-time messaging over TOR
- Message history with pagination
- Contact management system
- Invitation system with accept/decline flow

### 📲 Contact Sharing
- **QR Code Generation** — Share your address instantly
- **QR Code Scanner** — Add contacts by scanning
- **Manual Entry** — Paste onion addresses directly
- **Share via Apps** — Send invites through other apps

### 🎨 User Experience
- Light & Dark theme support
- Custom avatar selection
- Interactive onboarding & tutorial
- Background message reception via Foreground Service
- Push notifications for incoming messages

---

## 🔬 How It Works

```
┌─────────────┐                                    ┌─────────────┐
│   Alice     │                                    │     Bob     │
│  (Device)   │                                    │  (Device)   │
├─────────────┤                                    ├─────────────┤
│ Signal Keys │                                    │ Signal Keys │
│ TOR Service │──────────┐          ┌──────────────│ TOR Service │
└─────────────┘          │          │              └─────────────┘
                         ▼          ▼
               ┌─────────────────────────────┐
               │        TOR Network          │
               │  (Onion Routing / Hidden    │
               │      Services / .onion)     │
               └─────────────────────────────┘
```

### The Flow

1. **Identity Creation** — On first launch, Whisp generates Signal Protocol keys and starts a TOR hidden service
2. **Address Exchange** — Users share their `.onion` addresses via QR codes or text
3. **Session Establishment** — Signal Protocol PreKey bundles are exchanged to establish encrypted sessions
4. **Secure Messaging** — All messages are encrypted with Signal Protocol and routed through TOR

### No Metadata Leaks

Unlike traditional messengers:
- ❌ No phone number required
- ❌ No email required  
- ❌ No server logs
- ❌ No IP address exposure
- ✅ Only encrypted payloads over anonymous routing

---

## 🏗️ Architecture

Whisp follows **Clean Architecture** principles with a feature-based modular structure:

```
lib/
├── add_contact/          # Contact addition feature
│   ├── application/      # BLoC/Cubit state management
│   ├── domain/           # Interfaces & entities
│   ├── infrastructure/   # Implementations
│   └── presentation/     # UI components
├── authentication/       # Auth domain models
├── chat/                 # Chat feature
├── common/
│   └── constants/
│       └── app_flavor.dart  # Build flavor detection (googleplay/foss)
├── conversations_library/# Conversation list
├── encryption/           # Signal Protocol integration
│   ├── domain/           # ISignalService interface
│   └── infrastructure/   # Signal implementation
├── invitation/           # Contact request handling
├── local_storage/        # Hive & Drift repositories
├── messaging/            # Message handling
├── TOR/                  # TOR hidden service integration
│   ├── domain/           # ITorRepository interface
│   └── infrastructure/   # TOR implementation
├── di/                   # Dependency injection (get_it)
├── navigation/           # Auto Route navigation
├── notifications/        # Push notifications
├── theme/                # Theming system
└── main.dart
```

### Key Technologies

| Layer | Technology |
|-------|------------|
| **State Management** | flutter_bloc (Cubit) |
| **Dependency Injection** | get_it + injectable |
| **Navigation** | auto_route |
| **Local Database** | Drift (SQLite) + Hive |
| **Secure Storage** | flutter_secure_storage |
| **Encryption** | libsignal_protocol_dart |
| **Network** | tor_hidden_service |
| **Functional Programming** | dartz |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `^3.10.4`
- Android SDK (API 21+)
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/BYTE-IT-RIGHT/whisp.git
cd whisp

# Install dependencies
flutter pub get

# Generate code (required for injectable, auto_route, drift, hive)
dart run build_runner build --delete-conflicting-outputs

# Run the app (no additional setup needed!)
flutter run --flavor fosspublic --dart-define=APP_FLAVOR=foss
```

That's it! The public signing key is included in the repository, so you can build immediately.

### Build Flavors

Whisp supports three distribution flavors:

| Flavor | Purpose | Signing | Application ID |
|--------|---------|---------|----------------|
| `googleplay` | Google Play Store | Release key (private) | `pl.byteitright.whisp` |
| `foss` | Official FOSS releases | FOSS key (private) | `pl.byteitright.whisp.foss` |
| `fosspublic` | Developer/contributor builds | Public key (in repo) | `pl.byteitright.whisp.foss` |

> **For contributors:** Use `fosspublic` flavor - it works out of the box!

### Build for Release

```bash
# Google Play — App Bundle (for Play Store upload)
flutter build appbundle --flavor googleplay --release --dart-define=APP_FLAVOR=googleplay

# FOSS — Signed APK (for GitHub Releases, ready to install)
flutter build apk --flavor foss --release --dart-define=APP_FLAVOR=foss
```

### Verify FOSS Build

Each GitHub Release includes:

| File | Purpose |
|------|---------|
| `whisp-foss-X.X.X.apk` | Signed APK (ready to install) |
| `whisp-foss-X.X.X-unsigned.apk` | Unsigned APK (for build verification) |
| `SHA256SUMS.txt` | Checksums for all files |

#### Option 1: Verify Signature Fingerprint

Check the APK is signed with the official FOSS key:

```bash
keytool -printcert -jarfile whisp-foss-X.X.X.apk
```

Compare with the official fingerprint:
```
SHA-256: XX:XX:XX:... (published in releases)
```

#### Option 2: Reproducible Build Verification

Build from source and compare with the published unsigned APK:

```bash
# Build from source
flutter build apk --flavor foss --release --dart-define=APP_FLAVOR=foss

# Unsigned APK location (before signing):
# build/app/intermediates/apk/foss/release/app-foss-release-unsigned.apk

# Compare hash of your unsigned build with published unsigned APK
certutil -hashfile build\app\intermediates\apk\foss\release\app-foss-release-unsigned.apk SHA256
```

If hashes match, the published APK contains exactly the same code as the source.

> **Note:** For fully reproducible builds, ensure you use the same Flutter SDK version, Dart version, and build environment as specified in the release notes.

---

## 📁 Project Structure

```
whisp/
├── android/              # Android native code & config
├── assets/
│   └── images/           # App icons & images
├── lib/                  # Dart source code
├── test/                 # Unit & widget tests
├── pubspec.yaml          # Dependencies
├── analysis_options.yaml # Linter rules
└── README.md
```

---

## 🔐 Security Model

### Encryption Layers

1. **Transport Layer** — TOR hidden services (onion routing)
2. **Application Layer** — Signal Protocol (end-to-end encryption)
3. **Storage Layer** — Encrypted local database

### Signal Protocol Implementation

Whisp implements the full Signal Protocol including:

- **X3DH** (Extended Triple Diffie-Hellman) for key agreement
- **Double Ratchet Algorithm** for forward secrecy
- **PreKey Bundles** for asynchronous session establishment

### Threat Model

| Threat | Mitigation |
|--------|------------|
| Server compromise | No servers to compromise |
| Network surveillance | TOR onion routing |
| Message interception | Signal Protocol encryption |
| Device seizure | Encrypted local storage + PIN/biometrics (soon) |
| Metadata analysis | No central server = no metadata collection |

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### Development Setup

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Run tests: `flutter test`
5. Commit: `git commit -m 'Add amazing feature'`
6. Push: `git push origin feature/amazing-feature`
7. Open a Pull Request

### Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use the provided `analysis_options.yaml`
- Write tests for new features
- Keep commits atomic and well-described

### Areas for Contribution

- [ ] Desktop support (Windows, macOS, Linux)
- [ ] Group messaging
- [ ] File/media sharing
- [ ] Message reactions
- [ ] Voice messages
- [ ] UI/UX improvements
- [ ] Documentation

---

## 📋 Roadmap

- [x] TOR hidden service integration
- [x] Signal Protocol encryption
- [x] Contact management via QR codes
- [x] Real-time messaging
- [x] Local encrypted storage
- [x] Build flavors (Google Play & FOSS)
- [ ] Biometric authentication
- [ ] Mailboxes (offline messaging)
- [ ] Group conversations
- [ ] Media sharing (images, files)
- [ ] Message deletion & expiration
- [ ] Multi-device support
- [ ] Desktop clients

---

## 📜 License

This project is licensed under the **Whisp Source-Available License**.

**You CAN:**
- ✅ View and study the source code
- ✅ Use the app for personal, non-commercial purposes
- ✅ Fork and submit pull requests (contributions)

**You CANNOT:**
- ❌ Modify the code for your own use (only contributions via PRs)
- ❌ Distribute modified versions
- ❌ Use the software commercially or make money from it
- ❌ Sublicense or sell the software

Only the original author (BYTE-IT-RIGHT) retains the right to modify, distribute, and commercialize this software.

See the [LICENSE](LICENSE) file for full details.

---

## ⚠️ Disclaimer

Whisp is provided as-is for educational and privacy-focused communication purposes. While we implement industry-standard security practices, no software can guarantee absolute security. Users are responsible for their own operational security.

---

## 🙏 Acknowledgments

- [Signal Protocol](https://signal.org/docs/) — For the encryption protocol
- [TOR Project](https://www.torproject.org/) — For anonymous communication
- [Flutter](https://flutter.dev/) — For the amazing cross-platform framework
- The open-source community for the incredible packages that make this possible

---

<p align="center">
  <strong>Built with 💜 for privacy</strong>
</p>

<p align="center">
  <sub>If you believe privacy is a fundamental right, give this project a ⭐</sub>
</p>
