import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';

class UpdateProfileSheet extends StatefulWidget {
  const UpdateProfileSheet({Key? key}) : super(key: key);

  @override
  State<UpdateProfileSheet> createState() => _UpdateProfileSheetState();
}

class _UpdateProfileSheetState extends State<UpdateProfileSheet> {
  late final TextEditingController nameController;
  String? nameError;
  File? selectedImage;
  bool picDeleted = false;
  late final AuthenticationBloc bloc;

  @override
  void initState() {
    bloc = context.read<AuthenticationBloc>();
    nameController = TextEditingController(text: bloc.state.currentUser!.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update Profile',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 15),
              _getImageWidget(),
              SizedBox(height: 15),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      foregroundColor: Theme.of(context).colorScheme.tertiary,
                      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                    onPressed: pickProfilePicture,
                    child: Text('Change Picture'),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      foregroundColor: Theme.of(context).colorScheme.error,
                      backgroundColor: Theme.of(context).colorScheme.errorContainer,
                    ).copyWith(
                      elevation: ButtonStyleButton.allOrNull(0.0),
                    ),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text('Confirm Removal'),
                          content: Text('Are you sure you want to remove your profile picture?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedImage = null;
                                  picDeleted = true;
                                });

                                Navigator.of(context).pop();
                              },
                              child: Text('Remove'),
                              style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                            ),
                          ],
                        );
                      },
                    ),
                    child: Text('Remove'),
                  ),
                ],
              ),
              SizedBox(height: 15),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  errorText: nameError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
              ),
              SizedBox(height: 25),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameController.text.trim().isEmpty) {
                      setState(() => nameError = 'Please input your name');
                    } else {
                      bloc.add(AuthenticationUpdateProfile(
                        name: nameController.text,
                        profilePicturePath: selectedImage?.path,
                        picDeleted: picDeleted,
                      ));
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Text('Update Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 40);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        picDeleted = false;
      });
    }
  }

  Widget _getImageWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: selectedImage != null
          ? Image.file(
              selectedImage!,
              fit: BoxFit.cover,
              height: 150,
              width: 150,
            )
          : Image.network(
              picDeleted
                  ? 'https://upload.wikimedia.org/wikipedia/commons/3/3a/John_G._Dow.jpg'
                  : bloc.state.currentUser!.profilePicture,
              height: 120,
              width: 120,
            ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
