import 'package:flutter/material.dart';

mixin TextEditingControllersMixin<T extends StatefulWidget> on State<T> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    countryCodeController = TextEditingController();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
