import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodozzz/presentation/restroCard.dart';
import '../bloc/foodjoint/bloc.dart';
import '../bloc/foodjoint/satets.dart';
import '../bloc/foodjoint/services.dart';
import '../core/crousel/img.dart';
import '../core/theme/appColors.dart';
import 'bookOrder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fj = FJServices();
  final List<String> navItems = const [
    'Home',
    'Shop',
    'Favorites',
    'Orders',
    'Support',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: 50,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: navItems.map((item) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: item == "Home" ? AppColor.green : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 40, top: 60, bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hi,",
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const Text(
                      "Welcome to Foodozzz",
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (carousol.isNotEmpty)
                      CarouselSlider.builder(
                        itemCount: carousol.length,
                        itemBuilder: (context, index, realIndex) {
                          final image = carousol[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          aspectRatio: 20 / 4,
                          height: 120,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.95,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                        ),
                      )
                    else
                      const SizedBox(height: 180), // placeholder

                    const SizedBox(height: 20),
                    const Text(
                      "Restaurants Near You:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<FJBloc, FJStates>(
                      builder: (context, state) {
                        if (state is FJLoadingState) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: CircularProgressIndicator(color: AppColor.green),
                            ),
                          );
                        } else if (state is FJSuccess) {
                          if (state.fj.isNotEmpty) {
                            return Column(
                              children: state.fj.map((restaurant) {
                                return restroCard(
                                  imgURL: restaurant.image ?? "",
                                  name: restaurant.name ?? "Unknown",
                                  rating: double.tryParse(
                                      restaurant.rating?.toString() ?? "0") ??
                                      0.0,
                                  type: restaurant.category ?? "Other",
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BookOrder(
                                          restaurantId: restaurant.id ?? "",
                                          restaurentName: restaurant.name ?? "",
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            );
                          } else {
                            return const Center(
                              child: Text("No restaurants found"),
                            );
                          }
                        } else if (state is FJError) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text("Error: ${state.message}"),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}







