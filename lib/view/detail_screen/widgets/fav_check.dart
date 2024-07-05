import 'package:flutter/material.dart';

import '../../../controller/favourite_controller.dart';
import '../../../utility/app_color.dart';


class FavWidgets extends StatelessWidget {
  final String id;
  const FavWidgets({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FavouriteController.getFavouriteLise(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }

        bool isAvailAvail = false;
        var docId;
        for(var i in snapshot.data!.docs){
          if(i.data()["id"] == id.toString()){
            isAvailAvail = true;
            docId = i.id;
          }
        }
        return InkWell(
            onTap: (){
              isAvailAvail ?  FavouriteController.removeFavouriteList( context, docId.toString(),): FavouriteController.addFavourite(id.toString(), context);
            },
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 1, spreadRadius: 1
                    )
                  ]
                ),
                child: isAvailAvail? Icon( Icons.favorite,color: Colors.red,) :  Icon( Icons.favorite_border,color: Colors.pink,)));
      }
    );
  }
}
