import 'package:flutter/material.dart';
import 'package:brandstores/src/domain/entities/member_center/member_center.dart';

class ServiceButton extends StatelessWidget {
  const ServiceButton({Key? key, required this.service}) : super(key: key);

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage('assets/${service.icon}'),
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        ),
        Text(service.title)
      ],
    );
  }
}
