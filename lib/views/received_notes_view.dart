import 'dart:async';

import 'package:flutter/material.dart';
import 'collects_view.dart';
import 'coming_binds_view.dart';

import '../services/api_service.dart';
import '../widgets/qr_scanner_widget.dart';
import '../widgets/received_note_list_widget.dart';
import '../models/profile_data.dart';

class ReceivedNotesView extends StatefulWidget {
  const ReceivedNotesView({super.key, required this.profileData});
  final ProfileData profileData;

  @override
  _ReceivedNotesViewState createState() => _ReceivedNotesViewState();
}

class _ReceivedNotesViewState extends State<ReceivedNotesView> {
  final PageController _pageController = PageController(initialPage: 1);
  final ApiService apiService = ApiService();

  Future<Map<String, dynamic>> fetchReceivedNotes() async {
    return apiService.fetchReceivedNotes();
  }
  String? _uniqueId;

  late Future<List<dynamic>> receivedNotesFuture;
  late Future<ProfileData> profileDataFuture;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    late ProfileData profileData = widget.profileData;

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy < -10) {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => QRScannerWidget(profileData: profileData)),
          );
        }
      },
      child: Scaffold(  /* main content */
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            if (index == 0) {} /* coming binds */
            if (index == 1) {
              apiService.fetchProfileData()
              .then((result) {
                setState(() {
                  profileData = result; // Update the profileData and build
                });
              });
            } /* received notes */
            if (index == 2) {} /* received notes */
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            ComingBindsView(data: profileData),
            Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Vouchers',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                automaticallyImplyLeading: false, // Removes the back button
                backgroundColor: const Color(0xFFFED86A),
                titleTextStyle: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 20, fontWeight: FontWeight.bold
                ),
                leading: Builder(
                  builder: (context) {
                    return IconButton(
                      icon: Image.asset(
                        'assets/images/menu.png',
                        width: 30, height: 30,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer(); /* Open the drawer */
                      },
                    );
                  },
                ),
                actions: [
                  IconButton(
                    icon: Image.asset(
                      'assets/images/menu-qrcode.png',
                      width: 28, height: 28,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => QRScannerWidget(profileData: profileData)),
                      );
                    },
                  ),
                ],
              ),  /*  app main bar  */
              backgroundColor: const Color(0xFFF5F5F5),
              drawer: _buildDrawer(context, profileData),
              body: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          minHeight: 60, minWidth: double.infinity, maxWidth: double.infinity,
                        ),
                        child: Column(
                          children: [ /* sub title space */
                            const Padding(
                              padding: EdgeInsets.only(top: 24.0),
                              child: Stack(),
                            ),
                            Text(
                              profileData.uniqueId,
                              style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),  /*  header  */
                      Container(
                        constraints: const BoxConstraints(
                          minWidth: double.infinity,
                          maxWidth: double.infinity,
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('..'),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Stack(),
                                  ),
                                  Text('.'),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Stack(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Stack(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Stack(),
                                  ),
                                  Text('.'),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Stack(),
                                  ),
                                  Text('..'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ReceivedNoteListWidget(profileData: profileData)
                    ],
                  ),
                ],
              ),
            ),
            CollectsView(data: profileData)
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFF5F5F5), currentIndex: _selectedIndex,
          selectedItemColor: Colors.black, items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/resources-006.png',
              width: 24, height: 24,
            ),
            label: '~histórico~',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/resources-019.png',
              width: 24, height: 24,
            ),
            label: '~Vouchers~',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/resources-016.png',
              width: 24, height: 24,
            ),
            label: '~recompensas~',
          ),
        ],
          onTap: _onItemTapped,
        ),
      )
    );
  }

  Drawer _buildDrawer(BuildContext context, profileData) {
    var activeProfile = widget.profileData;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFFED86A)),
              child: Text('v.0.0.1')
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/resources-012.png', width: 32.0, height: 32.0,
              fit: BoxFit.contain,
            ),
            title: const Text('~ Anônimo ~', style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17
            )),
            subtitle: Text(activeProfile.uniqueId, style: const TextStyle(
              fontWeight: FontWeight.w300, fontSize: 12
            )),
            onTap: () {
              Navigator.pop(context);
              /* Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const
                  ReceivedNotesView())
              ); */
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/resources-015.png',
              width: 24.0, // Largura da imagem
              height: 24.0, // Altura da imagem
              fit: BoxFit
                  .contain, // Ajusta o tamanho da imagem conforme necessário
            ),
            title: const Text('Sair',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey)),
            onTap: null,
          ),
        ],
      ),
    );
  }

}

class ProfileDataProvider extends InheritedWidget {
  final ProfileData profileData;

  const ProfileDataProvider({
    super.key, required this.profileData, required super.child,
  });

  static ProfileDataProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProfileDataProvider>();
  }

  @override
  bool updateShouldNotify(ProfileDataProvider oldWidget) {
    return profileData != oldWidget.profileData;
  }
}
