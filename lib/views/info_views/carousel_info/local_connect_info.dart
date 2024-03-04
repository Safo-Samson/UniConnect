import 'package:flutter/material.dart';
import 'package:uniconnect/views/info_views/carousel_info/template.dart';

class LocalConnect extends CarouselTemplate {
  const LocalConnect(
      {Key? key, required Map widgetData, required bool showLocationToggle})
      : super(
            key: key,
            widgetData: widgetData,
            showLocationToggle: showLocationToggle);
}
