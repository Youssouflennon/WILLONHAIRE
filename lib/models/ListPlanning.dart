import 'package:flutter/material.dart';

class ListPlanning extends StatefulWidget {

  const ListPlanning({
    Key? key
  }) : super(key: key);

  @override
  State<ListPlanning> createState() => ListPlanningState();

}

class ListPlanningState extends State<ListPlanning> {

  final String? profilePic, name, comment, date;
  final int? evaluation, order;
  ListPlanningState({this.profilePic, this.name,this.evaluation,this.comment,this.date,this.order});

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

List avisList = [
  ListPlanningState(
    profilePic: "assets/images/logoWillOnHair.png",
    name: "Allpha T",
    evaluation: 5,
    comment: "Child Hair cut dqgfshdjtdhsqgef rezhtjeytrhe tzrj rteh jeryj tzhaejz rketj zher zryej rthz j ejyrzth ear zje zhrea zjr hztear hzejhgk jzhtear htzrje ezh zrz aezreytzrye aerytzrettzyart etzreytzruaryte  r aeytzuzya   eraytzuyez eyatytuzryetz eartyetuzryerz eazrayetzutezaryetzruyea regdfhf",
    date: "12/05/2022",
    order: 3334,
  ),
  ListPlanningState(
    profilePic: "assets/images/photo_2022-11-23_04-40-34.jpg",
    name: "Fikish El",
    evaluation: 4,
    comment: "Great job",
    date: "30/12/2022",
    order: 127,
  ),
  ListPlanningState(
    profilePic: "assets/images/photo_2022-11-23_04-40-50.jpg",
    name: "Allpha T",
    evaluation: 3,
    comment: "Child Hair cut",
    date: "05/02/2022",
    order: 1277,
    //icon: "assets/icons/doc_file.svg",
  ),
];
