import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late FocusNode _firstNameFocusNode;
  late TextEditingController _firstNameTextController;

  @override
  void initState() {
    super.initState();
    _firstNameFocusNode = FocusNode();
    _firstNameTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            onSaved: (text) {},
            onChanged: (text) {},
            focusNode: _firstNameFocusNode,
            controller: _firstNameTextController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(),
              hintText: 'Some',
            ),
          ),
        ],
      ),
    );
  }
}
