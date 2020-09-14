import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../providers/schedule_provider.dart';
import 'schedule_card.dart';
import '../../models/schedule.dart';

class ScheduleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (ctx, scheduleData, _) => GroupedListView<Schedule, DateTime>(
        floatingHeader: true,
        addAutomaticKeepAlives: false,
        useStickyGroupSeparators: true,
        elements: scheduleData.items,
        groupBy: (element) =>
            DateTime(element.date.year, element.date.month, element.date.day),
        groupSeparatorBuilder: (groupByValue) =>
            _buildSeparator(context, groupByValue),
        indexedItemBuilder: (context, schedule, index) => ScheduleCard(
          id: schedule.id,
          date: schedule.date,
          couple: schedule.couple,
          lesson: schedule.lesson,
          type: schedule.type,
          teacher: schedule.teacher,
          room: schedule.room,
        ),
      ),
    );
  }
}

Widget _buildSeparator(BuildContext context, dynamic date) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      height: 30,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  color: Theme.of(context).canvasColor,
                  border: Border.all(
                    width: 0.5,
                    color: Theme.of(context).dividerColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  child: Text(
                    '${toBeginningOfSentenceCase(DateFormat.EEEE('Ru').format(date))}, ${DateFormat('dd.MM.yyyy').format(date)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).iconTheme.color),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
