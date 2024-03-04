import 'package:flutter/material.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';


class CarouselTemplate extends StatefulWidget {
  final Map widgetData;
  final bool showLocationToggle; // Add this parameter

  const CarouselTemplate({
    Key? key,
    required this.widgetData,
    this.showLocationToggle = false, // Set default value to false
  }) : super(key: key);

  @override
  State<CarouselTemplate> createState() => _CarouselTemplateState();
}

class _CarouselTemplateState extends State<CarouselTemplate> {
  bool locationEnabled = false; // State variable to track location toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // No shadow
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(
                    widget.widgetData['title'],
                    style: const TextStyle(
                      fontSize: BrandFonts.h1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpace(20),
                  Image.asset(
                    widget.widgetData['image'],
                    width: 250,
                    height: 190,
                  ),
                  verticalSpace(20),
                  Text(
                    widget.widgetData['description'],
                    style: const TextStyle(
                      fontSize: BrandFonts.regularText,
                      height: 1.3,
                    ),
                  ),
                  verticalSpace(20),
                  if (widget
                      .showLocationToggle) // Render location toggle conditionally
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // Set background color
                        borderRadius:
                            BorderRadius.circular(10), // Apply border radius
                      ),
                      padding: const EdgeInsets.all(8), // Add padding
                      child: SwitchListTile(
                        title: const Text(
                          'Enable Location',
                          style: TextStyle(
                              color: Colors.black87), // Set text color
                        ),
                        value: locationEnabled,
                        onChanged: (value) {
                          setState(() {
                            locationEnabled = value;
                          });
                        },
                        activeColor:
                            BrandColor.primary, // Set color when switch is ON
                        inactiveThumbColor:
                            BrandColor.grey, // Set color for inactive thumb
                        inactiveTrackColor:
                            Colors.white, // Set color for inactive track
                      ),
                    ),

                  verticalSpace(20),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, widget.widgetData['buttonRoute']);
              },
              child: Text(
                widget.widgetData['buttonText'],
                style: const TextStyle(
                  fontSize: BrandFonts.textButtonSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
