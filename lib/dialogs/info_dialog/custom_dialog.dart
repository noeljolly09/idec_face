import 'package:flutter/material.dart';

class InfoDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  // final Image img;

  final VoidCallback? onPressedBttn1;
  final VoidCallback? onPressedBttn2;
  final String bttnText1;
  final String bttnText2;
  final bool isCancelButtonVisible;
  

  const InfoDialogBox({
    Key? key,
    required this.title,
    required this.descriptions,
    required this.text,
    // this.img,
    required this.onPressedBttn1,
    this.onPressedBttn2,
    required this.bttnText1,
    required this.bttnText2,
    required this.isCancelButtonVisible,
  }) : super(key: key);

  @override
  _InfoDialogBoxState createState() => _InfoDialogBoxState();
}

class _InfoDialogBoxState extends State<InfoDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(left: 20, top: 45.0, right: 20, bottom: 20),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              widget.isCancelButtonVisible
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: SizedBox(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(90, 40),
                                    primary: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: widget.onPressedBttn1,
                                  child: Text(
                                    widget.bttnText1,
                                    style: Theme.of(context).textTheme.button,
                                  )),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: SizedBox(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(90, 40),
                                    primary: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: widget.onPressedBttn2,
                                  child: Text(
                                    widget.bttnText2,
                                    style: Theme.of(context).textTheme.button,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(80, 40),
                              primary: Theme.of(context).primaryColor,
                            ),
                            onPressed: widget.onPressedBttn1,
                            child: Text(
                              widget.text,
                              style: Theme.of(context).textTheme.button,
                            )),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}