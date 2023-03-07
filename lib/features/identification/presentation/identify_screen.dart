import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;

class IdentifyScreen extends StatefulWidget {
  IdentifyScreen(this.selectedItem, {Key? key}) : super(key: key);

  int selectedItem = 0;

  @override
  State<IdentifyScreen> createState() => _IdentifyScreenState();
}

class _IdentifyScreenState extends State<IdentifyScreen> {
  final List<String> titles = const [
    'plant',
    'disease',
    'pest',
  ];

  final List<String> icons = const [
    custom_icons.plant,
    custom_icons.plantDisease,
    custom_icons.pest,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(50)),
                padding: EdgeInsets.all(20),
                child: SvgPicture.asset(
                  icons[widget.selectedItem],
                  height: 40,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Identify ${titles[widget.selectedItem]}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => widget.selectedItem = 0),
                    child: Chip(
                      label: Text('Plant'),
                      backgroundColor: widget.selectedItem == 0 ? Theme.of(context).colorScheme.inversePrimary : null,
                      side: BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () => setState(() => widget.selectedItem = 1),
                      child: Chip(
                        label: Text('Disease'),
                        backgroundColor: widget.selectedItem == 1 ? Theme.of(context).colorScheme.inversePrimary : null,
                        side: BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => widget.selectedItem = 2),
                    child: Chip(
                      label: Text('Pest'),
                      backgroundColor: widget.selectedItem == 2 ? Theme.of(context).colorScheme.inversePrimary : null,
                      side: BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Provide a picture',
                style: TextStyle(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Provide a picture of the ${titles[widget.selectedItem]} using any of the methods listed below, and get the details of the ${titles[widget.selectedItem]}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(20),
                          child: Icon(
                            Icons.collections,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Gallery',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.orange[100], borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(20),
                          child: Icon(
                            Icons.camera,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Camera',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.purple[100], borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(20),
                          child: Icon(
                            Icons.link,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'URL',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 35),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/109354797/original/db7435d5305bb7b8a843e405af7d00952c82f9a3/implement-android-ui-design-in-xml.png',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text('Identify ${titles[widget.selectedItem]}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
