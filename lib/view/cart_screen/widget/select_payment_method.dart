import 'package:flutter/material.dart';

import '../../../utility/fontsize.dart';

class SelectPaymentMethod extends StatelessWidget {
  const SelectPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: AlertDialog(
        backgroundColor: Colors.white,
           titlePadding: EdgeInsets.zero,
           insetPadding: EdgeInsets.zero, // Removes padding
          contentPadding: EdgeInsets.zero,
          iconPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
        content: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30,),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text('Sélectionnez le mode de paiement'),
              automaticallyImplyLeading: false, // Hides back button
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: ()=>Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.grey)
                      ),
                      child: ListTile(
                        title: Text("Paiement à la livraison (COD)"),
                        subtitle: Text("Vous pouvez payer lorsque vous recevez le produit."),
                      ),
                    ),
                  );
                },
              ),
            )
          ),
        ),
      ),
    );
  }
}
