import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uniconnect/constants/countries_with_flag.dart';
import 'package:uniconnect/constants/course_list.dart';
import 'package:uniconnect/constants/residents.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/services/firestore_functions/add_initial_user_to_users.dart';
import 'package:uniconnect/services/firestore_functions/add_user_to_collection.dart';
import 'package:uniconnect/utils/brand_colours.dart';
import 'package:uniconnect/utils/brand_fonts.dart';
import 'package:uniconnect/utils/dialogs/loading_dialog.dart';
import 'package:uniconnect/utils/spaces.dart';
import 'dart:developer' as devtols show log;

class MoreSignUpInfo extends StatefulWidget {
  const MoreSignUpInfo({super.key});

  @override
  State<MoreSignUpInfo> createState() => _MoreSignUpInfoState();
}

class _MoreSignUpInfoState extends State<MoreSignUpInfo> {
  late final TextEditingController selectedCourseController;
  late final TextEditingController selectedYearController;
  late final TextEditingController dobController;
  late final TextEditingController selectedCountryController;
  late final TextEditingController selectedResidentController;

  // Initialize with the current date
  DateTime selectedDate = DateTime.now();

  bool isSubmitButtonEnabled() {
    return selectedCourseController.text.isNotEmpty &&
        selectedYearController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        selectedCountryController.text.isNotEmpty &&
        selectedResidentController.text.isNotEmpty;
  }

  @override
  void initState() {
    selectedCourseController = TextEditingController();
    selectedCountryController = TextEditingController();
    selectedYearController = TextEditingController();
    dobController = TextEditingController();
    selectedResidentController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    selectedCourseController.dispose();
    selectedYearController.dispose();
    dobController.dispose();
    selectedCountryController.dispose();
    selectedResidentController.dispose();
    super.dispose();
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
              // TextField(
              //   onChanged: (value) {
              //     setState(() {});
              //   },
              //   controller: usernameController,
              //   decoration: const InputDecoration(
              //     hintText: 'username',
              //     border: OutlineInputBorder(),
              //     labelText: 'username',
              //   ),
              // ),
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
                  hintText: 'Select Hall or N/A if not applicable',
                  border: OutlineInputBorder(),
                  labelText: 'Select Hall ',
                ),
                items: allResidents.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  selectedResidentController.text = value ?? '';
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
                    ? () async {
                        // Handle button press

                        final currentUser = AuthService.firebase().currentUser;
                        final userId = currentUser?.id;

                        Map<String, dynamic> dataToUpdate = {
                          'year': selectedYearController.text,
                          'dob': dobController.text,
                          'course': selectedCourseController.text,
                          'nationality': selectedCountryController.text,
                        };

                        if (userId != null) {
                          showLoadingDialog(
                              context: context, text: 'saving data....');
                          await addUserToNationalitySubcollection(
                              userId, selectedCountryController.text);
                          await addUserToResidenceSubcollection(
                              userId, selectedResidentController.text);
                          await addUserToCoursesSubcollection(
                              userId, selectedCourseController.text);
                          await updateUserWithYear(userId, dataToUpdate);
                          await addUserToGeneralCollection(
                              userId,
                              selectedCourseController.text,
                              selectedCountryController.text,
                              selectedResidentController.text,
                              selectedYearController.text);

                          devtols
                              .log('User succesfully added to all collections');
                        } else {
                          devtols.log('User ID is null');
                        }

                        // ignore: use_build_context_synchronously
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
