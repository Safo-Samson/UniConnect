import 'package:flutter/material.dart';
import 'package:uniconnect/utils/brand_fonts.dart';
import 'package:uniconnect/utils/spaces.dart';

class CarouselTemplate extends StatefulWidget {
  final Map widgetData;

  const CarouselTemplate({Key? key, required this.widgetData})
      : super(key: key);

  @override
  State<CarouselTemplate> createState() => _CarouselTemplateState();
}

class _CarouselTemplateState extends State<CarouselTemplate> {
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
                        fontFamily: BrandFonts.fontFamily),
                  ),
                  verticalSpace(20),
                  Image.asset(widget.widgetData['image'],
                      width: 250, height: 190),
                  verticalSpace(20),
                  Text(widget.widgetData['description'],
                      style: const TextStyle(
                          fontSize: BrandFonts.regularText,
                          fontFamily: BrandFonts.fontFamily)),
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
              child: Text(widget.widgetData['buttonText'],
                  style: const TextStyle(fontSize: BrandFonts.textButtonSize)),
            ),
          ),
        ],
      ),
    );
  }
}
