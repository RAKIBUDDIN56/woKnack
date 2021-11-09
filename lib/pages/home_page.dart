import 'package:wo_skills/tabs/home_tab.dart';
import 'package:wo_skills/tabs/friends_tab.dart';
import 'package:wo_skills/tabs/watch_tab.dart';
import 'package:wo_skills/tabs/profile_tab.dart';
import 'package:wo_skills/tabs/notifications_tab.dart';
import 'package:wo_skills/tabs/menu_tab.dart';
import 'package:flutter/material.dart';

class MainScreenTabs extends StatefulWidget {
  const MainScreenTabs({Key key}) : super(key: key);

  @override
  _MainScreenTabsState createState() => _MainScreenTabsState();
}

class _MainScreenTabsState extends State<MainScreenTabs>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int selectedIndex = 0;

  void onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'WoSkills',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          HomeTab(),
          FriendsTab(),
          WatchTab(),
          ProfileTab(),
          NotificationsTab(),
          MenuTab()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30.0,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.flag, size: 30.0), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.ondemand_video, size: 30.0), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, size: 30.0), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications, size: 30.0), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu, size: 30.0), label: ''),
        ],
        unselectedItemColor: Colors.black45,
        selectedItemColor: Colors.blueAccent,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 12.0),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),
    );
  }
}

// //
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(vsync: this, length: 6);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         brightness: Brightness.light,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Text('WoSkills',
//                     style: TextStyle(
//                         color: Colors.blueAccent,
//                         fontSize: 27.0,
//                         fontWeight: FontWeight.bold)),
//               ],
//             ),
//             Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
//               IconButton(
//                   icon: Icon(
//                     Icons.search,
//                     size: 30,
//                     color: Colors.black,
//                   ),
//                   onPressed: () {}),

//               SizedBox(width: 15.0),

//               // Icon(FontAwesomeIcons.facebookMessenger, color: Colors.black)
//             ]),
//           ],
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         bottom: TabBar(
//           indicatorColor: Colors.blueAccent,
//           controller: _tabController,
//           unselectedLabelColor: Colors.blueGrey[600],
//           labelColor: Colors.blueAccent,
//           tabs: [
//             Tab(icon: Icon(Icons.home, size: 30.0)),
//             Tab(icon: Icon(Icons.flag, size: 30.0)),
//             Tab(icon: Icon(Icons.ondemand_video, size: 30.0)),
//             Tab(icon: Icon(Icons.account_circle, size: 30.0)),
//             Tab(icon: Icon(Icons.notifications, size: 30.0)),
//             Tab(icon: Icon(Icons.menu, size: 30.0))
//           ],
//         ),
//       ),
//       body: TabBarView(controller: _tabController, children: [
//         HomeTab(),
//         FriendsTab(),
//         WatchTab(),
//         ProfileTab(),
//         NotificationsTab(),
//         MenuTab()
//       ]),
//     );
//   }
// }
