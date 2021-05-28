import 'package:flutter/material.dart';
import 'package:uts_akb/utils/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:uts_akb/widget/profileitem.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class Setting extends StatelessWidget {
  const Setting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                AvatarImage(),
                SizedBox(
                  height: 30,
                ),
                SocialIcons(),
                SizedBox(height: 30),
                Text(
                  'Milzan Malik',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins"),
                ),
                Text(
                  '@Skyleaft',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 15),
                Text(
                  'FullStack Developer',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
                ),
                SizedBox(height: 30),
                ProfileListItems(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

BoxDecoration avatarDecoration = BoxDecoration(
    shape: BoxShape.circle,
    color: Constants.primaryColor,
    boxShadow: [
      BoxShadow(
        color: Colors.white,
        offset: Offset(10, 10),
        blurRadius: 10,
      ),
      BoxShadow(
        color: Colors.white,
        offset: Offset(-10, -10),
        blurRadius: 10,
      ),
    ]);

class AvatarImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: EdgeInsets.all(8),
      decoration: avatarDecoration,
      child: Container(
        decoration: avatarDecoration,
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/ppall(3).jpg'),
            ),
          ),
        ),
      ),
    );
  }
}

class SocialIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialIcon(
          color: Color(0xFF102397),
          iconData: FlutterIcons.facebook_f_faw,
          onPressed: () {
            _launchURL("https://www.facebook.com/milzanmlk");
          },
        ),
        SocialIcon(
          color: Color(0xFF3C3C3D),
          iconData: FlutterIcons.github_ant,
          onPressed: () {
            _launchURL("https://github.com/Skyleaft");
          },
        ),
        SocialIcon(
          color: Color(0xFF38A1F3),
          iconData: FlutterIcons.twitter_ant,
          onPressed: () {
            _launchURL("https://twitter.com/milzanmlk");
          },
        ),
        SocialIcon(
          color: Color(0xFF2867B2),
          iconData: FlutterIcons.linkedin_ent,
          onPressed: () {
            _launchURL("https://www.linkedin.com/in/milzan-malik-407454189/");
          },
        )
      ],
    );
  }
}

_launchURL(String _url) async {
  await FlutterWebBrowser.openWebPage(
    url: _url,
    customTabsOptions: CustomTabsOptions(
      colorScheme: CustomTabsColorScheme.dark,
      toolbarColor: Constants.primaryColor,
      addDefaultShareMenuItem: true,
      instantAppsEnabled: true,
      showTitle: true,
      urlBarHidingEnabled: true,
    ),
    safariVCOptions: SafariViewControllerOptions(
      barCollapsingEnabled: true,
      preferredBarTintColor: Colors.green,
      dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      modalPresentationCapturesStatusBarAppearance: true,
    ),
  );
}

class SocialIcon extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final Function onPressed;

  SocialIcon({this.color, this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: RawMaterialButton(
          shape: CircleBorder(),
          onPressed: onPressed,
          child: Icon(iconData, color: Colors.white),
        ),
      ),
    );
  }
}

class ProfileListItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ProfileListItem(
          icon: FlutterIcons.user_shield_faw5s,
          text: 'Privacy',
        ),
        ProfileListItem(
          icon: FlutterIcons.history_faw,
          text: 'Purchase History',
        ),
        ProfileListItem(
          icon: FlutterIcons.help_box_mco,
          text: 'Help & Support',
        ),
        ProfileListItem(
          icon: FlutterIcons.sign_out_faw,
          text: 'Logout',
        ),
      ],
    );
  }
}
