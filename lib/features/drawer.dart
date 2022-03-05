import 'package:cryptoapp/Authorization/auth_helper.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class drawer extends StatelessWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // This mainAxisAlignment allows Log Out button to be at bottom all the time
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: [
            // DrawerHeader used for better drawer customization
            DrawerHeader(
              child: null,
              decoration: BoxDecoration(
                color: Colors.indigo,
                image: DecorationImage(
                    // Need to replace with asset image (inside assets/homepage)
                    image: NetworkImage(
                        "https://pbs.twimg.com/media/DpKsUWyX4AQ-jnR?format=jpg&name=small"),
                    fit: BoxFit.fill),
              ),
            ),
            // Add more listTile here for more selections below
            // *** Add Below this line ***
            ListTile(
              title: Text('ToBeEdited01...'),
              onTap: () {},
            ),
            ListTile(
              title: Text('ToBeEdited02...'),
              onTap: () {},
            ),
            // *** Add above this line ***
          ],
        ),
        // Log Out button here
        TextButton(
            onPressed: () {
                  AuthHelper().logOut();
            },
            child: Text("Log Out"))
      ],
    );
  }
}
