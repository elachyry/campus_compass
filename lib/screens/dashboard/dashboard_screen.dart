import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../screens.dart';

class DashboardScreen extends StatefulWidget {
  PageController pageController;
  DashboardScreen({
    super.key,
    required this.pageController,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // final focuseNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(50.r),
                    onTap: () {
                      setState(() {
                        widget.pageController.jumpTo(3);
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: Image.asset(
                        'assets/images/logo/user.jpeg',
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications,
                      color: Theme.of(context).colorScheme.primary,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Theme.of(context).colorScheme.background,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hello Mohammed",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    FittedBox(
                      child: Text(
                        "Discoverd the best events for you",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    // focusNode: focuseNode,
                    onTap: () {
                      // focuseNode.unfocus();
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Bootstrap.search,
                        // size: 35,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search for events...'.tr,
                      // hintStyle: const TextStyle(fontSize: 13),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 16.h),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: 15.w),
                SizedBox(
                  width: 50.w,
                  height: 50.h,
                  child: Icon(
                    Icons.tune,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
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
              height: 350.h,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return const EventCard(
                      image: "assets/images/logo/event1.jpg");
                },
                itemCount: 10,
                pagination: const SwiperPagination(),
                // control: const SwiperControl(),
              ),
            ),

            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Our Services",
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
              height: 400.h,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Theme.of(context).colorScheme.onPrimary,
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
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
                                child: Image.asset(
                                  "assets/images/logo/service1.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Request a Golf Cart",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(height: 5.h),
                              const Text(
                                'Get around campus effortlessly! Request a golf cart for quick and convenient transportation to your destination. Easy, reliable, and just a tap away!',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 10,
                pagination: const SwiperPagination(),
                // control: const SwiperControl(),
              ),
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
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return const EventCard(
                      image: "assets/images/logo/club1.jpg");
                },
                itemCount: 10,
                pagination: const SwiperPagination(),
                // control: const SwiperControl(),
              ),
            ),
            // const EventCard(
            //   image: "assets/images/logo/club1.jpg",
            // ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String image;
  const EventCard({
    required this.image,
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
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 45.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "30th",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Jul",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
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
                      "Xbition 2023",
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
                          "UM6P Benguerir",
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
                          "07:00 PM",
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                      child: Icon(
                        Icons.favorite_border,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
