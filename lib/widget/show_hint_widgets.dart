import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_tooltip/super_tooltip.dart';


class ShowHint extends StatefulWidget {
  final String hintText;
  final Widget child;

  ShowHint({super.key, required this.hintText, required this.child});

  @override
  State<ShowHint> createState() => _ShowHintState();
}

class _ShowHintState extends State<ShowHint> {
  final _controller = SuperTooltipController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  //  getHintData();
    _controller.showTooltip();
  }

  getHintData()async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print("_pref.getString --- ${_pref.getString("location_hint")}");
    if(_pref.getString("location_hint") != null ){
      _controller.hideTooltip();
    }else{
      _controller.showTooltip();
      _saveToPreferences("location_hint", "1");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return SuperTooltip(
      controller: _controller,
      content: Text("${widget.hintText}",
        softWrap: true,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      child: widget.child,
      backgroundColor: Colors.black,
    );
  }

  void _saveToPreferences(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$key', "$value");
  }
}
