import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AudioService {
  AudioService._();

  static final FlutterTts _tts = FlutterTts();
  static final ValueNotifier<String?> speakingText = ValueNotifier<String?>(
    null,
  );
  static bool _isInitialized = false;
  static bool _isAvailable = true;

  static Future<void> initialize() async {
    if (_isInitialized || !_isAvailable) return;
    _isInitialized = true;
    try {
      final locale = await _configureGermanVoice();
      await _tts.setLanguage(locale);
      await _tts.setVolume(1.0);
      await _tts.setPitch(_defaultPitch);
      await _tts.setSpeechRate(_defaultSpeechRate);
      await _tts.awaitSpeakCompletion(true);

      _tts.setCompletionHandler(() {
        speakingText.value = null;
      });
      _tts.setCancelHandler(() {
        speakingText.value = null;
      });
      _tts.setErrorHandler((_) {
        speakingText.value = null;
      });
    } on MissingPluginException {
      _isAvailable = false;
      _isInitialized = false;
      speakingText.value = null;
    } on PlatformException {
      _isAvailable = false;
      _isInitialized = false;
      speakingText.value = null;
    }
  }

  static double get _defaultSpeechRate {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return 0.40;
      case TargetPlatform.android:
        return 0.44;
      default:
        return 0.42;
    }
  }

  static double get _defaultPitch {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return 0.96;
      case TargetPlatform.android:
        return 0.98;
      default:
        return 0.97;
    }
  }

  static Future<String> _configureGermanVoice() async {
    const fallbackLocale = 'de-DE';

    try {
      final voices = await _tts.getVoices;
      if (voices is! List) return fallbackLocale;

      Map<String, String>? bestVoice;
      var bestScore = -1;

      for (final voice in voices) {
        final normalized = _normalizeVoice(voice);
        if (normalized == null) continue;

        final score = _voiceScore(normalized);
        if (score > bestScore) {
          bestScore = score;
          bestVoice = normalized;
        }
      }

      if (bestVoice == null) return fallbackLocale;

      final selectedName = bestVoice['name'];
      final selectedLocale = bestVoice['locale'] ?? fallbackLocale;
      if (selectedName != null && selectedName.isNotEmpty) {
        await _tts.setVoice({
          'name': selectedName,
          'locale': selectedLocale,
        });
      }
      return selectedLocale;
    } on PlatformException {
      return fallbackLocale;
    }
  }

  static Map<String, String>? _normalizeVoice(dynamic voice) {
    if (voice is! Map) return null;

    final normalized = <String, String>{};
    for (final entry in voice.entries) {
      final key = entry.key.toString();
      final value = entry.value?.toString();
      if (value == null || value.isEmpty) continue;
      normalized[key] = value;
    }

    final locale = normalized['locale'] ??
        normalized['language'] ??
        normalized['lang'] ??
        normalized['identifier'];
    if (locale == null) return null;

    final lowerLocale = locale.toLowerCase();
    if (!lowerLocale.startsWith('de')) return null;

    normalized['locale'] = locale;
    return normalized;
  }

  static int _voiceScore(Map<String, String> voice) {
    final locale = (voice['locale'] ?? '').toLowerCase();
    final name = (voice['name'] ?? '').toLowerCase();
    final identifier = (voice['identifier'] ?? '').toLowerCase();

    var score = 0;
    if (locale == 'de-de') score += 50;
    if (locale.startsWith('de')) score += 20;

    for (final token in const [
      'premium',
      'enhanced',
      'natural',
      'siri',
      'wavenet',
      'neural',
    ]) {
      if (name.contains(token) || identifier.contains(token)) {
        score += 15;
      }
    }

    if (name.contains('female') || identifier.contains('female')) {
      score += 2;
    }

    return score;
  }

  static Future<void> speakGerman(String text) async {
    await initialize();
    if (!_isAvailable) return;
    if (speakingText.value == text) {
      await stop();
      return;
    }
    try {
      await _tts.stop();
      speakingText.value = text;
      await _tts.speak(text);
    } on MissingPluginException {
      _isAvailable = false;
      speakingText.value = null;
    } on PlatformException {
      _isAvailable = false;
      speakingText.value = null;
    }
  }

  static Future<void> stop() async {
    if (!_isAvailable) {
      speakingText.value = null;
      return;
    }
    try {
      await _tts.stop();
    } on MissingPluginException {
      _isAvailable = false;
    } on PlatformException {
      _isAvailable = false;
    }
    speakingText.value = null;
  }
}
