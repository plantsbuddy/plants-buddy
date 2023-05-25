import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../logic/add_collection_bloc/add_collection_bloc.dart';

class AddCollectionSheet extends StatefulWidget {
  const AddCollectionSheet({Key? key}) : super(key: key);

  @override
  State<AddCollectionSheet> createState() => _AddCollectionSheetState();
}

class _AddCollectionSheetState extends State<AddCollectionSheet> {
  late final TextEditingController nameController;
  String? nameError;
  File? selectedImage;
  bool coverErrorVisible = false;
  late final AddCollectionBloc bloc;

  @override
  void initState() {
    bloc = context.read<AddCollectionBloc>();
    nameController = TextEditingController(text: bloc.state.name);
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
                bloc.state.originalCollection == null ? 'Add Collection' : 'Update Collection',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 15),
              _getImageWidget(),
              SizedBox(height: 15),
              if (coverErrorVisible)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Please select a cover picture for collection',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  foregroundColor: Theme.of(context).colorScheme.tertiary,
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                onPressed: pickCoverPicture,
                child: Text('Update Cover Picture'),
              ),
              SizedBox(height: 15),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  errorText: nameError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
                textCapitalization: TextCapitalization.words,

              ),
              SizedBox(height: 25),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameController.text.trim().isEmpty) {
                      setState(() => nameError = 'Please input name of collection');
                    } else if (selectedImage == null && bloc.state.originalCollection == null) {
                      setState(() => coverErrorVisible = true);
                    } else {
                      bloc.add(AddCollectionButtonPressed(
                          cover: selectedImage?.path ?? bloc.state.originalCollection!.cover,
                          name: nameController.text));

                      BuildContext? dialogContext;

                      showDialog(
                        context: context,
                        builder: (_) {
                          dialogContext = _;
                          return Dialog(
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                              child: Row(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                      '${bloc.state.originalCollection == null ? 'Creating' : 'Updating'} collection...'),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                      Future.delayed(
                        Duration(milliseconds: 2500),
                        () {
                          Navigator.of(context).pop();
                          Navigator.of(dialogContext!).pop();
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Text(bloc.state.originalCollection == null ? 'Add Collection' : 'Update Collection'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickCoverPicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 10);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        coverErrorVisible = false;
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
          : (bloc.state.originalCollection == null
              ? Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.all(50),
                  child: Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                )
              : Image.network(
                  bloc.state.originalCollection!.cover,
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                )),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
