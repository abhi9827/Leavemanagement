import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:login/screens/Leavepage.dart';
import 'package:login/screens/tab_bar_widget.dart';

import '../providers/auth_provider.dart';

class AdminPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final userData = ref.watch(singleUserStream);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Admin Dashboard'),
            centerTitle: true,
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
                        ' ${data.firstName!}',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    )),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      leading: Icon(Icons.contacts),
                      title: Text(
                          '${data.firstName!} ${data.lastName ?? "Lamichhane"}'),
                    ),
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
                      leading: Icon(Icons.notifications),
                      title: Text('Notice'),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      leading: Icon(Icons.bookmark_sharp),
                      title: Text('Exam'),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      leading: Icon(Icons.holiday_village),
                      title: Text('Holiday'),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        ref.read(authProvider).userLogOut();
                      },
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Sign Out'),
                    ),
                  ],
                );
              },
              error: (err, stack) => Center(child: Text('$err')),
              loading: () => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          body: TabBarView(children: [
            TabBarWidget(Status.pending, true),
            TabBarWidget(Status.accept, true),
            TabBarWidget(Status.reject, true),
          ])),
    );
  }
}
