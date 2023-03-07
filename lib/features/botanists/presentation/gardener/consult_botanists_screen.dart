import 'package:flutter/material.dart';
import 'package:plants_buddy/features/botanists/presentation/gardener/pages/payments_page_gardener.dart';

import '../common/chat_page.dart';
import 'pages/appointments_page_gardener.dart';
import 'pages/botanists_page.dart';

class ConsultBotanistsScreen extends StatefulWidget {
  const ConsultBotanistsScreen({Key? key}) : super(key: key);

  @override
  State<ConsultBotanistsScreen> createState() => _ConsultBotanistsScreenState();
}

class _ConsultBotanistsScreenState extends State<ConsultBotanistsScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 47,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 20),
        //   child: SvgPicture.asset(
        //     custom_icons.plantsBuddy,
        //   ),
        // ),
        title: Text(['Appointments', 'Botanists', 'Chats', 'Payment'][currentPage]),
        //actions: _getActions(currentPage, context),
      ),
      body: _getPageView(),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.access_time_filled), label: 'Appointments'),
          NavigationDestination(icon: Icon(Icons.groups), label: 'Botanists'),
          NavigationDestination(icon: Icon(Icons.chat), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.attach_money), label: 'Payment'),
        ],
        selectedIndex: currentPage,
        onDestinationSelected: (index) => setState(() => currentPage = index),
      ),
    );
  }

  Widget _getPageView() {
    switch (currentPage) {
      case 0:
        return AppointmentsPageGardener();
      case 1:
        return BotanistsPage();
      case 2:
        return ChatPage();
      case 3:
        return PaymentsPageGardener();

      default:
        return BotanistsPage();
    }
  }
}
