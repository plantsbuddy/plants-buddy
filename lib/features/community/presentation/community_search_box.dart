import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/community/logic/community_bloc/community_bloc.dart';

class CommunitySearchBox extends StatelessWidget {
  const CommunitySearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey[200]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
        child: Row(
          children: [
            Icon(Icons.search),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 200,
              child: TextField(
                autofocus: false,
                style: TextStyle(
                  color: Colors.black54,
                  decoration: TextDecoration.none,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'Search in community...',
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                  isDense: true,
                ),
                textCapitalization: TextCapitalization.sentences,
                onChanged: ((value) => context.read<CommunityBloc>().add(CommunitySearchTermUpdated(value))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
