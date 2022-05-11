import 'package:flutter/material.dart';
import 'package:brandstores/src/domain/entities/member_center/member_center.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard({Key? key, required this.services, required this.tapped})
      : super(key: key);

  final List<Service> services;

  final ValueChanged<Service> tapped;

  void buttonTapped(Service service) {
    tapped(service);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 242.0,
        child: Card(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const HeaderView(),
            const Divider(
              height: 1.0,
            ),
            ServiceView(
              services: services,
              tapped: buttonTapped,
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

class ServiceView extends StatelessWidget {
  const ServiceView({Key? key, required this.services, required this.tapped})
      : super(key: key);

  final List<Service> services;

  final ValueChanged<Service> tapped;

  void buttonTapped(Service service) {
    tapped(service);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 242.0 - 41.0 - 32.0,
      child: _buildGrid(),
    );
  }

  GridView _buildGrid() {
    return GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        childAspectRatio: 7 / 6,
        children: _buildGridList());
  }

  List<Widget> _buildGridList() {
    return List.generate(
        services.length,
        (index) => ServiceButton(
              service: services[index],
              tapped: buttonTapped,
            ));
  }
}

class HeaderView extends StatelessWidget {
  const HeaderView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: Row(
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 14.0, top: 10.0, bottom: 10.0),
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
    );
  }
}

class ServiceButton extends StatelessWidget {
  const ServiceButton({Key? key, required this.service, required this.tapped})
      : super(key: key);

  final Service service;

  final ValueChanged<Service> tapped;

  void buttonTapped() {
    tapped(service);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: buttonTapped,
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
