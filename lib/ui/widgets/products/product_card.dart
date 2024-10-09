import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/ui/widgets/products/product_button.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final String description;
  final double price;
  final void Function()? onPressed;
  final Size size;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.description,
    required this.price,
    required this.onPressed,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = size.width < 600;
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          height: size.height * (isSmallScreen ? 0.50 : 0.40),
          width: size.width * (isSmallScreen ? 0.85 : 0.60),
          child: Card(
            color: AppColors.kWhiteColor,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    imageUrl,
                    height: size.height * (isSmallScreen ? 0.30 : 0.20),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Divider(
                    height: 22.0, color: AppColors.kGreyColor.withOpacity(0.4)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      description,
                      maxLines: isSmallScreen ? 2 : 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ProductButton(
                        title: 'Wishlist',
                        productIcon: Icons.shop_outlined,
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: ProductButton(
                        title: 'Add to Cart',
                        productIcon: Icons.shopping_bag_outlined,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
