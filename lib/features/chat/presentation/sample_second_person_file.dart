import 'package:flutter/material.dart';

class SampleSecondPersonFile extends StatelessWidget {
  const SampleSecondPersonFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(7),
            child: Icon(
              Icons.file_present_rounded,
              size: 27,
              color: Colors.black45,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.7),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mohsin Ismail',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '1.1 GB',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 100),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
