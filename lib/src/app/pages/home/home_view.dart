import './home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../../data/repositories/data_users_repository.dart';

class HomePage extends View {
  HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HomePageState createState() =>
      // inject dependencies inwards
      _HomePageState();
}

class _HomePageState extends ViewState<HomePage, HomeController> {
  _HomePageState() : super(HomeController(DataUsersRepository()));

  @override
  Widget get view {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ControlledWidgetBuilder<HomeController>(
            builder: (context, controller) {
              return Text(
                'Button pressed ${controller.counter} times.',
              );
            },
          ),
          const Text(
            'The current user is',
          ),
          ControlledWidgetBuilder<HomeController>(
            builder: (context, controller) {
              return Text(
                controller.user == null ? '' : '${controller.user}',
                style: Theme.of(context).textTheme.headline4,
              );
            },
          ),
          ControlledWidgetBuilder<HomeController>(
            builder: (context, controller) {
              return ElevatedButton(
                onPressed: controller.getUser,
                child: const Text(
                  'Get User',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
          ControlledWidgetBuilder<HomeController>(
            builder: (context, controller) {
              return ElevatedButton(
                onPressed: controller.getUserwithError,
                child: const Text(
                  'Get User Error',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
