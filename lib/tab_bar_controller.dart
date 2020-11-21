import 'package:flutter/material.dart';
import 'package:my_certificate/movement_form.dart';
import 'package:my_certificate/user_form.dart';
import 'package:my_certificate/utils.dart';

import 'certificate.dart';

class TabBarController extends StatefulWidget {
  TabBarController({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TabBarController createState() => _TabBarController();
}

class _TabBarController extends State<TabBarController>
    with SingleTickerProviderStateMixin {
  Certificate certificate = new Certificate();
  TabController _tabController;
  int currentTabIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
    currentTabIndex = _tabController.index;
  }

  _handleTabSelection() {
    setState(() {
      currentTabIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    certificate.lastname = "Ovejero";
    certificate.firstname = "Nicolas";
    certificate.birthdate = DateTime(1995, 07, 15);
    certificate.birthplace = "Nantua";
    certificate.address = new Address();
    certificate.address.city = "Villeurbanne";
    certificate.address.zipCode = "69100";
    certificate.address.street = "106 Boulevard du 11 Novembre 1918";
    certificate.type = MovementType.work;
    certificate.creationDateTime = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Utils.hexToColor('#e1000f'),
          tabs: [
            Tab(
                text: 'Utilisateur',
                icon: currentTabIndex == 0
                    ? Icon(Icons.person_pin_rounded)
                    : Icon(Icons.person_pin_outlined)),
            Tab(
                text: 'Motifs',
                icon: currentTabIndex == 1
                    ? Icon(Icons.where_to_vote)
                    : Icon(Icons.where_to_vote_outlined)),
            Tab(
                text: 'Attestations',
                icon: currentTabIndex == 2
                    ? Icon(Icons.insert_drive_file)
                    : Icon(Icons.insert_drive_file_outlined)),
          ],
        ),
        title: Text(widget.title),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(child: UserForm(certificate)),
          SingleChildScrollView(child: MovementForm(certificate)),
          Icon(Icons.directions_transit),
        ],
      ),
    );
  }
}
