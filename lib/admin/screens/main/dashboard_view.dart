import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:shopbiz_app/admin/screens/main/admin_dashboard_screen.dart';
import 'package:shopbiz_app/admin/screens/products/add_product.dart';
import 'package:shopbiz_app/admin/screens/products/delete_product.dart';
import 'package:shopbiz_app/admin/screens/products/update_product.dart';
import 'package:shopbiz_app/admin/screens/products/view_all_product.dart';
import 'package:shopbiz_app/admin/screens/users/view_all_users.dart';
import 'package:shopbiz_app/ui/widgets/admin/sidebar_footer.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  AdminDashboardViewState createState() => AdminDashboardViewState();
}

class AdminDashboardViewState extends State<AdminDashboardView> {
  String selectedRoute = '/dashboard';

  Widget getSelectedScreen() {
    switch (selectedRoute) {
      case '/dashboard':
        return const AdminDashboardScreen();
      case '/users':
        return const ViewAllUsersScreen();
      case '/add-product':
        return const AddProductScreen();
      case '/update-product':
        return const UpdateProductScreen();
      case '/delete-product':
        return const DeleteProductScreen();
      case '/view-products':
        return const ViewAllProductScreen();
      default:
        return const AdminDashboardScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: true,
      ),
      sideBar: SideBar(
          items: const [
            AdminMenuItem(
              title: 'Dashboard',
              route: '/dashboard',
              icon: Icons.dashboard_outlined,
            ),
            AdminMenuItem(
              title: 'Add Product',
              route: '/add-product',
              icon: Icons.add_outlined,
            ),
            AdminMenuItem(
              title: 'Update Product',
              route: '/update-product',
              icon: Icons.update_outlined,
            ),
            AdminMenuItem(
              title: 'Delete Product',
              route: '/delete-product',
              icon: Icons.delete_outline,
            ),
            AdminMenuItem(
              title: 'View All Products',
              route: '/view-products',
              icon: Icons.list_outlined,
            ),
            AdminMenuItem(
              title: 'View All Users',
              route: '/users',
              icon: Icons.person_outline,
            ),
          ],
          selectedRoute: selectedRoute,
          onSelected: (item) {
            if (item.route != null) {
              setState(() {
                selectedRoute = item.route!;
              });
            }
          },
          footer: const AdminSideBarFooterWidget()),
      body: Center(child: getSelectedScreen()),
    );
  }
}
