import 'dart:io';
import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controllers/controllers.dart';
import '../../models/models.dart';

class DashboardScreen extends StatefulWidget {
  final PageController pageController;
  const DashboardScreen({
    super.key,
    required this.pageController,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final EventController eventController = Get.find();
  final ClubController clubController = Get.find();
  final AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();
    eventController.fetchEventsLocal();
    // clubController.fetchClubsLocal();
  }

  // final focuseNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Obx(() {
          if (authController.currentUser.value == null) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Theme.of(context).primaryColor,
                size: 60.r,
              ),
            );
          } else {
            final User? user = authController.currentUser.value;
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hey!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        Text(
                          user!.name.split(" ")[0],
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 32.r,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: CircleAvatar(
                        radius: 30.r,
                        backgroundImage: user.imageUrl.isEmpty
                            ? const AssetImage(
                                'assets/images/logo/avatar.png',
                              )
                            : NetworkImage(
                                user.imageUrl,
                              ) as ImageProvider,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 80.h,
                  child: Swiper(
                    autoplay: true,
                    autoplayDelay: 5000,
                    autoplayDisableOnInteraction: true,
                    itemBuilder: (BuildContext context, int index) {
                      return ServiceCard();
                    },
                    itemCount: 3,
                    // pagination: const SwiperPagination(),
                  ),
                  
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upcoming Events",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "View All",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  height: 250.h,
                  child: Obx(() {
                    if (eventController.events.isEmpty) {
                      return const Center(
                          child: Text(
                        "No events found",
                      ));
                    }
                    return Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return EventCard(
                          event: eventController.events[index],
                        );
                      },
                      itemCount: eventController.events.length,
                      pagination: const SwiperPagination(),
                      // control: const SwiperControl(),
                    );
                  }),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discover Clubs",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "View All",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  height: 350.h,
                  child: Obx(() {
                    if (eventController.events.isEmpty) {
                      return const Center(
                          child: Text(
                        "No clubs found",
                      ));
                    }
                    return Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return ClubCard(
                          club: clubController.clubs[index],
                        );
                      },
                      itemCount: clubController.clubs.length,
                      pagination: const SwiperPagination(),
                      // control: const SwiperControl(),
                    );
                  }),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25.r,
            backgroundColor: Colors.white,
            child: Icon(
              BoxIcons.bx_car,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Request a Ride",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              Text(
                "Book a ride to your destination",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.white70,
                      fontSize: 12.sp,
                    ),
              ),
            ],
          ),
          SizedBox(width: 15.w),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 30.w,
          ),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({
    required this.event,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            image: DecorationImage(
              image: NetworkImage(
                event.imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      event.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Bootstrap.clock,
                              size: 16.h,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              DateFormat('dd-MM-yyyy HH:mm').format(event.date),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.w),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Bootstrap.geo_alt,
                                  size: 16.h,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  event.location,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: Colors.black54,
                                        fontSize: 12,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30.w,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ClubCard extends StatelessWidget {
  final Club club;
  const ClubCard({
    required this.club,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  elevation: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: SizedBox(
                      height: 200.h,
                      width: double.infinity,
                      child: Image.network(
                        club.logoUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      club.name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: Colors.black26,
                          size: 16,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          club.location,
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.black26,
                          size: 16,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          club.description,
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Column(
                //   children: [
                //     Container(
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                //       child: Icon(
                //         Icons.favorite_border,
                //         size: 30,
                //         color: Theme.of(context).colorScheme.primary,
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
