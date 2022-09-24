import 'package:flutter/material.dart';

class Cardnotes extends StatelessWidget {
  final void Function() ontap;
  final String title;
  final String content;
  const Cardnotes({
    Key? key,
    required this.ontap,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                "images/logo.jpg",
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text(title),
                  subtitle: Text(content),
                ))
          ],
        ),
      ),
    );
  }
}
