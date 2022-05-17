import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Models/Company.dart';
import 'package:event_app/Screens/CompanyDetailScreen.dart';
import 'package:event_app/Screens/CompanySponsorshipsScreen.dart';
import 'package:flutter/material.dart';

class CompanyScreen extends StatefulWidget {
  Company company;

  CompanyScreen({
    Key key,
    this.company,
  }) : super(key: key);

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CreateAppBar(),
        body: TabBarView(
          children: [
            CompanyDetailScreen(company: widget.company,),
            CompanySponsorshipsScreen(company: widget.company),
          ],
        ),
      ),
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      title: Text(Texts.company),
      bottom: TabBar(
        tabs: [
          Tab(
            text: Texts.details,
          ),
          Tab(
            text: Texts.sponsorships,
          ),
        ],
      ),
    );
  }
}
