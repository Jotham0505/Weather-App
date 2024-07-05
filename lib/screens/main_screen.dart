import 'package:flutter/material.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/screens/home_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) { // main screen with get started button
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              AppColors.black,
              AppColors.secondaryBlack,
              AppColors.secondaryBlack.withOpacity(.99),
              AppColors.secondaryBlack.withOpacity(.98),
              AppColors.secondaryBlack.withOpacity(.97),
              AppColors.secondaryBlack.withOpacity(.96),
              AppColors.secondaryBlack.withOpacity(.95),
              AppColors.secondaryBlack.withOpacity(.94),
              AppColors.secondaryBlack.withOpacity(.93),
              AppColors.secondaryBlack.withOpacity(.92),
              AppColors.secondaryBlack.withOpacity(.91),
              AppColors.secondaryBlack.withOpacity(.90),
              AppColors.darkBlue,
              AppColors.accentBlue,
              AppColors.lightBlue,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/02d.png'),
            SizedBox(height: 20),
            Text(
              'Weather Forecast',
              style: TextStyle(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 239, 194, 59), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}