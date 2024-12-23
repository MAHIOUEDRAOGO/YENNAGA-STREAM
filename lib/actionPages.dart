import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'function.dart';

class actionPage extends StatefulWidget {
  const actionPage({super.key});

  @override
  State<actionPage> createState() => _actionPageState();
}

class _actionPageState extends State<actionPage> {
  // Map pour stocker un contrôleur pour chaque vidéo
  Map<String, VideoPlayerController> videoControllers = {};
  Map<String, bool> isInitialized = {};

  final VideoService videoService = VideoService();
  late List<videoModel> actionVideos;

  @override
  void initState() {
    super.initState();
    actionVideos = videoService.getActionVideos();
  }

  @override
  void dispose() {
    // Libérer tous les contrôleurs
    for (var controller in videoControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // Initialiser un contrôleur pour une vidéo spécifique
  Future<void> _initializeController(String videoPath) async {
    if (!videoControllers.containsKey(videoPath)) {
      final controller = VideoPlayerController.asset(videoPath);
      videoControllers[videoPath] = controller;
      isInitialized[videoPath] = false;
      await controller.initialize();
      setState(() {
        isInitialized[videoPath] = true;
      });
    }
  }

  // Gérer la lecture/pause d'une vidéo spécifique
  void _playPause(String videoPath) {
    final controller = videoControllers[videoPath];
    if (controller != null) {
      setState(() {
        if (controller.value.isPlaying) {
          controller.pause();
        } else {
          // Mettre en pause toutes les autres vidéos
          for (var otherController in videoControllers.values) {
            if (otherController != controller && otherController.value.isPlaying) {
              otherController.pause();
            }
          }
          controller.play();
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu,color: Colors.white,),
          onPressed: (){},
        ),
        centerTitle: true,
        title: Text('Actions',
          style: TextStyle(color: Colors.red,fontSize: 30),),
        backgroundColor: Colors.black,
        actions: [
          Padding(padding: EdgeInsets.all(16),
              child:  IconButton(
                icon: Icon(Icons.notifications,color: Colors.white,),
                onPressed:(){

                },
              )
          )
        ],
      ),
      body:  GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,  // 2 vidéos par ligne
          childAspectRatio: 0.7,  // Ajustez ce ratio selon vos besoins
          crossAxisSpacing: 8.0,  // Espacement horizontal entre les vidéos
          mainAxisSpacing: 8.0,   // Espacement vertical entre les lignes
        ),

        itemCount: actionVideos.length,
        itemBuilder: (context, index) {
          final video = actionVideos[index];
          if (!videoControllers.containsKey(video.videoPath)) {
            _initializeController(video.videoPath);
          }

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(

              children: [

                Container(
                  height: 100,

                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (isInitialized[video.videoPath] == true)
                        AspectRatio(
                          aspectRatio: videoControllers[video.videoPath]!.value.aspectRatio,
                          child: VideoPlayer(videoControllers[video.videoPath]!),
                        ),
                      IconButton(
                        onPressed: () {
                          _playPause(video.videoPath);
                        },
                        icon: Icon(
                          videoControllers[video.videoPath]?.value.isPlaying ?? false
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill_outlined,
                          size: 50,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(

                  title: Text(
                    video.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(video.description),
                ),
              ],
            ),
          );
        },
      ),
      // Barre de navigation en bas
      bottomNavigationBar: BottomNavigationBar(
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.black),
            label: 'Acceuil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie,color: Colors.black),
            label: 'Genre',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,color: Colors.red,),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: Colors.black),
            label: 'Profile',
          ),
        ],
        /**
            onTap: (index) {
            if (index == 2) {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => fovoritesPage()),
            );
            }
            // Gérer les autres index...
            },**/
      ),
    );
  }
}