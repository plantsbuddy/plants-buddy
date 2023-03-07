import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/community/logic/community_post_bloc/community_post_bloc.dart';

class WriteAComment extends StatefulWidget {
  const WriteAComment({Key? key}) : super(key: key);

  @override
  State<WriteAComment> createState() => _WriteACommentState();
}

class _WriteACommentState extends State<WriteAComment> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.blueGrey[100], //Colors.black.withAlpha(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.grey[200]),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(
                  color: Colors.black54,
                  decoration: TextDecoration.none,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'Write a comment...',
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                  isDense: true,
                ),
                controller: _controller,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<CommunityPostBloc>().add(CommunityPostAddComment(_controller.text));
              _controller.clear();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Posting comment...'),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(milliseconds: 1500),
                ),
              );
            },
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: 16,
            ),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(10),
              backgroundColor: Theme.of(context).colorScheme.secondary, // <-- Button color
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
