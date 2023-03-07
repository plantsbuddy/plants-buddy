import 'package:flutter/material.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;

class SampleConversationItem extends StatelessWidget {
  const SampleConversationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(app_routes.chat),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 5, bottom: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/3/3a/John_G._Dow.jpg',
                  height: 60,
                  fit: BoxFit.cover,
                  width: 60,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              'Mohsin Ismail',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          // Spacer(),
                          Text(
                            '1m ago',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Islamabad',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
