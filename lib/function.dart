import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          description: 'Le mari est vraiment une ORDURE immatriculée....Aucun'
              ' sentiment..ni gentillesse à son retour',
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

// favorite_service.dart
class FavoriteService {
  static final FavoriteService instance = FavoriteService._internal();
  factory FavoriteService() => instance;
  FavoriteService._internal();

  final Set<videoModel> favorites = {};

  List<videoModel> getFavorites() => favorites.toList();

  void toggleFavorite(videoModel video) {
    if (video.isFavorite) {
      favorites.remove(video);
      video.isFavorite = false;
    } else {
      favorites.add(video);
      video.isFavorite = true;
    }
  }

  bool isFavorite(videoModel video) => favorites.contains(video);
}

class VideoCard extends StatelessWidget {
  final videoModel video;
  final VoidCallback onFavoritePressed;
  final VoidCallback? onTap;


  VideoCard({
    Key? key,
    required this.video,
    required this.onFavoritePressed,
    this.onTap,
  }) : super(key: key);
  // Map pour stocker un contrôleur pour chaque vidéo

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.play_arrow,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    icon: Icon(
                      video.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: video.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: onFavoritePressed,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    video.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}