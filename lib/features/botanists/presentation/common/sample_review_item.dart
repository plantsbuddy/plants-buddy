import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SampleReviewItem extends StatelessWidget {
  const SampleReviewItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 13),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/3/3a/John_G._Dow.jpg',
                    height: 45,
                    fit: BoxFit.cover,
                    width: 45,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mohsin Ismail',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            for (int i = 0; i < 4; i++)
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.orange,
                              ),
                            SizedBox(width: 10),
                            Text(
                              '4.0',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Spacer(),
                            Text(
                              '1 mo ago',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Mohsin Ismail Baloch Istan ',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
