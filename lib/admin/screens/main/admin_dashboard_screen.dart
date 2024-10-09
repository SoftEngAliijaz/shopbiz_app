import 'package:flutter/material.dart';
import 'package:shopbiz_app/ui/widgets/admin/carousel_card.dart';
import 'package:shopbiz_app/ui/widgets/admin/user_info_card.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CarouselCardWidget(),
                    CarouselCardWidget(),
                    CarouselCardWidget(),
                    CarouselCardWidget(),
                    CarouselCardWidget(),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              UserInfoCard(
                title: 'Trickster as (Admin)',
                subtitle: "Trickster@gmail.com",
                trailingIcon: Icons.admin_panel_settings_outlined,
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0),
                  children: const [
                    Card(
                        color: Colors.red,
                        child: Center(child: Text('Total Orders [Count]'))),
                    Card(
                        color: Colors.green,
                        child: Center(child: Text('Total Cash [Count]'))),
                    Card(
                        color: Colors.blue,
                        child: Center(child: Text('Will be added soon'))),
                    Card(
                        color: Colors.amber,
                        child: Center(child: Text('Will be added soon'))),
                    Card(
                        color: Colors.pinkAccent,
                        child: Center(child: Text('Will be added soon'))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
