import 'package:flutter/material.dart';

import 'detail_pages/plant_one.dart';
import 'detail_pages/plant_three.dart';
import 'detail_pages/plant_two.dart';

class PlantDetailsScreen extends StatelessWidget {
  const PlantDetailsScreen(this.plant, {Key? key}) : super(key: key);

  final Map<String, dynamic> plant;

  /*
  * Plants details number represent the website where data was scraped from
  * 1: plants.ces.ncsu.edu
  * 2: first-nature.com
  * 3: wildflowersprovence.fr
  * */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Builder(
            builder: (context) {
              switch (plant['website']) {
                case '1':
                  return PlantDetailsOne(plant);

                case '2':
                  return PlantDetailsTwo(plant);

                case '3':
                  return PlantDetailsThree(plant);

                default:
                  return PlantDetailsOne(plant);
              }
            },
          ),
        ),
      ),
    );
  }
}
