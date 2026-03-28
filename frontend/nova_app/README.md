# Nova — Voice Assistant

AI-powered voice assistant. Type a message → Nova responds in speech.

## Stack
- **Frontend**: Flutter (Web, Android, iOS)
- **Backend**: Python · FastAPI · LangChain · pyttsx3

## Run

```bash
# 1. Install dependencies
flutter pub get

# 2. Start Flutter Web on port 5000
chmod +x run.sh && ./run.sh

# OR manually
flutter run -d chrome --web-port 5000
```

Make sure your FastAPI backend is running on `http://localhost:8000`.

## Structure
```
lib/
├── main.dart
├── models/          # Data models
├── providers/       # State management
├── screens/         # UI screens
├── services/        # API + TTS
├── theme/           # Colors, text styles
├── utils/           # Constants, extensions
└── widgets/         # Reusable components
```
