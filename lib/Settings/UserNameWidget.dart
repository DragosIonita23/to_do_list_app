import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:to_do_list_app/Global/Global.dart';
import 'package:to_do_list_app/Loading/UserLoading.dart';
import 'package:to_do_list_app/User/User.dart';

class UserNameWidget extends StatefulWidget {
  @override
  _UserNameWidgetState createState() => _UserNameWidgetState();
}

class _UserNameWidgetState extends State<UserNameWidget> {
  final GlobalKey<FormFieldState> nameKey = GlobalKey<FormFieldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Global _global;

  @override
  void initState() {
    _global = Global.getInstance();
    super.initState();
  }

  String name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Your profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: ThemeProvider.themeOf(context)
                  .data
                  .textTheme
                  .headline5
                  .fontSize,
              fontWeight: ThemeProvider.themeOf(context)
                  .data
                  .textTheme
                  .headline5
                  .fontWeight,
              fontFamily: ThemeProvider.themeOf(context)
                  .data
                  .textTheme
                  .headline5
                  .fontFamily,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3,
                    right: 10,
                    left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ThemeProvider.themeOf(context).id == 'light_theme'
                          ? Colors.black
                          : Colors.white54,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: _global.userName ?? "",
                    style:
                        ThemeProvider.themeOf(context).data.textTheme.subtitle2,
                    cursorColor: Colors.black,
                    key: nameKey,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: InputBorder.none,
                      labelText: 'User name',
                    ),
                    validator: (String value) {
                      if (_global.nameValidator.hasMatch(value) &&
                          value.isNotEmpty) {
                        name = value;
                        return null;
                      } else {
                        return 'Invalid user name';
                      }
                    },
                    onFieldSubmitted: (String value) {
                      if (nameKey.currentState.validate()) {
                        name = value;
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                child: RaisedButton(
                  color: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Change your profile name',
                    style:
                        ThemeProvider.themeOf(context).data.textTheme.headline2,
                  ),
                  onPressed: () async {
                    if (nameKey.currentState.validate()) {
                      showGeneralDialog(
                        barrierDismissible: false,
                        transitionDuration: Duration(milliseconds: 1),
                        barrierColor: Colors.black12.withOpacity(0.9),
                        context: context,
                        pageBuilder: (a, b, c) => SizedBox.expand(
                          child: UserLoadingPage('Updating your name ...'),
                        ),
                      );
                      await updateName(User(_global.userID, name));
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    } else {
                      errorSnackBar(_scaffoldKey);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void errorSnackBar(_scaffoldKey) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: Container(
        color: Colors.deepPurpleAccent,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadingText(
              'An internal error has occured',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<User> updateName(User user) async {
    await _global.database.update(
      'users',
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
    _global.userName = user.name;
    print(" @@@@@@@ user id: " +
        user.id.toString() +
        " @@ name: " +
        user.name +
        " @@\n");
    return user;
  }
}
