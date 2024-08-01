import 'package:flutter/material.dart';

import '../../../utility/fontsize.dart';

class SelectPaymentMethod extends StatelessWidget {
  const SelectPaymentMethod({super.key, required this.callback});

  final Function(String) callback;


  @override
  Widget build(BuildContext context) {

    List _paymentMethod = [
    "Virement",
     "Prélévement SEPA"
    ];

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
                itemCount: _paymentMethod.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      callback(_paymentMethod[index]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.grey)
                      ),
                      child: ListTile(
                        title: Text("${_paymentMethod[index]}"),
                        //subtitle: Text("Vous pouvez payer lorsque vous recevez le produit."),
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
