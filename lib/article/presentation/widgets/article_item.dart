import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  final String title;
  final String body;

  const ArticleItem(this.title, this.body, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Colors.grey[200]),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                  color: Color(0XFF8B8B8B),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            FittedBox(
              child: Text(
                body,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
