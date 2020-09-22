import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sqflite/sqflite.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:to_do_list_app/Global/Global.dart';
import 'package:to_do_list_app/Loading/UserLoading.dart';
import 'package:to_do_list_app/User/User.dart';

class CreateUserNamePage extends StatefulWidget {
  @override
  _CreateUserNamePageState createState() => _CreateUserNamePageState();
}

class _CreateUserNamePageState extends State<CreateUserNamePage> {
  String userName;

  Global _global;

  final GlobalKey<FormFieldState> userNameKey = GlobalKey<FormFieldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _global = Global.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Welcome to your To Do App',
          style: ThemeProvider.themeOf(context).data.textTheme.headline5,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // height: 200,
            // width: 200,
            //color: Colors.deepPurpleAccent,
            child: Image.asset('assets/Logo/loadingLogo.png'),
            // child: FlatButton(
            //   child: Text("SSSSSSSSSSSSSSss"),
            //   onPressed: () {},
            // ),
          ),
          Padding(
            // title
            padding: EdgeInsets.all(20),
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
                style: ThemeProvider.themeOf(context).data.textTheme.headline2,
                cursorColor: Colors.black,
                key: userNameKey,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: InputBorder.none,
                  labelText: 'What\'s your name?',
                ),
                validator: (String value) {
                  if (_global.nameValidator.hasMatch(value) &&
                      value.isNotEmpty &&
                      value.length <= 25) {
                    userName = value;
                    return null;
                  } else {
                    return 'Invalid Title\n.Maximum 25 alpha-numeric characters allowed.';
                  }
                },
                onFieldSubmitted: (String value) {
                  if (userNameKey.currentState.validate()) {
                    userName = value;
                  }
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Center(
          child: FlatButton(
            child: Text(
              'Update User Name',
              style: ThemeProvider.themeOf(context).data.textTheme.headline4,
            ),
            onPressed: () async {
              if (userNameKey.currentState.validate()) {
                FutureBuilder(
                  future: createUser(User(_global.userID, userName)),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return UserLoadingPage('Creating user name ...');
                    }
                    _global.userName = userName;
                    return this.build(context);
                  },
                );
              } else {
                showSnackBar(
                    _scaffoldKey, 'The username must be validated.');
              }
            },
          ),
        ),
      ),
    );
  }

  Future<User> createUser(User user) async {
    final Database db = _global.database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user;
  }

  void showSnackBar(_scaffoldKey, message) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: Container(
        color: Colors.deepPurpleAccent,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadingText(
              message,
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
}
