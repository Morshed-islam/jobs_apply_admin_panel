import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/dashboard/page_provider.dart';
import '../add_post/add_job_screen.dart';
import '../add_slider/add_slider.dart';
import '../orders/orders_request_page.dart';
import '../premium_request/premium_request_screen.dart';
import 'dashboard.dart';

class StarterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left sidebar
          Container(
            width: 250,
            color: Colors.blueGrey[800],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blueGrey[800]),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                    width: 250,
                    height: 150,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                ListTile(
                  title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.dashboard, color: Colors.white),
                  onTap: () {
                    Provider.of<PageProvider>(context, listen: false).navigateTo('Dashboard');
                  },
                ),
                ListTile(
                  title: const Text('Add Jobs', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.post_add, color: Colors.white),
                  onTap: () {
                    Provider.of<PageProvider>(context, listen: false).navigateTo('Add Post');
                  },
                ),
                ListTile(
                  title: const Text('Add Slider', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.payment, color: Colors.white),
                  onTap: () {
                    Provider.of<PageProvider>(context, listen: false).navigateTo('addSlider');
                  },
                ),
                ListTile(
                  title: const Text('Premium Request', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.payment, color: Colors.white),
                  onTap: () {
                    Provider.of<PageProvider>(context, listen: false).navigateTo('Premium Request');
                  },
                ),
                ListTile(
                  title: const Text('Orders Request', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.payment, color: Colors.white),
                  onTap: () {
                    Provider.of<PageProvider>(context, listen: false).navigateTo('Orders Request');
                  },
                ),
              ],
            ),
          ),
          // Right content area
          Expanded(
            child: Consumer<PageProvider>(
              builder: (context, pageProvider, child) {
                return _getSelectedPage(pageProvider.selectedPage);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Logic to switch between different pages
  Widget _getSelectedPage(String selectedPage) {
    switch (selectedPage) {
      case 'Dashboard':
        return DashboardPage();
      case 'Add Post':
        return AddJobPage();
      case 'addSlider':
        return AddSliderPage();
      case 'Premium Request':
        return PremiumRequestPage();
      case 'Orders Request':
        return OrdersRequestPage();

      default:
        return DashboardPage(); // Default to Dashboard
    }
  }
}
