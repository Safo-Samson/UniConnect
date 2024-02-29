import 'package:flutter/material.dart';
import 'package:uniconnect/constants/countries_with_flag.dart';
import 'package:uniconnect/constants/course_list.dart';
import 'package:uniconnect/constants/residents.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/services/firestore_functions/add_initial_user_to_users.dart';
import 'package:uniconnect/services/firestore_functions/add_user_to_collection.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';
import 'package:uniconnect/utils/dialogs/loading_dialog.dart';
import 'package:uniconnect/widgets/dropdown_with_chip.dart';

import 'dart:developer' as devtols show log;

class ApplyFilters extends StatefulWidget {
  const ApplyFilters({Key? key}) : super(key: key);

  @override
  State<ApplyFilters> createState() => _ApplyFiltersState();
}

class _ApplyFiltersState extends State<ApplyFilters> {
  late final TextEditingController selectedCourseController;
  late final TextEditingController selectedYearController;
  late final TextEditingController dobController;
  late final TextEditingController selectedResidentController;

  final TextEditingController selectedUniversityController =
      TextEditingController(text: 'LSBU');

  List<String> selectedNationalities = [];
  List<String> selectedCourses = [];
  List<String> selectedYears = [];
  List<String> selectedResidents = [];

  bool isSubmitButtonEnabled() {
    return selectedCourseController.text.isNotEmpty &&
        selectedYearController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        selectedResidentController.text.isNotEmpty &&
        selectedNationalities.isNotEmpty &&
        selectedCourses.isNotEmpty &&
        selectedYears.isNotEmpty &&
        selectedResidents.isNotEmpty;
  }

  @override
  void initState() {
    selectedCourseController = TextEditingController();
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
    selectedResidentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 8,
        title: const Text(
          'Filters',
          style: TextStyle(
            color: Colors.black,
            fontFamily: BrandFonts.fontFamily,
            fontSize: BrandFonts.h2,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(0, 255, 255, 255),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              verticalSpace(20.0),
              const Text(
                'Filter Search By: ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: BrandFonts.regularText,
                  fontFamily: BrandFonts.fontFamily,
                ),
              ),
              verticalSpace(20.0),
              DropdownWithChip(
                label: 'Nationality',
                selectedValues: selectedNationalities,
                items: allCountriesWithFlags,
                onChanged: (String? value) {
                  setState(() {
                    if (value != null &&
                        !selectedNationalities.contains(value)) {
                      selectedNationalities.add(value);
                    }
                  });
                },
              ),
              verticalSpace(20.0),
              DropdownWithChip(
                label: 'Year of study',
                selectedValues: selectedYears,
                items: const ['1st Year', '2nd Year', '3rd Year'],
                onChanged: (String? value) {
                  setState(() {
                    if (value != null && !selectedYears.contains(value)) {
                      selectedYears.add(value);
                    }
                  });
                },
              ),
              verticalSpace(20.0),
              DropdownWithChip(
                label: 'Course Studying',
                selectedValues: selectedCourses,
                items: courseList,
                onChanged: (String? value) {
                  setState(() {
                    if (value != null && !selectedCourses.contains(value)) {
                      selectedCourses.add(value);
                    }
                  });
                },
              ),
              verticalSpace(20.0),
              DropdownWithChip(
                label: 'Residence Hall',
                selectedValues: selectedResidents,
                items: allResidents,
                onChanged: (String? value) {
                  setState(() {
                    if (value != null && !selectedResidents.contains(value)) {
                      selectedResidents.add(value);
                    }
                  });
                },
              ),
              verticalSpace(20.0),
              ElevatedButton(
                onPressed: isSubmitButtonEnabled()
                    ? () async {
                        // Handle button press

                        final currentUser = AuthService.firebase().currentUser;
                        final userId = currentUser?.uid;

                        Map<String, dynamic> dataToUpdate = {
                          'year': selectedYears,
                          'dob': dobController.text,
                          'course': selectedCourses,
                          'nationality': selectedNationalities
                              .map((e) => e.split(' ')[1])
                              .toList(),
                          'residence': selectedResidents,
                          'flag': selectedNationalities
                              .map((e) => e.split(' ')[0])
                              .toList(),
                        };

                        if (userId != null) {
                          showLoadingDialog(
                              context: context, text: 'saving data....');
                          for (String nationality in selectedNationalities) {
                            await addUserToNationalitySubcollection(
                                userId, nationality);
                          }
                          for (String residence in selectedResidents) {
                            await addUserToResidenceSubcollection(
                                userId, residence);
                          }
                          for (String course in selectedCourses) {
                            await addUserToCoursesSubcollection(userId, course);
                          }
                          await updateUserWithYear(userId, dataToUpdate);

                          devtols.log(
                              'User successfully added to all collections');
                        } else {
                          devtols.log('User ID is null');
                        }

                        // ignore: use_build_context_synchronously
                        Navigator.pushNamedAndRemoveUntil(
                            context, locationInfoRoute, (route) => false);
                      }
                    : null,
                child: const Text('Apply',
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
