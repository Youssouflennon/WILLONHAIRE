import 'package:flutter/material.dart';

import '../../color_constants.dart';

class UserDetailsMiniCard extends StatelessWidget {
  const UserDetailsMiniCard({
    Key? key,
    required this.title,
    required this.color,
    required this.amountOfFiles,
    required this.numberOfIncrease,
  }) : super(key: key);

  final Color color;
  final String title, amountOfFiles;
  final int numberOfIncrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: color.withOpacity(0.3)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
              height: 20,
              width: 20,
              child: Container(
                color: color,
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                    color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$numberOfIncrease",
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          Text(amountOfFiles, style: TextStyle(color: color))
        ],
      ),
    );
  }
}
