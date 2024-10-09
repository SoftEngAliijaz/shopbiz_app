import 'package:flutter/material.dart';
import 'package:shopbiz_app/data/models/product_ui_model.dart';
import 'package:shopbiz_app/ui/widgets/admin/user_info_card.dart';
import 'package:shopbiz_app/ui/widgets/app/carousel_slider_widget.dart';
import 'package:shopbiz_app/ui/widgets/app/user_drawer.dart';
import 'package:shopbiz_app/ui/widgets/products/product_card.dart';
import 'package:shopbiz_app/ui/widgets/products/product_card_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
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

                CarouselSliderWidget(),

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
                      ...productUiModel.map((v) {
                        return ProductCard(
                          imageUrl: '${v.imageUrl}',
                          title: '${v.name}',
                          description: '${v.description}',
                          price: v.price,
                          category: '${v.category}',
                          size: size,
                          onPressed: () {},
                        );
                      }).toList()
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
                      ...productUiModel.map((v) {
                        return ProductCard(
                          imageUrl: '${v.imageUrl}',
                          title: '${v.name}',
                          description: '${v.description}',
                          price: v.price,
                          category: '${v.category}',
                          onPressed: () {},
                          size: size,
                        );
                      }).toList()
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
