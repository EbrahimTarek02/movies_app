import 'package:flutter/material.dart';
import 'package:movies_app/ui/util/app_colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(color: AppColors.accent,),
        ),
        SizedBox(height: 20.0,),
        Expanded(
          flex: 3,
          child: Container(color: AppColors.bottomNavBarUnSelectedItemColor,),
        ),
        SizedBox(height: 20.0,),
        Expanded(
          flex: 3,
          child: Container(color: AppColors.primary,),
        ),
        SizedBox(height: 20.0,),
      ],
    );
  }
}
