import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar/controller/auth_controller.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';
import 'package:video_player/video_player.dart';

import '../../utility/app_color.dart';
import '../../utility/assets.dart';
import '../auth/login_screen.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {

  late VideoPlayerController _controller;
  bool _isPlaying = false;


  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() async {
    _controller = VideoPlayerController.asset('assets/images/intro.mp4');
    await _controller.initialize();
    setState(() {
      _isPlaying = true;
      _controller.play();
    });

    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        // Video has finished playing
        print('Video has finished playing');
         if( FirebaseAuth.instance.currentUser != null){
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationScreen()), (route) => false);
         }else{
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogInScreen()), (route) => false);

         }
        // Optionally, you can perform actions here after video finishes
      }
    });

    AuthController.accountRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _isPlaying
              ? VideoPlayer(_controller)
              : Center(child: CircularProgressIndicator()),
          // Optionally, add other widgets on top of the video
        ],
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
