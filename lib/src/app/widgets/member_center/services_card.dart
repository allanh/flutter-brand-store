import 'package:flutter/material.dart';
import 'package:brandstores/src/app/widgets/member_center/service_button.dart';
import 'package:brandstores/src/domain/entities/member_center/member_center.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard({Key? key, required this.services}) : super(key: key);

  final List<Service> services;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 225.0,
        child: Card(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
                height: 40.0,
                child: Row(
                  children: const [
                    Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          '我的服務',
                          style: TextStyle(
                              fontFamily: 'PingFangTC-Semibold',
                              fontSize: 14.0,
                              color: Color.fromRGBO(76, 76, 76, 1.0)),
                        )),
                  ],
                )),
            const Divider(
              height: 1.0,
            ),
            Expanded(
                child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    childAspectRatio: 1.2,
                    children: List.generate(
                        services.length,
                        (index) => Padding(
                            padding: const EdgeInsets.all(10),
                            child: ServiceButton(service: services[index])))))
          ]),
          color: Colors.white,
          elevation: 5,
          margin: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ));
  }
}
