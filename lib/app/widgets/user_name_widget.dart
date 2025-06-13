import 'package:flutter/material.dart';

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    bool isHossein = userName.toLowerCase() == 'hossein';
    Color containerColor = isHossein ? Colors.black : Colors.white;
    Color textColor = isHossein ? Colors.white : Colors.black;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 3, bottom: 5),
      decoration: BoxDecoration(
        color: containerColor.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        '${userName}',
        style:
            Theme.of(context).textTheme.labelMedium?.copyWith(color: textColor),
      ),
    );
  }
}
