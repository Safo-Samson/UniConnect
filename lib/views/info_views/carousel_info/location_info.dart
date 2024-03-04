import 'package:flutter/material.dart';
import 'package:uniconnect/views/info_views/carousel_info/template.dart';

class LocationInfo extends CarouselTemplate {
  const LocationInfo(
      {Key? key, required Map widgetData, required bool showLocationToggle})
      : super(
            key: key,
            widgetData: widgetData,
            showLocationToggle: true); // Set showLocationToggle to true
}
