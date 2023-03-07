import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.yellow[200]),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    custom_icons.plant,
                    height: 24,
                    width: 24,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s tip',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Water your plants daily to keep them fresh and green',
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Highlights',
            style: TextStyle(color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(app_routes.identify, arguments: 0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(20),
                        child: SvgPicture.asset(
                          custom_icons.plant,
                          width: 40,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Identify\nPlant',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(app_routes.identify, arguments: 1),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Color(0xFFCDFFCC), borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(20),
                        child: SvgPicture.asset(
                          custom_icons.plantDisease,
                          width: 40,
                          height: 40,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Identify\nDisease',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(app_routes.identify, arguments: 2),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.orange[100], borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(20),
                        child: SvgPicture.asset(
                          custom_icons.pest,
                          width: 40,
                          height: 40,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Identify\nPest',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Color(0xCCEF9A9A), borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.all(20),
                      child: Image.asset(
                        custom_icons.history,
                        width: 40,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Identification\nHistory',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
