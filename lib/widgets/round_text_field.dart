import 'package:flutter/material.dart';
import 'dart:async';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/screens/Weather_details_screen.dart'; // Update import to correct file name
import 'cities.dart';

class RoundTextField extends StatefulWidget {
  const RoundTextField({
    Key? key,
    this.controller,
  }) : super(key: key);

  final TextEditingController? controller;

  @override
  _RoundTextFieldState createState() => _RoundTextFieldState();
}

class _RoundTextFieldState extends State<RoundTextField> {
  List<String> _filteredCities = [];
  Timer? _debounce;
  bool _isDropdownOpen = false;
  double _dropdownHeight = 0;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onSearchChanged);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _isDropdownOpen = false;
          _dropdownHeight = 0;
        });
      } else {
        _openDropdown();
      }
    });
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onSearchChanged);
    widget.controller?.dispose();
    _debounce?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _filteredCities = cities
            .where((city) =>
                city.toLowerCase().contains(widget.controller?.text.toLowerCase() ?? ''))
            .toList();
        if (_filteredCities.isNotEmpty) {
          _openDropdown();
        } else {
          _closeDropdown();
        }
      });
    });
  }

  void _openDropdown() {
    setState(() {
      _isDropdownOpen = true;
      _dropdownHeight = 150; // Set your desired height here
    });
  }

  void _closeDropdown() {
    setState(() {
      _isDropdownOpen = false;
      _dropdownHeight = 100;
    });
  }

  void _selectCity(String city) {
    widget.controller?.text = city;
    setState(() {
      _filteredCities.clear();
      _isDropdownOpen = false;
      _dropdownHeight = 0;
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
        Stack(
          children: [
            Container(
              height: 47,
              decoration: BoxDecoration(
                color: AppColors.accentBlue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                style: const TextStyle(
                  color: AppColors.white,
                ),
                controller: widget.controller,
                focusNode: _focusNode,
                decoration: const InputDecoration(
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
          ],
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _dropdownHeight,
          color: AppColors.accentBlue,
          child: ListView.builder(
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
