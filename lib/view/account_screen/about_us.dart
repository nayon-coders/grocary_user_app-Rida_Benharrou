import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar/utility/app_const.dart';

import '../../utility/app_color.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        title: Text("À propos de nous"),
        backgroundColor: AppColors.bgWhite,
        leading: InkWell(
            onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back,color:AppColors.textBlack,size: 30,)),

      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(settingCollection).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text("À propos de nous",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  )
                ), 
                SizedBox(height: 20,),
                Text("${snapshot.data!.docs[0].data()["about_us"]}",
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 1.1,
                        wordSpacing: 1.3,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    )
                )
              ],
            ),
          );
        }
      ),

    );
  }
}
