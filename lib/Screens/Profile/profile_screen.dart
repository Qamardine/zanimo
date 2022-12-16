import 'package:flutter/material.dart';
import 'package:zanimo/Screens/Profile/add_zone_screen.dart';
import '../../../constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 48,
                  backgroundImage: AssetImage('assets/images/zenitsu.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Zenitsu Agatsuma',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                    title: Text('Gestion des colliers'),
                    subtitle: Text('Ajout et suppression'),
                    leading: Image.asset(
                      'assets/images/home.png',
                      fit: BoxFit.scaleDown,
                      width: 30,
                      height: 30,
                    ),
                    trailing:
                        Icon(Icons.chevron_right, color: kPrimaryLightColor),
                    onTap: () => Navigator.of(context)
                    // .push(MaterialPageRoute(builder: (_) => SettingsPage())),
                    ),
                Divider(),
                ListTile(
                  title: Text('Définir une zone d\'alerte'),
                  leading: Image.asset('assets/images/settings.png'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: kPrimaryLightColor,
                  ),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ChangePasswordPage())),
                ),
                Divider(),
                ListTile(
                    title: Text('Aide et support'),
                    leading: Image.asset('assets/images/support.png'),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: kPrimaryLightColor,
                    ),
                    onTap: () => Navigator.of(context)
                    // .push(MaterialPageRoute(builder: (_) => SettingsPage())),
                    ),
                Divider(),
                ListTile(
                    title: Text('FAQ'),
                    subtitle: Text('Questions and réponses'),
                    leading: Image.asset('assets/images/faq.png'),
                    trailing:
                        Icon(Icons.chevron_right, color: kPrimaryLightColor),
                    onTap: () => Navigator.of(context)
                    // .push(MaterialPageRoute(builder: (_) => FaqPage())),
                    ),
                Divider(),
                ListTile(
                    title: Text('Déconnexion'),
                    leading: Image.asset('assets/images/sign_out.png'),
                    trailing:
                        Icon(Icons.chevron_right, color: kPrimaryLightColor),
                    onTap: () => Navigator.of(context)
                    // .push(MaterialPageRoute(builder: (_) => FaqPage())),
                    ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
