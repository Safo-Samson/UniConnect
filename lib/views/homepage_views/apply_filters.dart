import 'package:flutter/material.dart';
import 'package:uniconnect/constants/countries_with_flag.dart';
import 'package:uniconnect/constants/course_list.dart';
import 'package:uniconnect/constants/residents.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';
import 'package:uniconnect/widgets/dropdown_with_chip.dart';

// import 'dart:developer' as devtols show log;

class ApplyFilters extends StatefulWidget {
  const ApplyFilters({Key? key}) : super(key: key);

  @override
  State<ApplyFilters> createState() => _ApplyFiltersState();
}

class _ApplyFiltersState extends State<ApplyFilters> {
  late final TextEditingController selectedCourseController;
  late final TextEditingController selectedYearController;

  late final TextEditingController selectedResidentController;
  

  List<String> selectedNationalities = [];
  List<String> selectedCourses = [];
  List<String> selectedYears = [];
  List<String> selectedResidents = [];

  @override
  void initState() {
    selectedCourseController = TextEditingController();
    selectedYearController = TextEditingController();
    selectedResidentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    selectedCourseController.dispose();
    selectedYearController.dispose();
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
                      List<String> parts = value.split(' ');
                      String country = parts.sublist(1).join(' ');
                      selectedNationalities.add(country);
                    }
                  });
                },
                onItemRemoved: (String? value) {
                  setState(() {
                    List<String> parts = value!.split(' ');
                    String country = parts.sublist(1).join(' ');
                    selectedNationalities.remove(country);
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
                onItemRemoved: (String? value) {
                  setState(() {
                    selectedYears.remove(value);
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
                onItemRemoved: (String? value) {
                  setState(() {
                    selectedCourses.remove(value);
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
                onItemRemoved: (String? value) {
                  setState(() {
                    selectedResidents.remove(value);
                    
                  });
                },
              ),
              verticalSpace(20.0),
              ElevatedButton(
                onPressed: () {
                
               
                  Navigator.pushNamed(
                    context,
                    filteredResultsRoute,
                    arguments: [
                      selectedNationalities,
                      selectedResidents,
                      selectedCourses,
                      selectedYears,
                    ],
                  );


                },
                child: const Text(
                  'Apply',
                  style: TextStyle(fontSize: BrandFonts.textButtonSize),
                ),
              ),

              verticalSpace(20.0),
            ],
          ),
        ),
      ),
    );
  }
}
