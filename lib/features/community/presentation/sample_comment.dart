import 'package:flutter/material.dart';

import '../domain/entities/comment.dart';

class SamplePostComment extends StatelessWidget {
  const SamplePostComment(this._comment, {Key? key}) : super(key: key);

  final Comment _comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(150),
            child: Image.network(
              'https://cdn-icons-png.flaticon.com/512/149/149071.png',
              height: 30,
              width: 30,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _comment.author.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Text(
                      _comment.time,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Icon(Icons.report, size: 17,color: Colors.grey,),
                      ),
                      onTap: () =>showDialog(
                        context: context,
                        builder: (_) {
                          final controller = TextEditingController();
                          return AlertDialog(
                            title: Text('Report Comment'),
                            content: TextField(
                              autofocus: false,
                              controller: controller,
                              decoration: InputDecoration(
                                labelText: 'Reason for reporting',
                                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                                        content: Text('Please provide a reason for reporting...'),
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(milliseconds: 1500),
                                      ),
                                    );
                                  } else {
                                    // context
                                    //     .read<IdentificationBloc>()
                                    //     .add(IdentificationDownloadFromUrlPressed(controller.text.trim()));

                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text('Report'),
                                style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.primary),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Text(
                  _comment.body,
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
