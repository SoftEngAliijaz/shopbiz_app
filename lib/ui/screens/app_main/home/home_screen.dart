import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/ui/widgets/admin/carousel_card.dart';
import 'package:shopbiz_app/ui/widgets/admin/user_info_card.dart';
import 'package:shopbiz_app/ui/widgets/app/user_drawer.dart';
import 'package:shopbiz_app/ui/widgets/products/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopbiz'),
        centerTitle: true,
      ),
      drawer: const UserDrawer(),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // User Info Card
                const UserInfoCard(
                  title: 'Welcome Trickster!',
                  subtitle: "Trickster@email.com",
                  trailingIcon: Icons.admin_panel_settings_outlined,
                ),
                const SizedBox(height: 10),

                // Horizontal Carousel
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      CarouselCardWidget(),
                      CarouselCardWidget(),
                      CarouselCardWidget(),
                      CarouselCardWidget(),
                      CarouselCardWidget(),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                // Products Section
                ProductCardTitle(
                  title: 'Products',
                  onPressed: () {},
                ),
                const SizedBox(height: 5.0),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ProductCard(
                        imageUrl:
                            'https://images.pexels.com/photos/36029/aroni-arsa-children-little.jpg?cs=srgb&dl=pexels-pixabay-36029.jpg&fm=jpg',
                        title: 'Product Name',
                        price: 1500,
                        onAddToCart: () {},
                        size: size,
                      ),
                      ProductCard(
                        imageUrl:
                            'https://images.pexels.com/photos/36029/aroni-arsa-children-little.jpg?cs=srgb&dl=pexels-pixabay-36029.jpg&fm=jpg',
                        title: 'Product Name',
                        price: 1500,
                        onAddToCart: () {},
                        size: size,
                      ),
                      ProductCard(
                        imageUrl:
                            'https://images.pexels.com/photos/36029/aroni-arsa-children-little.jpg?cs=srgb&dl=pexels-pixabay-36029.jpg&fm=jpg',
                        title: 'Product Name',
                        price: 1500,
                        onAddToCart: () {},
                        size: size,
                      ),
                    ],
                  ),
                ),
                ProductCardTitle(
                  title: 'Categories',
                  onPressed: () {},
                ),
                const SizedBox(height: 5.0),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ProductCard(
                        imageUrl:
                            'https://images.pexels.com/photos/36029/aroni-arsa-children-little.jpg?cs=srgb&dl=pexels-pixabay-36029.jpg&fm=jpg',
                        title: 'Product Name',
                        price: 1500,
                        onAddToCart: () {},
                        size: size,
                      ),
                      ProductCard(
                        imageUrl:
                            'https://images.pexels.com/photos/36029/aroni-arsa-children-little.jpg?cs=srgb&dl=pexels-pixabay-36029.jpg&fm=jpg',
                        title: 'Product Name',
                        price: 1500,
                        onAddToCart: () {},
                        size: size,
                      ),
                      ProductCard(
                        imageUrl:
                            'https://images.pexels.com/photos/36029/aroni-arsa-children-little.jpg?cs=srgb&dl=pexels-pixabay-36029.jpg&fm=jpg',
                        title: 'Product Name',
                        price: 1500,
                        onAddToCart: () {},
                        size: size,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCardTitle extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const ProductCardTitle({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      trailing: TextButton(
        onPressed: onPressed,
        child:
            Text("View all", style: TextStyle(color: AppColors.kPrimaryColor)),
      ),
    );
  }
}
