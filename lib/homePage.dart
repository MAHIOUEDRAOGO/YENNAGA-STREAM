import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:streamapp/actionPages.dart';
import 'package:video_player/video_player.dart';
import 'drame.dart';

//import 'favoritesPage.dart';
import 'function.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  // Map pour stocker un contrôleur pour chaque vidéo
  Map<String, VideoPlayerController> videoControllers = {};
  Map<String, bool> isInitialized = {};

  final VideoService _videoService = VideoService();
  late List<videoModel> allVideos;

  @override
  void initState() {
    super.initState();
    allVideos = _videoService.getAllVideos();
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

  // Variable pour suivre la catégorie sélectionnée
  int selectedCategoryIndex = 0;
  // Liste des catégories de lieux
  final List<String> categories = [
    'Tous',
    'Actions',
    'Drame',
    'Comedie',
    'Sciences-Fictions'
  ];
  final List<String>imagesList=[
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/4.jpg',
  ];






  @override
  Widget build(BuildContext context) {
    // Pour la responsive
    double screen_height =  MediaQuery.of(context).size.height;
    double screen_width =  MediaQuery.of(context).size.width;

    return  Scaffold(
      // Barre d'application personnalisée
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu,color: Colors.white,),
          onPressed: (){},
        ),
        // Titre centré
        centerTitle: true,
        // Texte du titre avec style personnalisé
        title: Text(
          'StreamApp',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.2,
            // Ajout d'une ombre légère
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black38,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
        ),
        // Couleur de fond de la barre
        backgroundColor: Colors.black,
        // Actions dans la barre d'application
        actions: [
          // Bouton de profil
          Padding(padding: EdgeInsets.all(16),
            child:  IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {},
            ),
          )
        ],
      ),
      // Corps de l'application
      body: Column(
        children: [
          // Champ de recherche
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un films',
                filled: true,
                fillColor: Colors.black54,
                // Bordure personnalisée
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: CarouselSlider(
              // Configuration du carrousel
              options: CarouselOptions(
                height: screen_height*0.2, // Hauteur du carrousel
                autoPlay: false, // Active le défilement automatique des images
                enlargeCenterPage: true, // Agrandit l'image centrale pour un effet visuel
                aspectRatio: 16 / 9, // Définit le ratio largeur/hauteur
                viewportFraction: screen_width*0.0018, // Largeur relative de chaque image par rapport au carrousel
              ),
              // Construction des éléments du carrousel à partir de la liste d'images
              items: imagesList.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width, // Largeur dynamique en fonction de l'écran
                      margin: EdgeInsets.symmetric(horizontal:screen_width*0.01), // Marge horizontale entre les images
                      decoration: BoxDecoration(
                        color: Colors.amber, // Couleur d'arrière-plan en cas d'échec de chargement de l'image
                      ),
                      child: Image(image: AssetImage(item),

                        fit: BoxFit.cover, // Adapte l'image pour qu'elle couvre tout l'espace disponible
                      ),
                    );
                  },
                );
              }).toList(), // Convertit la liste d'images en une liste de widgets
            ),
          ),
          // Liste horizontale des catégories
          SizedBox(
            height: 50,
            child: ListView.builder(
              // Défilement horizontal
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                // Vérifie si la catégorie est sélectionnée
                bool isSelected = index == selectedCategoryIndex;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: GestureDetector(

                    // Gestion du tap sur une catégorie
                    onTap: () {
                      switch(index){
                        case 0:Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  homePage(),
                          ),
                        );
                        case 1:Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  actionPage(),
                          ),
                        );
                        break;
                        case 2:Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  dramePage(videos: _videoService.getDramaVideos(),title: 'Drame',),
                          ),
                        );
                        /**
                        case 3:Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  fovoritesPage(),
                          ),
                        );
                        break;
                        **/
                      }
                      setState(() {
                        selectedCategoryIndex = index;
                      });

                    },

                    child: Chip(
                      label: Text(categories[index]),
                      // Style dynamique selon la sélection
                      backgroundColor:
                      isSelected ? Colors.black : Colors.red,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.red : Colors.white,
                        fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Zone principale d'affichage
          Expanded(
            child: Stack(
              children: [
                // Fond bleu clair avec icône de localisation
                Container(
                  color: Colors.black54,

                ),

                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,  // 2 vidéos par ligne
                    childAspectRatio: 0.7,  // Ajustez ce ratio selon vos besoins
                    crossAxisSpacing: 8.0,  // Espacement horizontal entre les vidéos
                    mainAxisSpacing: 8.0,   // Espacement vertical entre les lignes
                  ),

                  itemCount: allVideos.length,
                  itemBuilder: (context, index) {
                    final video = allVideos[index];
                    if (!videoControllers.containsKey(video.videoPath)) {
                      _initializeController(video.videoPath);
                    }

                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(

                        children: [

                          Container(
                            height: 120,
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

              ],
            ),
          ),
        ],
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
