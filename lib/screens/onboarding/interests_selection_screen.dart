import 'package:flutter/material.dart';
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
  List<bool> isChecked =
      List<bool>.filled(Interest.interestsList.length, false);
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Text(
                'Select your interests to get personalized event suggestions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 26,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 12,
                child: ListView.builder(
                  itemCount: Interest.interestsList.length,
                  itemBuilder: (context, index) => CheckboxListTile(
                    title: Text(Interest.interestsList[index].name),
                    value: isChecked.elementAt(index),
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked[index] = value!;
                        for (int i = 0; i < isChecked.length; i++) {
                          if (isChecked[i]) {
                            isSelect = true;
                            break;
                          } else {
                            isSelect = false;
                          }
                        }
                      });
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              ElevatedButton(
                onPressed: !isSelect
                    ? null
                    : () {
                        Get.toNamed(Routes.signup);
                      },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
