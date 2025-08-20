import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.width*0.3,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 100,
                  ),
                  SizedBox(width: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      Text(
                        "Admin",
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ]
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.mail
                ),
                SizedBox(width: 10,),
                Text(
                  "feedback",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ]
            ),
            Divider(),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.cube_box_fill
                ),
                SizedBox(width: 10,),
                Text(
                  "Orders",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ]
            ),
            Divider(),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person
                ),
                SizedBox(width: 10,),
                Text(
                  "Users",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ]
            ),
            Divider(),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings
                ),
                SizedBox(width: 10,),
                Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ]
            ),
            Divider(),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout
                ),
                SizedBox(width: 10,),
                Text(
                  "Signout",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}