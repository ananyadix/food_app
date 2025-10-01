import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodozzz/presentation/cart.dart';
import '../bloc/menu/bloc.dart';
import '../bloc/menu/state.dart';
import '../bloc/menu/event.dart';
import '../bloc/menu/model.dart';
import '../core/theme/appColors.dart';
import 'menuCard.dart';

class BookOrder extends StatefulWidget {
  final String? restaurantId;
  final String? restaurentName;

  const BookOrder({super.key, required this.restaurantId, required this.restaurentName});

  @override
  State<BookOrder> createState() => _BookOrderState();
}

class _BookOrderState extends State<BookOrder> {
  @override
  void initState() {
    super.initState();
    if (widget.restaurantId != null) {
      BlocProvider.of<MenuBloc>(context).add(FetchMenu(widget.restaurantId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.restaurentName ?? "Restaurant"),
        backgroundColor: Colors.transparent,
        leading:  IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new)),
        actions: [
          IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder:(context)=> Cart()));}, icon:Icon(Icons.shopping_cart))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<MenuBloc, MenuState>(
              builder: (context, state) {
                if (state is MenuLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(color: AppColor.green),
                    ),
                  );
                } else if (state is MenuSuccess) {
                  // Flatten all menu items
                  List<Menu> dishes = [];
                  for (var menuModel in state.menu) {
                    if (menuModel.menu != null) {
                      dishes.addAll(menuModel.menu!);
                    }
                  }

                  if (dishes.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("No menu available"),
                      ),
                    );
                  }

                  return Column(
                    children: dishes.map((dish) {
                      return MenuCard(
                        context: context,
                        id: dish.itemId ?? "",
                        dishName: dish.name ?? "",
                        price: (dish.price ?? 0).toDouble(),
                        category: dish.category ?? "",
                      );
                    }).toList(),
                  );
                } else if (state is MenuError) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Error while fetching menu"),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}



