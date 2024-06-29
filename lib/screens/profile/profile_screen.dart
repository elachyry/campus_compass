import 'package:compus_map/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 5,
              padding: const EdgeInsets.only(bottom: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r)),
              ),
              child: CustomPaint(
                painter: WavyLinesPainter(),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Stack(
                          children: const [
                            CircleAvatar(
                              radius: 48,
                              backgroundImage:
                                  AssetImage("assets/images/logo/user.jpeg"),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: CircleAvatar(
                                radius: 13,
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius:  BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Mohammed Elachyry",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text(
                    "melachyr@student.1337.ma",
                  ),
                   SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      outlineButtonBuilder(
                        context,
                        title: "Badge",
                        icon: Icons.qr_code_rounded,
                      ),
                      const SizedBox(width: 10),
                      outlineButtonBuilder(
                        context,
                        title: "Edit",
                        icon: Icons.edit,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20.w),
            profileCardItemBuilder(
              context,
              child: Column(
                children: [
                  profileItemBuilder(
                    context,
                    title: "Personal Information",
                    icon: Icons.person,
                  ),
                  profileItemBuilder(
                    context,
                    title: "Change Password",
                    icon: Icons.password,
                  ),
                  profileItemBuilder(
                    context,
                    title: "Fingerprint Scan",
                    icon: Icons.fingerprint,
                    trailing: Switch.adaptive(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.w),
            profileCardItemBuilder(
              context,
              child: Column(
                children: [
                  profileItemBuilder(
                    context,
                    title: "Language",
                    icon: Icons.translate,
                    trailing: GetBuilder<LocalizationController>(
                      builder: (ctrl) {
                        return Text(ctrl.languages[ctrl.selectedIndex].languageName);
                      }
                    )
                  ),
                  profileItemBuilder(
                    context,
                    title: "Dark mode",
                    icon: Icons.dark_mode,
                    trailing: Switch.adaptive(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  profileItemBuilder(
                    context,
                    title: "Notifications",
                    icon: Icons.notifications,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.w),
            profileCardItemBuilder(
              context,
              child: Column(
                children: [
                  profileItemBuilder(
                    context,
                    title: "About us",
                    icon: Icons.question_mark,
                  ),
                  profileItemBuilder(
                    context,
                    title: "Contact us",
                    icon: Icons.email,
                  ),
                  profileItemBuilder(
                    context,
                    title: "Privacy Policy",
                    icon: Icons.lock,
                  ),
                  profileItemBuilder(
                    context,
                    title: "Terms & Conditions",
                    icon: Icons.list,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.w),
            profileCardItemBuilder(
              context,
              child: profileItemBuilder(
                context,
                title: "Delete your account",
                icon: Icons.delete_forever_rounded,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20.w),
            profileCardItemBuilder(
              context,
              child: profileItemBuilder(
                context,
                title: "Log out",
                icon: Icons.logout,
                onTap: () {
                  AuthController.instance.signOut();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  OutlinedButton outlineButtonBuilder(BuildContext context,
      {required String title, required IconData icon}) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(
        icon,
      ),
      label: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
        ),
      ),
    );
  }

  Container profileCardItemBuilder(BuildContext context,
      {required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Theme.of(context).colorScheme.background,
      ),
      child: child,
    );
  }

  ListTile profileItemBuilder(BuildContext context,
      {required String title,
      required IconData icon,
      Color? color,
      Widget? trailing,
      Function()? onTap,}) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      )
    );
  }
}

class WavyLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path1 = Path()
      ..moveTo(0, size.height * 0.25)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.15,
          size.width * 0.5, size.height * 0.25)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.35, size.width,
          size.height * 0.25);

    final path2 = Path()
      ..moveTo(0, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.4,
          size.width * 0.5, size.height * 0.5)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.6, size.width, size.height * 0.5);

    final path3 = Path()
      ..moveTo(0, size.height * 0.75)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.65,
          size.width * 0.5, size.height * 0.75)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.85, size.width,
          size.height * 0.75);

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path3, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
