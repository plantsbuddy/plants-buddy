import 'package:flutter/material.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;
import 'package:plants_buddy/features/botanists/presentation/gardener/make_appointment_screen.dart';

class BotanistDetailsScreen extends StatelessWidget {
  const BotanistDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                'https://static.onecms.io/wp-content/uploads/sites/34/2019/12/fragrant-flowers-intro-getty-1219.jpg',
                fit: BoxFit.cover,
                height: 280,
              ),
              Positioned(
                left: 10,
                top: 30,
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5)
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back_rounded, color: Colors.white,),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                margin: EdgeInsets.only(top: 255),
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        'Mohsin Ismail',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Plant Pathology',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.spa,
                                        size: 17,
                                        color: Theme.of(context).colorScheme.tertiaryContainer,
                                      ),
                                      SizedBox(width: 7),
                                      Text(
                                        'Specialty',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '25',
                                  style: TextStyle(fontSize: 22),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      size: 17,
                                      color: Theme.of(context).colorScheme.tertiaryContainer,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Consultation\ncharges',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.description,
                                  size: 18,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Description',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'A botanist is a scientist who specializes in the study of plants, including their structure, classification, growth, and reproduction. Botanists may work in a variety of settings, such as universities, botanical gardens, government agencies, or private companies. They use a range of scientific methods to explore and understand the complexities of plant life, from microscopic cellular structures to the broad patterns of plant distribution and adaptation in different environments.',
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BS. Software Engineering',
                              style: TextStyle(fontSize: 20),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.menu_book_outlined,
                                  size: 17,
                                  color: Theme.of(context).colorScheme.tertiaryContainer,
                                ),
                                SizedBox(width: 7),
                                Text(
                                  'Qualification',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '+92 317 2157898',
                              style: TextStyle(fontSize: 20),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 17,
                                  color: Theme.of(context).colorScheme.tertiaryContainer,
                                ),
                                SizedBox(width: 7),
                                Text(
                                  'Phone number',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(app_routes.reviews),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Row(
                            children: [
                              Text(
                                'Reviews ',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                '(45)',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Spacer(),
                              Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                              Text(
                                '4.5',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (_) => MakeAppointmentScreen(),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: Text('Book Appointment'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
