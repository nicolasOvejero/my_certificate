import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_certificate/models/certificate.dart';
import 'package:my_certificate/views/certificate_view.dart';
import 'package:my_certificate/map_page.dart';
import 'package:my_certificate/views/movement_form.dart';
import 'package:my_certificate/services/storage_service.dart';
import 'package:my_certificate/views/user_form.dart';

class TabBarController extends StatefulWidget {
  TabBarController({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TabBarController createState() => _TabBarController();
}

class _TabBarController extends State<TabBarController>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int currentTabIndex;
  Certificate certificate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
    currentTabIndex = _tabController.index;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getCertificate();
    return Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Theme.of(context).accentColor,
                  tabs: [
                    Tab(
                        text: AppLocalizations.of(context).user,
                        icon: currentTabIndex == 0
                            ? Icon(Icons.person_pin_rounded)
                            : Icon(Icons.person_pin_outlined)),
                    Tab(
                        text: AppLocalizations.of(context).reason,
                        icon: currentTabIndex == 1
                            ? Icon(Icons.where_to_vote)
                            : Icon(Icons.where_to_vote_outlined)),
                    Tab(
                        text: AppLocalizations.of(context).certificate,
                        icon: currentTabIndex == 2
                            ? Icon(Icons.insert_drive_file)
                            : Icon(Icons.insert_drive_file_outlined)),
                  ],
                ),
                title: Text(widget.title),
                actions: <Widget>[
                  certificate != null ? IconButton(
                    icon: Icon(Icons.map_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapPage(certificate)),
                      );
                    },
                  ) : Container()
                ],
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  UserForm(_checkTabBarPosition),
                  MovementForm(_checkTabBarPosition),
                  CertificateView(_checkTabBarPosition),
                ],
              ),
            );
  }

  void _handleTabSelection() {
    setState(() {
      currentTabIndex = _tabController.index;
    });
  }

  void _checkTabBarPosition(int position) {
    setState(() {
      _tabController.index = position;
    });
  }

  void _getCertificate() async {
    certificate = await StorageService.getStoredCertificate();
    if (certificate.isEmpty()) {
      certificate = null;
    }
    setState(() {});
  }
}
