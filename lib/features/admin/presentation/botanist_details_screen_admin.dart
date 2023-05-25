import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';
import 'package:plants_buddy/features/chat/domain/entities/conversation.dart';
import 'package:plants_buddy/features/chat/logic/chat_bloc.dart';

import '../../authentication/domain/entities/botanist.dart';

class BotanistDetailsScreenAdmin extends StatelessWidget {
  const BotanistDetailsScreenAdmin(this.botanist, {Key? key}) : super(key: key);

  final Botanist botanist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                botanist.profilePicture,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 280,
              ),
              Positioned(
                left: 10,
                top: 30,
                child: IconButton(
                  style:
                      IconButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5)),
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
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
                        botanist.username,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(width: 7),
                        Icon(
                          Icons.location_pin,
                          size: 18,
                          color: Theme.of(context).colorScheme.error.withOpacity(0.8),
                        ),
                        SizedBox(width: 7),
                        Text(
                          botanist.city,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
                                    botanist.specialty,
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
                                  botanist.consultationCharges.toString(),
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
                              botanist.description,
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
                              botanist.qualification,
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
                              botanist.phoneNumber,
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
                      onTap: () => Navigator.of(context).pushNamed(
                        app_routes.reviews,
                        arguments: botanist,
                      ),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Row(
                            children: [
                              Text(
                                'Reviews ',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Spacer(),
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
