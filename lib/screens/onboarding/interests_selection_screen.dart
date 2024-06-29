import 'package:compus_map/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../models/models.dart';
import '../../utils/utils.dart';

class InterestsSelectionScreen extends StatefulWidget {
  const InterestsSelectionScreen({super.key});

  @override
  State<InterestsSelectionScreen> createState() =>
      _InterestsSelectionScreenState();
}

class _InterestsSelectionScreenState extends State<InterestsSelectionScreen> {
  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).colorScheme.primary,
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Interests Selection',
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            children: [
              Text(
                'Select your interests to get personalized event suggestions',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                )
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 12,
                child: SingleChildScrollView(
                  child: MultiSelectContainer(
                    items: Interest.interestsList.map((e) {
                      return MultiSelectCard(
                        value: e.name,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          child: FittedBox(
                            child: Text(e.name),
                          ),
                        ),
                      );
                    }).toList(),
                    onChange: (allSelectedItems, selectedItem) {
                      setState(() {
                        if (allSelectedItems.isNotEmpty) {
                          isSelect = true;
                        } else {
                          isSelect = false;
                        }
                      });
                    },
                    textStyles: MultiSelectTextStyles(
                      textStyle: Theme.of(context).textTheme.titleSmall,
                      selectedTextStyle: Theme.of(context).textTheme.titleSmall,
                    ),
                    itemsDecoration: MultiSelectDecorations(
                      selectedDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    maxSelectableCount: 5,
                    onMaximumSelected: (allSelectedItems, selectedItem) {
                      Fluttertoast.showToast(
                        msg: "The limit has been reached".tr,
                      );
                    },
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              PrimaryButton(
                onTap: !isSelect
                    ? null
                    : () {
                        Get.toNamed(Routes.signup);
                      },
                text: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
