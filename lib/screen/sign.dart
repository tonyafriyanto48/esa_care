import 'package:esa_care_fix/screen/register.dart';
import 'package:flutter/material.dart';
import 'package:esa_care_fix/constants.dart';


final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String email = "";
  String password = "";
  Future<logindao>? _logindao;

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

Future<logindao> sendData(String email, String password) async {
    var formData = FormData.fromMap({
      'email': email,
      'pass': password,
    });
    var response =
        await Dio().post('https://api.my.id/ej/masuk.php', data: formData);
    print(response.data);
    print(response.statusCode);
        if (response.statusCode == 200) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          var data = logindao.fromJson(jsonDecode(response.data));
    print("token ${data.token}");
    print("token ${data.status}");
    setToken(data.token ?? "");

      return data;
       } 
       else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
         throw Exception('Failed to create album.');
  }
  }

   FutureBuilder<logindao> buildFutureBuilder() {
    return FutureBuilder<logindao>(
      future: _logindao,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //return Text(snapshot.data!.title);
          if (snapshot.data!.token != null) {
            print("masuk sini pindah route");
           Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Homescreen(),
                                  ),
                                );
          }
        } else if (snapshot.hasError) {
          print("error snapshit");
        }
        

        return const CircularProgressIndicator();
      },
    );
  }

   _onCustomAnimationAlertPressed(context) {
    Alert(
      context: context,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      alertAnimation: fadeAlertAnimation,
    ).show();
  }

   Widget fadeAlertAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),

    );
  }

   _onAlertButtonPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Login Gagal",
      desc: "silahkan masukan ulang email atau kata sandi anda",
      buttons: [
        DialogButton(
          child: Text(
            "Oke",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
             Navigator.of(context).pop();
          },
          width: 120,
        )
      ],
    ).show();
  }
class TampilanLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorPalette.primaryColor,
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  _iconLogin(),
                  _titleDesc(),
                  _textField(),
                  _buildButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconLogin() {
    return Image.asset(
      "assets/kecil esa care 1.png",
      height: 150.0,
      width: 150.0,
    );
  }

  Widget _titleDesc() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16.0),
        ),
        Text(
          "Login",
          style: TextStyle(
            color: Colors.blueAccent[400],
            fontSize: 25.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0),
        ),
      ],
    );
  }

  Widget _textField() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
        ),
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorPalette.underlineTextField,
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueAccent,
                width: 3.0,
              ),
            ),
            hintText: "Username or Email",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          style: TextStyle(color: Colors.white70),
          autofocus: false,
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0),
        ),
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorPalette.underlineTextField,
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white70,
                width: 3.0,
              ),
            ),
            hintText: "Password",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          style: TextStyle(color: Colors.white12),
          obscureText: true,
          autofocus: false,
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16.0),
        ),
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            width: double.infinity,
            child: Text(
              'Login',
              style: TextStyle(color: ColorPalette.primaryColor),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent[400],
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.0),
        ),
        Text(
          'atau',
          style: TextStyle(
            color: Colors.blueAccent[400],
            fontSize: 12.0,
          ),
        ),
        FlatButton(
          child: Text(
            'Register',
            style: TextStyle(color: Colors.blueAccent[400]),
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/");
          },
        ),
      ],
    );
  }
}
