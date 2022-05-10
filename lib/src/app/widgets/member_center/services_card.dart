import 'package:flutter/material.dart';
import 'package:brandstores/src/domain/entities/member_center/member_center.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard({Key? key, required this.services}) : super(key: key);

  final List<Service> services;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 243 + 24 + 14,
        child: Card(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 40.0,
              child: Row(
                children: const [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 14.0, top: 10.0, bottom: 10.0),
                    child: Text(
                      '我的服務',
                      style: TextStyle(
                          fontFamily: 'PingFangTC-Semibold',
                          fontSize: 14.0,
                          color: Color.fromRGBO(76, 76, 76, 1.0)),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1.0,
            ),
            SizedBox(
              height: 249.0 - 41.0,
              child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  childAspectRatio: 2 / 2,
                  children: List.generate(services.length,
                      (index) => ServiceButton(service: services[index]))),
            )
          ]),
          color: Colors.white,
          elevation: 5,
          margin: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ));
  }
}

class ServiceButton extends StatelessWidget {
  const ServiceButton({Key? key, required this.service}) : super(key: key);

  final Service service;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          'assets/${service.icon}',
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(height: 3),
        Text(service.title,
            style: const TextStyle(
                fontFamily: 'PingFangTC-Regular',
                fontSize: 14.0,
                color: Color.fromRGBO(76, 76, 76, 1)))
      ]),
    );
  }
}
