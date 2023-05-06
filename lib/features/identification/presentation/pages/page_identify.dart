import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../logic/identification_bloc/identification_bloc.dart';

class PageIdentify extends StatelessWidget {
  const PageIdentify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<IdentificationBloc>().state;

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
                  state.identificationTypeIcon,
                  height: 40,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Identify ${state.identificationTypeTitle}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () =>
                        context.read<IdentificationBloc>().add(IdentificationTypeChanged(IdentificationType.plant)),
                    child: Chip(
                      label: Text('Plant'),
                      backgroundColor: state.identificationType == IdentificationType.plant
                          ? Theme.of(context).colorScheme.inversePrimary
                          : null,
                      side: BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () =>
                          context.read<IdentificationBloc>().add(IdentificationTypeChanged(IdentificationType.disease)),
                      child: Chip(
                        label: Text('Disease'),
                        backgroundColor: state.identificationType == IdentificationType.disease
                            ? Theme.of(context).colorScheme.inversePrimary
                            : null,
                        side: BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        context.read<IdentificationBloc>().add(IdentificationTypeChanged(IdentificationType.pest)),
                    child: Chip(
                      label: Text('Pest'),
                      backgroundColor: state.identificationType == IdentificationType.pest
                          ? Theme.of(context).colorScheme.inversePrimary
                          : null,
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
                'Provide a picture of the ${state.identificationTypeTitle} using any of the methods listed below, and get the details of the ${state.identificationTypeTitle}',
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
                    child: GestureDetector(
                      onTap: () => context.read<IdentificationBloc>().add(IdentificationPickFromGalleryPressed()),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: GestureDetector(
                      onTap: () => context.read<IdentificationBloc>().add(IdentificationCaptureFromCameraPressed()),
                      child: Column(
                        children: [
                          Container(
                            decoration:
                                BoxDecoration(color: Colors.orange[100], borderRadius: BorderRadius.circular(15)),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) {
                          final controller = TextEditingController();
                          return AlertDialog(
                            title: Text('Image URL'),
                            content: TextField(
                              autofocus: false,
                              controller: controller,
                              decoration: InputDecoration(
                                labelText: 'URL',
                                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
                                    final url = clipboardData?.text;
                                    controller.text = url ?? '';
                                  },
                                  icon: Icon(Icons.paste),
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Cancel'),
                                style: TextButton.styleFrom(foregroundColor: Theme.of(context).hintColor),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (controller.text.trim().isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Please provide a valid url...'),
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(milliseconds: 1500),
                                      ),
                                    );
                                  } else {
                                    context
                                        .read<IdentificationBloc>()
                                        .add(IdentificationDownloadFromUrlPressed(controller.text.trim()));

                                    Navigator.of(context).pop();

                                    showDialog(
                                      context: context,
                                      builder: (context) {
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
                                                Text('Downloading image'),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );

                                    Future.delayed(Duration(milliseconds: 1000))
                                        .then((_) => Navigator.of(context).pop());
                                  }
                                },
                                child: Text('Download'),
                                style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.primary),
                              ),
                            ],
                          );
                        },
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration:
                                BoxDecoration(color: Colors.purple[100], borderRadius: BorderRadius.circular(15)),
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
                  ),
                ],
              ),
              state.image != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(state.image!),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 35),
              ElevatedButton(
                onPressed: () {
                  if (state.image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please provide an image...'),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(milliseconds: 1500),
                      ),
                    );
                  } else {
                    context.read<IdentificationBloc>().add(IdentificationPerformIdentificationPressed());
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text('Identify ${state.identificationTypeTitle}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
