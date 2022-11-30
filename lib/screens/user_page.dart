import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:login/screens/Leavepage.dart';
import 'package:login/screens/tab_bar_widget.dart';

import '../providers/auth_provider.dart';

class UserPage extends ConsumerWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final userData = ref.watch(singleUserStream);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Parchi',
            ),
            backgroundColor: Colors.red,
            centerTitle: true,
            actions: [
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    Get.to(() => Leavepage(),
                        transition: Transition.leftToRight);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.local_laundry_service_sharp),
                      Text('Apply Leave'),
                    ],
                  ))
            ],
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 60),
              child: TabBar(tabs: [
                Tab(
                  text: 'Pending',
                ),
                Tab(
                  text: 'Accept',
                ),
                Tab(
                  text: 'Reject',
                ),
              ]),
            ),
          ),
          drawer: Drawer(
              child: userData.when(
                  data: (data) {
                    return ListView(
                      children: [
                        DrawerHeader(
                            child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data.imageUrl!),
                                  fit: BoxFit.cover)),
                          child: Text(
                            data.firstName!,
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          leading: Icon(Icons.mail),
                          title: Text(data.metadata!['email']),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          leading: Icon(Icons.contacts),
                          title: Text(data.firstName!),
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(Leavepage(),
                                transition: Transition.leftToRight);
                          },

                          leading: Icon(Icons.badge_outlined),
                          title: Text('Apply Leave'),
                          //Transition.rightToLeft,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            ref.read(authProvider).userLogOut();
                          },
                          leading: Icon(Icons.exit_to_app),
                          title: Text('Sign Out'),
                        )
                      ],
                    );
                  },
                  error: (err, stack) => Center(child: Text('$err')),
                  loading: () => Center(child: CircularProgressIndicator()))),
          body: TabBarView(children: [
            TabBarWidget(Status.pending, false),
            TabBarWidget(Status.accept, false),
            TabBarWidget(Status.reject, false),
          ])),
    );
  }
}
