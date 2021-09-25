import 'package:flutter/material.dart';
import 'dart:math' as math;
 import 'package:flutter_svg/flutter_svg.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
     home: ListView (

       children: [

         SettingsnewWidget()
       ]
     
     ,)

    );
    
  }
}
class SettingsnewWidget extends StatelessWidget {
          @override
          Widget build(BuildContext context) {
    
            return Container(
      width: 375,
      height: 667,
      decoration: BoxDecoration(
          color : Color.fromRGBO(239, 239, 239, 1),
  ),
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 0,
        left: 0,
        child: Container(
        width: 375,
        height: 59,
        decoration: BoxDecoration(
          boxShadow : [BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.25),
          offset: Offset(0,3),
          blurRadius: 6
      )],
      color : Color.fromRGBO(255, 255, 255, 1),
  )
      )
      ),

Positioned(
        top: 7,
        left: 150,
        child: Text('Settings', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(235, 113, 0, 1),
        fontFamily: 'Poppins',
        fontSize: 18,
        letterSpacing: 0 ,
        fontWeight: FontWeight.normal,
        height: 2.5
      ),)
      ),Positioned(
        top: 166,
        left: 81,
        child: Container(
      width: 278,
      height: 34,
      decoration: BoxDecoration(
          color : Color.fromRGBO(255, 255, 255, 1),
  ),
      child: Stack(
        children: <Widget>[
          
        ]
      )
    )
      ),
	  
	  Positioned(
        top: 425,
        left: 28,
        child: Container(
      width: 315,
      height: 160,
      
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 0,
        left: 0,
        child: SvgPicture.asset(
        'assets/images/rectangle8.svg',
        semanticsLabel: 'rectangle8'
      )
      ),
	  
	  Positioned(
        top: 1,
        left: 58,
        child: Text('Dark Mode', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'Poppins',
        fontSize: 17,
        letterSpacing: 0 ,
        fontWeight: FontWeight.normal,
        height: 2.6470588235294117
      ),)
      ),
	  Positioned(
        top: 42,
        left: 16,
        child: Text('Turn on dark mode', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(126, 122, 122, 1),
        fontFamily: 'Poppins',
        fontSize: 13,
        letterSpacing: 0,
        fontWeight: FontWeight.normal,
        height: 3.4615384615384617
      ),)
      ),
	  Positioned(
        top: 2,
        left: 19,
        child: Text('brightness_6', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(235, 113, 0, 1),
        fontFamily: 'Material Icons',
        fontSize: 25,
        letterSpacing: 0,
        fontWeight: FontWeight.normal,
        height: 1.8
      ),)
      ),
	  Positioned(
        top: 43,
        left: 251,
        child: Text('toggle_off', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(158, 158, 158, 1),
        fontFamily: 'Material Icons',
        fontSize: 45,
        letterSpacing: 0 ,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),
	  Positioned(
        top: 43,
        left: 14.994873046875,
        child: Transform.rotate(
        angle: 0.20535656333845367 * (math.pi / 180),
        child: Divider(
        color: Color.fromRGBO(187, 187, 187, 1),
        thickness: 1
      )
      ,
      )
      ),
	  Positioned(
        top: 80,
        left: 251,
        child: Text('toggle_on', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(235, 113, 0, 1),
        fontFamily: 'Material Icons',
        fontSize: 45,
        letterSpacing: 0 ,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),
	  Positioned(
        top: 80,
        left: 16,
        child: Text('Turn off dark mode', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(126, 122, 122, 1),
        fontFamily: 'Poppins',
        fontSize: 13,
        letterSpacing: 0 ,
        fontWeight: FontWeight.normal,
        height: 3.4615384615384617
      ),)
      ),
        ]
      )
    )
      ),
	  Positioned(
        top: 250,
        left: 28,
        child: Container(
      width: 315,
      height: 160,
      
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 0,
        left: 0,
        child: SvgPicture.asset(
        'assets/images/notifications.svg',
        semanticsLabel: 'rectangle8'
      )
      ),
	  Positioned(
        top: 4,
        left: 58,
        child: Text('Notifications', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'Poppins',
        fontSize: 17,
        letterSpacing: 0,
        fontWeight: FontWeight.normal,
        height: 2.6470588235294117
      ),)
      ),
	  Positioned(
        top: 3,
        left: 19,
        child: Text('notifications', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(235, 113, 0, 1),
        fontFamily: 'Material Icons',
        fontSize: 25,
        letterSpacing: 0 ,
        fontWeight: FontWeight.normal,
        height: 1.8
      ),)
      ),
	  Positioned(
        top: 62,
        left: 271,
        child: Text('edit', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(146, 146, 146, 1),
        fontFamily: 'Material Icons',
        fontSize: 16,
        letterSpacing: 0 ,
        fontWeight: FontWeight.normal,
        height: 2.8125
      ),)
      ),
	  Positioned(
        top: 50,
        left: 58,
        child: Text('Email', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'Poppins',
        fontSize: 13,
        letterSpacing: 0 ,
        fontWeight: FontWeight.normal,
        height: 3.4615384615384617
      ),)
      ),
	  Positioned(
        top: 74,
        left: 59,
        child: Text('guwop@atlantic.com', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(122, 122, 122, 1),
        fontFamily: 'Poppins',
        fontSize: 11,
        letterSpacing: 0 ,
        fontWeight: FontWeight.normal,
        height: 4.090909090909091
      ),)
      ),
	  Positioned(
        top: 107,
        left: 58,
        child: Text('Push Notification', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'Poppins',
        fontSize: 13,
        letterSpacing: 0 ,
        fontWeight: FontWeight.normal,
        height: 3.4615384615384617
      ),)
      ),
	  Positioned(
        top: 119,
        left: 22,
        child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color : Color.fromRGBO(196, 196, 196, 0),
      border : Border.all(
          color: Color.fromRGBO(0, 0, 0, 1),
          width: 1,
        ),
      borderRadius : BorderRadius.all(Radius.elliptical(20, 20)),
  )
      )
      ),
	  Positioned(
        top: 49,
        left: 13,
        child: Transform.rotate(
        angle: 0.20535656333845367 * (math.pi / 180),
        child: Divider(
        color: Color.fromRGBO(187, 187, 187, 1),
        thickness: 1
      )
      ,
      )
      ),
	  Positioned(
        top: 68,
        left: 27,
        child: SvgPicture.asset(
        'assets/images/ellipse7.svg',
        semanticsLabel: 'ellipse7'
      )
      ),
	  Positioned(
        top: 63,
        left: 22,
        child: SvgPicture.asset(
        'assets/images/ellipse6.svg',
        semanticsLabel: 'ellipse6'
      )
      ),
        ]
      )
    )
      ),
	  Positioned(
        top: 72,
        left: 21,
        child: Container(
      width: 322,
      height: 151,
      
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 0,
        left: 7,
        child: SvgPicture.asset(
        '/assets/images/rectangle8.svg',
        semanticsLabel: 'rectangle8'
      )
      ),
	  Positioned(
        top: 8,
        left: 65,
        child: Text('Localization', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'Poppins',
        fontSize: 17,
        letterSpacing: 0 ,
        fontWeight: FontWeight.normal,
        height: 2.6470588235294117
      ),)
      ),
	  Positioned(
        top: 47,
        left: 0,
        child: Container(
      width: 60,
      height: 42,
      decoration: BoxDecoration(
          
  ),
      child: Stack(
        children: <Widget>[
          
        ]
      )
    )
      ),
	  Positioned(
        top: 7,
        left: 26,
        child: Text('translate', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(235, 113, 0, 1),
        fontFamily: 'Material Icons',
        fontSize: 25,
        letterSpacing: 0 ,
        fontWeight: FontWeight.normal,
        height: 1.8
      ),)
      ),Positioned(
        top: 99,
        left: 29,
        child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color : Color.fromRGBO(196, 196, 196, 0),
      border : Border.all(
          color: Color.fromRGBO(0, 0, 0, 1),
          width: 1,
        ),
      borderRadius : BorderRadius.all(Radius.elliptical(20, 20)),
  )
      )
      ),
	  Positioned(
        top: 53,
        left: 21.994873046875,
        child: Transform.rotate(
        angle: 0.20535656333845367 * (math.pi / 180),
        child: Divider(
        color: Color.fromRGBO(187, 187, 187, 1),
        thickness: 1
      )
      ,
      )
      ),
	  Positioned(
        top: 53,
        left: 66,
        child: Text('Latinica', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'Poppins',
        fontSize: 13,
        letterSpacing: 0 ,
        fontWeight: FontWeight.normal,
        height: 3.4615384615384617
      ),)
      ),
	  Positioned(
        top: 71,
        left: 34,
        child: SvgPicture.asset(
        'assets/images/ellipse4.svg',
        semanticsLabel: 'ellipse4'
      )
      ),
	  Positioned(
        top: 66,
        left: 29,
        child: SvgPicture.asset(
        'assets/images/ellipse3.svg',
        semanticsLabel: 'ellipse3'
      )
      ),
	  Positioned(
        top: 86,
        left: 66,
        child: Text('Ћирилица', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'Poppins',
        fontSize: 13,
        letterSpacing: 0 ,
        fontWeight: FontWeight.normal,
        height: 3.4615384615384617
      ),)
      ),
        ]
      )
    )
      ),
        ]
      )
    );
          }
        }
        

