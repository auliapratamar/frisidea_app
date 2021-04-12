import 'package:flutter/material.dart';
class BottomSheetsFit extends StatelessWidget {
  final List<Widget> children;
  final String title, subTitle, toolTipMessage;
  final Alignment titleAlignment;
  final double marginHeight;
  final Widget iconTitle;

  BottomSheetsFit(
      {@required this.children,
        this.titleAlignment = Alignment.topLeft,
        this.iconTitle,
        this.toolTipMessage,
        this.title: '',
        this.subTitle: '',
        this.marginHeight = 20});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: titleAlignment,
                  child: iconTitle == null
                      ? Text(
                    title,
                  )
                      : Row(
                    children: [
                      iconTitle,
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        title,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0.0),
                width: 30.0,
                child: IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(Icons.close),
                  color: Colors.grey,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          SizedBox(height: marginHeight),
          ...children ?? [SizedBox()],
        ],
      ),
    );
  }
}