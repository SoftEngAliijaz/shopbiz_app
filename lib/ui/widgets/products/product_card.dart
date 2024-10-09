import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/ui/widgets/products/product_button.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final VoidCallback onAddToCart;
  final Size size;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onAddToCart,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmallScreen =
        size.width < 600; // Define breakpoints for responsiveness
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: size.height *
            (isSmallScreen ? 0.50 : 0.40), // Adjust height based on screen size
        width: size.width *
            (isSmallScreen ? 0.85 : 0.60), // Adjust width for smaller screens
        child: Card(
          color: AppColors.kWhiteColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  imageUrl,
                  height: size.height *
                      (isSmallScreen ? 0.25 : 0.20), // Adjust image height
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Divider(
                height: 22.0,
                color: AppColors.kGreyColor.withOpacity(0.4),
              ),
              // Title section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // Description section (multi-line handling)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface...',
                  maxLines: isSmallScreen ? 2 : 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 5),
              // Price section
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
              // Buttons row
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
                      onPressed: onAddToCart,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
