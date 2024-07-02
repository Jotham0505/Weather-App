import 'package:flutter/material.dart';
import 'package:weatherapp/constants/app_colors.dart';

class GradientContainer extends StatelessWidget {
  final List<Widget> children;
  const GradientContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              AppColors.black,
              AppColors.secondaryBlack,
              AppColors.secondaryBlack.withOpacity(0.99),
              AppColors.secondaryBlack.withOpacity(0.98),
              AppColors.secondaryBlack.withOpacity(0.97),
              AppColors.secondaryBlack.withOpacity(0.96),
              AppColors.secondaryBlack.withOpacity(0.95),
              AppColors.secondaryBlack.withOpacity(0.94),
              AppColors.secondaryBlack.withOpacity(0.93),
              AppColors.secondaryBlack.withOpacity(0.92),
              AppColors.secondaryBlack.withOpacity(0.91),
              AppColors.secondaryBlack.withOpacity(0.90),
              AppColors.darkBlue,
              AppColors.accentBlue,
              AppColors.lightBlue,
            ]
          )
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 36
          ),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(children),
              )
            ],
          ),
        ),
      ),
    );
  }
}