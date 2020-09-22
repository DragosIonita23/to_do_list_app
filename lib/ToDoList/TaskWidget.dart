import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:to_do_list_app/Task/Task.dart';

class TaskWidget extends StatefulWidget {

  final Task task;

  TaskWidget(this.task, {Key key}) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState(task);

}

class _TaskWidgetState extends State<TaskWidget> {

  Task task;

  _TaskWidgetState(this.task);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Title',
                        style: ThemeProvider.themeOf(context).data.textTheme.headline3,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        task.title,
                        style: ThemeProvider.themeOf(context).data.textTheme.headline2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Category',
                        style: ThemeProvider.themeOf(context).data.textTheme.headline3,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        task.category,
                        style: ThemeProvider.themeOf(context).data.textTheme.headline2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Description',
                        style: ThemeProvider.themeOf(context).data.textTheme.headline3,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        task.description,
                        style: ThemeProvider.themeOf(context).data.textTheme.headline2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
