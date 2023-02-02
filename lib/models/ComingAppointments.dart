import 'package:flutter/material.dart';

class ListAppointments extends StatefulWidget {

  const ListAppointments({
    Key? key
  }) : super(key: key);

  @override
  State<ListAppointments> createState() => ListAppointmentsState();

}

class ListAppointmentsState extends State<ListAppointments> {

  final String? date, client,assign,service,timeLast,payment, status;

  ListAppointmentsState({this.date, this.client,this.assign,this.service,this.timeLast,this.payment, this.status});

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

List comingEvents = [
  ListAppointmentsState(
    date: "01-03-2021",
    client: "Allpha T",
    assign: "M. Walter Swagger",
    service: "Child Hair cut",
    timeLast: "30 mins",
    payment: "12€",
    status: "Nouveau",
  ),
  ListAppointmentsState(
    date: "27-02-2021",
    client: "Blaise B",
    assign: "M. Adrien Fik",
    service: "Adult Hair cut",
    timeLast: "30 mins",
    payment: "30€",
    status: "En cours",
  ),
  ListAppointmentsState(
    date: "23-02-2021",
    client: "Fred Fik",
    assign: "M. O'brian Larson",
    service: "Adult Hair cut",
    timeLast: "30 mins",
    payment: "30€",
    status: "Traitée",
    //icon: "assets/icons/doc_file.svg",
  ),
  ListAppointmentsState(
    date: "23-02-2021",
    client: "Fred Larson",
    assign: "M. O'brian Larson",
    service: "AAdo Hair cut",
    timeLast: "30 mins",
    payment: "15€",
    status: "Payée",
    //icon: "assets/icons/doc_file.svg",
  ),
];
