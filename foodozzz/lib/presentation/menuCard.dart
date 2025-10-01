import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodozzz/bloc/cart/bloc.dart';
import 'package:foodozzz/bloc/cart/event.dart';
import 'package:foodozzz/bloc/cart/states.dart';
import 'package:foodozzz/core/theme/appColors.dart';

Widget MenuCard({
  required BuildContext context,
  required String id,
  required String dishName,
  required double price,
  required String category,
}) {
  final theme = Theme.of(context);
  return Card(
    color: Colors.white,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:  Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.fastfood,
                    size: 36,
                    color: Colors.grey,
                  ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dishName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1), // Light accent background
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "₹${price.toStringAsFixed(0)}", // Format price cleanly
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor, // Accent color for price
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<CartBloc,CartStates>(builder: (context,state){
            if(state is CartUpdated && state.items.containsKey(id)){
              final item=state.items[id]!;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: (){context.read<CartBloc>().add(DecrementQuantity(id));}, icon: Icon(Icons.remove_circle,color: AppColor.green,)),
                  Text("${item.quantity}"),
                  IconButton(onPressed: (){context.read<CartBloc>().add(IncrementQuantity(id));}, icon: Icon(Icons.add_circle,color: AppColor.green,))
                ],
              );
            }
            else{
              return SizedBox(
                width: 80,
                height: 40,
                child: ElevatedButton(onPressed:(){context.read<CartBloc>().add(AddToCart(id: id, dishName: dishName, price: price));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${dishName} added to cart")));}, child: Text("Add",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: AppColor.white),),
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),backgroundColor: AppColor.green),),
              );
            }
          }),
        ],
      ),
    ),
  );
}
