import 'package:flutter/material.dart';

class Editeprofile extends StatefulWidget {
  const Editeprofile({Key? key}) : super(key: key);

  @override
  State<Editeprofile> createState() => _EditeprofileState();
}

class _EditeprofileState extends State<Editeprofile> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Edite profile'),
      ),
    );
  }
}
