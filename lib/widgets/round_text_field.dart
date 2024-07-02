import 'package:flutter/material.dart';
import 'dart:async';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/screens/Wether_details_screen.dart';
import 'cities.dart';

class RoundTextField extends StatefulWidget {
  const RoundTextField({
    super.key,
    this.controller,
  });

  final TextEditingController? controller;

  @override
  _RoundTextFieldState createState() => _RoundTextFieldState();
}

class _RoundTextFieldState extends State<RoundTextField> {
  List<String> _filteredCities = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onSearchChanged);
    widget.controller?.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _filteredCities = cities
            .where((city) => city.toLowerCase().contains(widget.controller?.text.toLowerCase() ?? ''))
            .toList();
      });
    });
  }

  void _selectCity(String city) {
    widget.controller?.text = city;
    setState(() {
      _filteredCities.clear();
    });
    // Navigate to the weather details screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WeatherDetailScreen(cityName: city),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 55,
          decoration: BoxDecoration(
            color: AppColors.accentBlue,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextField(
            style: const TextStyle(
              color: AppColors.white,
            ),
            controller: widget.controller,
            decoration: const InputDecoration(
              fillColor: Colors.white,
              focusColor: Colors.white,
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.grey,
              ),
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        if (_filteredCities.isNotEmpty)
          Container(
            color: AppColors.accentBlue,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredCities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _filteredCities[index],
                    style: TextStyle(color: AppColors.white),
                  ),
                  onTap: () {
                    _selectCity(_filteredCities[index]);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
