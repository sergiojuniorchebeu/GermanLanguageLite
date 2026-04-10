import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class SfxService {
  SfxService._();

  static final AudioPlayer _player = AudioPlayer()
    ..setReleaseMode(ReleaseMode.stop);

  static bool _isAvailable = true;

  static Future<void> _play(String fileName, {double volume = 0.75}) async {
    if (!_isAvailable) return;
    try {
      await _player.stop();
      await _player.setVolume(volume);
      await _player.play(AssetSource('audio/$fileName'));
    } on MissingPluginException {
      _isAvailable = false;
    } on PlatformException {
      _isAvailable = false;
    }
  }

  static Future<void> playQuizSuccess() async {
    await _play('success-chime.mp3', volume: 0.75);
  }

  static Future<void> playQuizFail() async {
    await _play('error-soft.mp3', volume: 0.65);
  }

  static Future<void> playFlashcardFlip() async {
    await _play('card-flip.mp3', volume: 0.55);
  }

  static Future<void> playSoftTap() async {
    await _play('softclick.mp3', volume: 0.45);
  }

  static Future<void> playXpGain() async {
    await _play('reward-sparkle.mp3', volume: 0.70);
  }

  static Future<void> playBadgeUnlock() async {
    await _play('achievement-unlock.mp3', volume: 0.75);
  }

  static Future<void> playLevelUp() async {
    await _play('level-up-soft.mp3', volume: 0.78);
  }

  static Future<void> playGentleNotification() async {
    await _play('gentle-notification.mp3', volume: 0.58);
  }
}
