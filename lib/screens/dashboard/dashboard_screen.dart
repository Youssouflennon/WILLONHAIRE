import 'dart:convert';

import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../constants.dart';
import 'components/header.dart';

import 'components/recent_files.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    Key? key
  }) : super(key: key);

  @override
  State<DashboardScreen> createState() => DashboardScreenState();

}

class DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    super.initState();
    //initializePage();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      //if(Responsive.isDesktop(context))
                      MyFiles(),
                      SizedBox(height: defaultPadding),
                          RecentFiles(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
