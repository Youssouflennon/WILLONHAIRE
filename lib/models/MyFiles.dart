import 'package:flutter/material.dart';

class CloudStorageInfo extends StatelessWidget{

  final String? svgSrc, title, totalAppointments;
  final percentage;
  final Color? color;
  final Widget? button;
  final Function()? onTap;
  final int? index;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalAppointments,
    this.percentage,
    this.button,
    this.onTap,
    this.color,
    this.index
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }
}

List demoMyFiles = [
  CloudStorageInfo(
    index: 0,
    title: "Rendez-vous approuvés",
    svgSrc: "assets/icons/publicdomainq-book.svg",
      totalAppointments: "75",
    color: Colors.green,
    percentage: 0,
  ),
  CloudStorageInfo(
    index: 1,
    title: "Pourcentage de charge",
    svgSrc: "assets/icons/1636029011resume-cv-samples.svg",
      totalAppointments: "35%",
    color: Colors.blue,
    percentage: 35,
  ),
  CloudStorageInfo(
    index: 2,
    title: "Recette",
    svgSrc: "assets/icons/saco.svg",
      totalAppointments: "35€",
    color: Color(0xFFFFA113),
    percentage: 0,
  ),
];
