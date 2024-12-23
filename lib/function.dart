import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class videoModel {
  final String title;
  final String description;
  final String videoPath;
  bool isFavorite;

  videoModel({required this.title,
    required this.description,
    required this.videoPath,
    this.isFavorite = false,}
      );
}

// video_service.dart
class VideoService {
  List<videoModel> getActionVideos() {
    // Déplacer ici la logique de actionPage.dart
    return [
      videoModel(
          title: 'Une femme en detresse',
          description: 'Le mari est vraiment une ORDURE immatriculée....Aucun',
          videoPath: 'assets/videos/3.mp4'
      ),
      videoModel(
          title: 'LE VOLEUR INTELLIGENT',
          description: 'Meilleur film d’action HD burkinabé en 2019',
          videoPath: 'assets/videos/2.mp4'
      ),
      // Ajouter autres vidéos action...
    ];
  }

  List<videoModel> getDramaVideos() {
    // Déplacer ici la logique de dramePage.dart
    return [
      videoModel(
          title: 'Burkimbile Halaale',
          description: 'Kathy, la fille de l\'inspecteur Luner, est retrouvée en'
              ' état de choc .',
          videoPath: 'assets/videos/1.mp4'
      ),
      videoModel(
          title: 'De l\'amour a la haine',
          description: ' un film poignant qui plonge au cœur des réalités sociales du Burkina Faso..',
          videoPath: 'assets/videos/4.mp4'
      ),
      // Ajouter autres vidéos drame...
    ];
  }

  List<videoModel> getAllVideos() {
    return [...getActionVideos(), ...getDramaVideos()];
  }
}



