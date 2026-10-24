# Local setup and configuration

[Back to the README](../README.md)

## API configuration

Copy [config.example.json](../config.example.json) to `config.local.json` in the repository root and set your own development key.

```json
{
  "GEMINI_API_KEY": "your-development-key"
}
```

Run with:

```bash
flutter run -d <device-id> --dart-define-from-file=config.local.json
```

`AppConstants.geminiApiKey` reads a compile-time Dart environment value. Restart/rebuild after changing the file; setting an operating-system variable alone does not automatically populate this Dart value.

Keep `config.local.json` private. For a distributed app, put authenticated API access behind a backend; build-time values can be recovered from client artifacts.

## Model and request settings

[app_constants.dart](../lib/config/app_constants.dart) defines the API base URL, model name, 30-second timeout, temperature, and output-token limit. [GeminiService](../lib/services/gemini_service.dart) posts to the model's `generateContent` endpoint.

The selected model is a source configuration value, not a guarantee of availability. Check your provider account and model access if requests fail.

## Devices and images

Start with a mobile device/emulator that supports the image-picker flow. Review platform camera/photo-library permissions before testing image uploads. The current image service reads local files with `dart:io`, so a browser launch does not establish working image support.

Use sample images with no personal or patient information. The service can send both prompt text and image bytes to Gemini.

## Troubleshooting

| Symptom | What to check |
| --- | --- |
| API key missing | Local JSON has `GEMINI_API_KEY` and the launch command includes `--dart-define-from-file` |
| HTTP 403 / invalid key | Your key, project permissions, API restrictions, and account access |
| Model unavailable | Model configuration and provider availability |
| Request times out | Network access, API response time, and the configured timeout |
| Unexpected result formatting | Model response structure and the assumptions in `response_parser.dart` |
| Image selection fails | Platform support and camera/gallery permissions |
| Widget tests fail to compile | Existing test still imports `package:skin_treatment/main.dart` and uses `MyApp` |

## Development checks

Run `flutter analyze` to inspect source diagnostics. The repository's inherited widget test is not a valid app smoke test yet. When replacing it, mock network responses and verify navigation, loading, errors, and parsing without making live Gemini calls.

If a key was previously committed, rotate or revoke it at the provider. Removing the literal from the latest source does not remove its Git history.
