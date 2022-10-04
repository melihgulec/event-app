import 'package:event_app/Components/ItemTileWithIcon.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/RouteNames.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Models/Company.dart';
import 'package:event_app/Services/CompaniesService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CompaniesListScreen extends StatelessWidget {
  CompaniesListScreen({Key key}) : super(key: key);

  EdgeInsets pagePadding = EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: Padding(
        padding: pagePadding,
        child: Column(
          children: [
            FutureBuilder<CompanyBase>(
              future: GetCompanies(),
              builder: (BuildContext context, AsyncSnapshot<CompanyBase> snapshot){
                if(!snapshot.hasData) return CircularProgressIndicator();

                List<Company> companiesList = snapshot.data.data;

                return ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => WhiteSpaceVertical(),
                  itemCount: companiesList.length,
                  itemBuilder: (context, index){
                    Company item = companiesList[index];

                    return ItemTileWithIcon(
                      icon: FaIcon(FontAwesomeIcons.c),
                      title: item.companyName,
                      leftBorderColor: Theme.of(context).primaryColor,
                      onTap: (){
                        Navigator.pushNamed(context, companyRoute, arguments: item);
                      },
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      title: Text(Texts.companies),
    );
  }
}
