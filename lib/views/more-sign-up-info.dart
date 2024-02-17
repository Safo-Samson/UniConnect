import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uniconnect/constants/countries.dart';
import 'package:uniconnect/constants/countries_with_flag.dart';
import 'package:uniconnect/constants/course_list.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/utils/brand_colours.dart';
import 'package:uniconnect/utils/brand_fonts.dart';
import 'package:uniconnect/utils/spaces.dart';

class MoreSignUpInfo extends StatefulWidget {
  const MoreSignUpInfo({super.key});

  @override
  State<MoreSignUpInfo> createState() => _MoreSignUpInfoState();
}

class _MoreSignUpInfoState extends State<MoreSignUpInfo> {
  final usernameController = TextEditingController();
  final selectedCourseController = TextEditingController();
  final selectedYearController = TextEditingController();
  final dobController = TextEditingController();
  final selectedCountryController = TextEditingController();

  // Initialize with the current date
  DateTime selectedDate = DateTime.now();

  bool isSubmitButtonEnabled() {
    return usernameController.text.isNotEmpty &&
        selectedCourseController.text.isNotEmpty &&
        selectedYearController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        selectedCountryController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              verticalSpace(20.0),
              const Text(
                'Last step!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: BrandFonts.h1,
                  fontFamily: BrandFonts.fontFamily,
                ),
              ),
              verticalSpace(20.0),
              const Text(
                'Fill up these details to complete your registration',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: BrandFonts.regularText,
                  fontFamily: BrandFonts.fontFamily,
                ),
              ),
              verticalSpace(20.0),
              TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: usernameController,
                decoration: const InputDecoration(
                  hintText: 'username',
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
              verticalSpace(20.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  hintText: 'Select Course',
                  border: OutlineInputBorder(),
                  labelText: 'Select Course',
                ),
                items: courseList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  selectedCourseController.text = value ?? '';
                  setState(() {});
                },
              ),
              verticalSpace(20.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  hintText: 'Select Year',
                  border: OutlineInputBorder(),
                  labelText: 'Select Year',
                ),
                items: <String>['1st Year', '2nd Year', '3rd Year']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  selectedYearController.text = value ?? '';
                  setState(() {});
                },
              ),
              verticalSpace(20.0),
              TextField(
                onChanged: (value) {
                  setState(() {});
                },
                readOnly: true,
                controller: dobController,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    setState(() {
                      selectedDate = pickedDate;
                      dobController.text = DateFormat('dd/MM/yyyy')
                          .format(selectedDate.toLocal());
                    });
                  }
                },
                decoration: const InputDecoration(
                  hintText: '12/07/2002',
                  border: OutlineInputBorder(),
                  labelText: 'Date of Birth',
                ),
              ),
              verticalSpace(20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Nationality',
                    style: TextStyle(
                      fontSize: BrandFonts.regularText,
                      fontFamily: BrandFonts.fontFamily,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, whyNationalityRoute);
                    },
                    child: Text(
                      'why this?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: BrandColor.infoLinks,
                        decoration: TextDecoration.underline,
                        fontFamily: BrandFonts.fontFamily,
                        fontSize: BrandFonts.regularText,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(10.0),
              // DropdownButtonFormField<String>(
              //   isExpanded: true,
              //   decoration: const InputDecoration(
              //     hintText: 'Select a Country',
              //     border: OutlineInputBorder(),
              //     labelText: 'Select a Country',
              //   ),
              //   items: allCountries.map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   onChanged: (String? value) {
              //     selectedCountryController.text = value ?? '';
              //     setState(() {});
              //   },
              // ),

              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: const InputDecoration(
                  hintText: 'Select a Country',
                  border: OutlineInputBorder(),
                  labelText: 'Select a Country',
                ),
                items: allCountriesWithFlags.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  selectedCountryController.text = value ?? '';
                  setState(() {});
                },
              ),
              verticalSpace(20.0),
              ElevatedButton(
                onPressed: isSubmitButtonEnabled()
                    ? () {
                        // Handle button press
                        Navigator.pushNamedAndRemoveUntil(
                            context, locationInfoRoute, (route) => false);
                      }
                    : null,
                child: const Text('Submit',
                    style: TextStyle(fontSize: BrandFonts.textButtonSize)),
              ),
              verticalSpace(20.0),
            ],
          ),
        ),
      ),
    );
  }
}
