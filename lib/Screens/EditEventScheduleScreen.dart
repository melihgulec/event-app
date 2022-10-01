import 'package:date_time_picker/date_time_picker.dart';
import 'package:event_app/Components/TextFieldWithIcon.dart';
import 'package:event_app/Components/WhiteSpaceVertical.dart';
import 'package:event_app/Constants/Texts.dart';
import 'package:event_app/Helpers/SizeConfig.dart';
import 'package:event_app/Models/Event.dart';
import 'package:event_app/Models/EventSchedule.dart';
import 'package:event_app/Services/EventScheduleService.dart';
import 'package:flutter/material.dart';

class EditEventScheduleScreen extends StatefulWidget {
  Event event;
  EventSchedule eventSchedule;

  EditEventScheduleScreen({Key key, this.eventSchedule, this.event}) : super(key: key);

  @override
  State<EditEventScheduleScreen> createState() => _EditEventScheduleScreenState();
}

class _EditEventScheduleScreenState extends State<EditEventScheduleScreen> {
  EdgeInsets pagePadding = EdgeInsets.all(8);
  TextEditingController startDate = TextEditingController(text: '');
  TextEditingController endDate = TextEditingController(text: '');

  TextEditingController descriptionController = TextEditingController(text: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startDate.text = widget.eventSchedule.startDate;
    endDate.text = widget.eventSchedule.endDate;
    descriptionController.text = widget.eventSchedule.description;
  }

  editSchedule(){
    PutEventSchedule(widget.event.id, EventSchedule(
      id: widget.eventSchedule.id,
      endDate: endDate.text,
      startDate: startDate.text,
      description: descriptionController.text,
    ));
  }

  deleteSchedule(){
    DeleteEventSchedule(widget.event.id, widget.eventSchedule);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: Padding(
        padding: pagePadding,
        child: Column(
          children: [
            DateTimePicker(
              controller: startDate,
              type: DateTimePickerType.time,
              timeLabelText: Texts.pickStartTime,
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                setState(() {
                  startDate.text = value;
                });
              },
            ),
            WhiteSpaceVertical(),
            DateTimePicker(
              controller: endDate,
              type: DateTimePickerType.time,
              timeLabelText: Texts.pickEndTime,
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                setState(() {
                  endDate.text = value;
                });
              },
            ),
            WhiteSpaceVertical(),
            TextFieldWithIcon(
              prefixIcon: Icons.description,
              placeholder: Texts.description,
              controller: descriptionController,
            ),
            WhiteSpaceVertical(),
            Container(
              width: SizeConfig.screenWidth,
              height: 55,
              child: ElevatedButton(
                onPressed: editSchedule,
                child: Text(
                  Texts.edit,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            WhiteSpaceVertical(),
            Container(
              width: SizeConfig.screenWidth,
              height: 55,
              child: ElevatedButton(
                onPressed: deleteSchedule,
                child: Text(
                  Texts.deleteSchedule,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      title: Text(Texts.editSchedule),
    );
  }
}
