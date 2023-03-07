import 'package:flutter/material.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as routes;

class SampleCollection extends StatelessWidget {
  const SampleCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(routes.collectionPlants),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                child: Image.network(
                  'https://static.onecms.io/wp-content/uploads/sites/34/2019/12/fragrant-flowers-intro-getty-1219.jpg',
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'Fragrant Plants',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
