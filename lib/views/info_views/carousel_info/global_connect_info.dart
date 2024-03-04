import 'package:flutter/material.dart';
import 'package:uniconnect/views/info_views/carousel_info/template.dart';

class GlobalConnect extends CarouselTemplate {
  const GlobalConnect(
      {Key? key, required Map widgetData, required bool showLocationToggle})
      : super(
            key: key,
            widgetData: widgetData,
            showLocationToggle: showLocationToggle);
}
