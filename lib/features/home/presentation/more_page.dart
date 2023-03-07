import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.5),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image.network(
                  'https://static.onecms.io/wp-content/uploads/sites/34/2019/12/fragrant-flowers-intro-getty-1219.jpg',
                  fit: BoxFit.cover,
                  width: 45,
                  height: 45,
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mohsin Ismail', style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    'mohsin_ismail@gmail.com',
                    style: TextStyle(color: Theme.of(context).dividerColor.withOpacity(0.5)),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Expanded(
          child: GridView.count(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(app_routes.consultBotanists),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          custom_icons.botanist,
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Divider(
                            height: 1,
                            thickness: 0.1,
                          ),
                        ),
                        Text(
                          'Botanist\nConsultation',
                          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(app_routes.attendGardeners),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          custom_icons.gardener,
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Divider(
                            height: 1,
                            thickness: 0.1,
                          ),
                        ),
                        Text(
                          'Attend\nGardeners',
                          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                // onTap: ()=>Navigator.of(context).pushNamed(app_routes.name),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          custom_icons.plantCare,
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Divider(
                            height: 1,
                            thickness: 0.1,
                          ),
                        ),
                        Text(
                          'Plant\nCare',
                          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(app_routes.chatbot),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          custom_icons.chatbot,
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Divider(
                            height: 1,
                            thickness: 0.1,
                          ),
                        ),
                        Text(
                          'Chatbot',
                          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 20,
            mainAxisSpacing: 25,
            padding: EdgeInsets.symmetric(horizontal: 30),
            crossAxisCount: 2,
          ),
        ),
      ],
    );
  }
}
