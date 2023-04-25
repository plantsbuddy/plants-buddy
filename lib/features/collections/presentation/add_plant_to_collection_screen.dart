import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plants_buddy/features/collections/logic/add_collection_bloc/add_plant_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;

class AddPlantToCollectionScreen extends StatefulWidget {
  const AddPlantToCollectionScreen({Key? key}) : super(key: key);

  @override
  State<AddPlantToCollectionScreen> createState() => _AddPlantToCollectionScreenState();
}

class _AddPlantToCollectionScreenState extends State<AddPlantToCollectionScreen> {
  late final TextEditingController _commonNamesController;
  late final TextEditingController _scientificNameController;
  late final TextEditingController _leafColorController;
  late final TextEditingController _genusController;
  late final TextEditingController _speciesController;
  late final TextEditingController _familyController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _lightConditionsController;
  late final TextEditingController _soilDrainageController;

  late final AddPlantBloc bloc;

  String? commonNamesError;
  String? scientificNameError;
  String? leafColorError;
  String? genusError;
  String? speciesError;
  String? familyError;
  String? descriptionError;
  String? lightConditionsError;
  String? soilDrainageError;

  File? selectedImage;
  bool pictureErrorVisible = false;

  @override
  void initState() {
    bloc = context.read<AddPlantBloc>();
    _commonNamesController = TextEditingController(text: bloc.state.commonNames);
    _scientificNameController = TextEditingController(text: bloc.state.scientificName);
    _leafColorController = TextEditingController(text: bloc.state.leafColor);
    _genusController = TextEditingController(text: bloc.state.genus);
    _speciesController = TextEditingController(text: bloc.state.species);
    _familyController = TextEditingController(text: bloc.state.family);
    _descriptionController = TextEditingController(text: bloc.state.description);
    _lightConditionsController = TextEditingController(text: bloc.state.lightConditions);
    _soilDrainageController = TextEditingController(text: bloc.state.soilDrainage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Plant to Collection'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            selectedImage == null
                ? GestureDetector(
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate,
                            size: 40,
                            color: Colors.grey[600],
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Add a picture of plant',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: pickPicture,
                  )
                : Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            foregroundColor: Theme.of(context).colorScheme.tertiary,
                            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                          onPressed: pickPicture,
                          child: Text('Change Picture'),
                        ),
                      ),
                    ],
                  ),
            if (pictureErrorVisible)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Please select a picture',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error),
                ),
              ),
            SizedBox(height: 15),
            TextField(
              controller: _commonNamesController,
              decoration: InputDecoration(
                labelText: 'Common names',
                errorText: commonNamesError,
                prefixIcon: Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
                hintText: 'Enter comma separated names',
                hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _scientificNameController,
              decoration: InputDecoration(
                labelText: 'Scientific name',
                errorText: scientificNameError,
                prefixIcon: Icon(
                  Icons.science,
                  size: 18,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _leafColorController,
              decoration: InputDecoration(
                labelText: 'Leaf color',
                errorText: leafColorError,
                prefixIcon: Icon(
                  Icons.color_lens,
                  size: 18,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _genusController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.spa,
                  size: 17,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
                labelText: 'Genus',
                errorText: genusError,
                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _speciesController,
              decoration: InputDecoration(
                labelText: 'Species',
                errorText: speciesError,
                prefixIcon: Icon(
                  Icons.energy_savings_leaf,
                  size: 17,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _familyController,
              decoration: InputDecoration(
                labelText: 'Family',
                errorText: familyError,
                prefixIcon: Icon(
                  Icons.bubble_chart,
                  size: 17,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                errorText: descriptionError,
                prefixIcon: Icon(
                  Icons.description,
                  size: 18,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              ),
              minLines: 1,
              maxLines: 4,
            ),
            SizedBox(height: 15),
            TextField(
              controller: _lightConditionsController,
              decoration: InputDecoration(
                labelText: 'Light conditions',
                errorText: lightConditionsError,
                prefixIcon: Icon(
                  Icons.sunny,
                  size: 18,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _soilDrainageController,
              decoration: InputDecoration(
                labelText: 'Soil drainage',
                errorText: soilDrainageError,
                prefixIcon: Icon(
                  Icons.soup_kitchen,
                  size: 18,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              ),
              minLines: 1,
              maxLines: 4,
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_commonNamesController.text.trim().isEmpty) {
                    setState(() => commonNamesError = 'Please input common names of plant');
                  } else if (_scientificNameController.text.trim().isEmpty) {
                    setState(() => commonNamesError = 'Please input scientific name of plant');
                  } else if (_leafColorController.text.trim().isEmpty) {
                    setState(() => leafColorError = 'Please input leaf color of plant');
                  } else if (_genusController.text.trim().isEmpty) {
                    setState(() => genusError = 'Please input genus of plant');
                  } else if (_speciesController.text.trim().isEmpty) {
                    setState(() => speciesError = 'Please input species of plant');
                  } else if (_familyController.text.trim().isEmpty) {
                    setState(() => familyError = 'Please input family of plant');
                  } else if (_descriptionController.text.trim().isEmpty) {
                    setState(() => descriptionError = 'Please input description of plant');
                  } else if (_lightConditionsController.text.trim().isEmpty) {
                    setState(() => lightConditionsError = 'Please input light conditions of plant');
                  } else if (_soilDrainageController.text.trim().isEmpty) {
                    setState(() => soilDrainageError = 'Please input soil drainage');
                  } else if (selectedImage == null) {
                    setState(() => pictureErrorVisible = true);
                  } else {
                    bloc.add(AddPlantSubmitButtonPressed(
                      commonNames: _commonNamesController.text,
                      scientificName: _scientificNameController.text,
                      leafColor: _leafColorController.text,
                      genus: _genusController.text,
                      species: _speciesController.text,
                      family: _familyController.text,
                      description: _descriptionController.text,
                      lightConditions: _lightConditionsController.text,
                      soilDrainage: _soilDrainageController.text,
                    ));

                    showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                          child: Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Adding plant to collection...'),
                            ],
                          ),
                        ),
                      ),
                    );

                    Future.delayed(
                      Duration(milliseconds: 1500),
                      () => Navigator.of(context).popUntil((route) => route.settings.name == app_routes.home),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Text(bloc.state.originalPlant == null ? 'Add Plant' : 'Update Plant'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickPicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 60);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        pictureErrorVisible = false;
      });
    }
  }

  @override
  void dispose() {
    _commonNamesController.dispose();
    _scientificNameController.dispose();
    _leafColorController.dispose();
    _genusController.dispose();
    _speciesController.dispose();
    _familyController.dispose();
    _descriptionController.dispose();
    _lightConditionsController.dispose();
    _soilDrainageController.dispose();
    super.dispose();
  }
}
