import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlowCard extends StatelessWidget {
  String description;
  String startDate;
  String endDate;
  Function onTap;

  FlowCard({Key key, this.description, this.startDate, this.endDate, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height:60,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Text('${startDate.substring(0, 5)}', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(' - '),
                  Text('${endDate.substring(0, 5)}', style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            SizedBox(width: 10,),
            Flexible(
              child: Text('${description}', style: Theme.of(context).textTheme.titleMedium,),
            ),
          ],
        ),
      ),
    );
  }
}
