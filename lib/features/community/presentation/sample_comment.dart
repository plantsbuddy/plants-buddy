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
                      style: Theme.of(context).textTheme.caption,
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
