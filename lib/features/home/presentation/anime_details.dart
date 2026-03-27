import 'package:flutter/material.dart';
import 'package:manga/features/home/data/models/home_voir_plus_model.dart';

class AnimeDetails extends StatefulWidget {
  final HomeVoirPlusModel animedeatils;

  const AnimeDetails({super.key, required this.animedeatils});

  @override
  State<AnimeDetails> createState() => AnimeDetailsState();
}

class AnimeDetailsState extends State<AnimeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Détails de l\'anime')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 500,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      widget.animedeatils.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.bookmark_border, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.animedeatils.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Action, Aventure, Fantastique",
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              "${widget.animedeatils.score}/10 (200k votes)",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Synopsis',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.animedeatils.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
