import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/controllers.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import '../screens.dart';

class GetOtherInfosScreen extends StatefulWidget {
  const GetOtherInfosScreen({super.key});

  @override
  State<GetOtherInfosScreen> createState() => _GetOtherInfosScreenState();
}

class _GetOtherInfosScreenState extends State<GetOtherInfosScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final AuthController authController = Get.find();
  final screenWidth = Get.width;
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  String? selectedValue;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    XFile? pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget _buildProfileImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 48.r,
          backgroundImage: _imageFile != null
              ? FileImage(File(_imageFile!.path))
              : const AssetImage("assets/images/logo/avatar.png")
                  as ImageProvider,
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: CircleAvatar(
            radius: 13.r,
            child: GestureDetector(
              onTap: () => selectImageModalBottomSheet(context),
              child: const Icon(
                Icons.camera_alt_rounded,
                size: 18,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: SafeArea(
        child: Obx(
          () {
            if (AuthController.instance.isLoading.value) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Theme.of(context).primaryColor,
                  size: screenWidth >= 600 ? 90 : 60,
                ),
              );
            } else {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Thank you Mohammed for join UniConnect",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.h),
                        FittedBox(
                          child: Text(
                            "Let's complete your profile",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        SizedBox(height: 25.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  _buildProfileImage(),
                                ],
                              ),
                              SizedBox(height: 30.h),
                              TextFormField(
                                readOnly: true,
                                onTap: () => _selectDate(context),
                                controller: _dateController,
                                decoration: InputDecoration(
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                    borderSide: const BorderSide(
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                    borderSide: const BorderSide(
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  focusedBorder: InputBorder.none,
                                  labelText: "Birth Date*",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  suffixIcon: IconButton(
                                    onPressed: () => _selectDate(context),
                                    icon: const Icon(Icons.calendar_month),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Birth Date is required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.h),
                              AuthField(
                                title: "Phone number*",
                                hintText: "Phone number*",
                                controller: _phoneController,
                                maxLines: 1,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'phone number is required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.h),
                              DropdownButtonFormField2<String>(
                                isExpanded: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.h, horizontal: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                    borderSide: const BorderSide(
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                    borderSide: const BorderSide(
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                                hint: const Text(
                                  'Select Your Gender*',
                                ),
                                items: genderItems
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select gender.';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  selectedValue = value.toString();
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.only(right: 8),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 24,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              PrimaryButton(
                                onTap: ()async {
                                  if (_formKey.currentState!.validate()) {
                                    String phoneNumber = _phoneController.text;
                                    String birthDate = _dateController.text;
                                    String gender = selectedValue ?? '';
                                    User? user = authController.currentUser.value;
                                            
                                    User updatedUser = user!
                                        .copyWith(
                                      phoneNumber: phoneNumber,
                                      imageUrl: _imageFile?.path ??
                                          authController
                                              .currentUser.value!.imageUrl,
                                      gender: gender,
                                      birthDate: birthDate,
                                      isCompleted: true,
                                    );
                                    authController
                                        .updateUserData(updatedUser)
                                        .then((value) {
                                      Get.find<SqfliteController>()
                                          .updatetUserData(updatedUser);
                                      Get.toNamed(Routes.bottomNav);
                                    });
                                  }
                                },
                                text: 'Complete profile',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<dynamic> selectImageModalBottomSheet(BuildContext context) {
    // final userController = Get.put(UserController());

    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      builder: (context) => Container(
        height: 250.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: <Widget>[
            Text(
              'Upload an image'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ImageModalSheetItem(
                  title: 'Take a picture'.tr,
                  icon: Bootstrap.camera,
                  onTap: () {
                    _pickImage(ImageSource.camera);
                  },
                ),
                ImageModalSheetItem(
                  title: 'Select from gallery'.tr,
                  icon: Bootstrap.image,
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ImageModalSheetItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const ImageModalSheetItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                size: 40.h,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 5.h),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
