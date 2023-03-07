import 'package:flutter/material.dart';
import '../common/chat_page.dart';
import 'pages/appointments_page_botanist.dart';
import 'pages/payments_page_botanist.dart';

class AttendGardenersScreen extends StatefulWidget {
  const AttendGardenersScreen({Key? key}) : super(key: key);

  @override
  State<AttendGardenersScreen> createState() => _AttendGardenersScreenState();
}

class _AttendGardenersScreenState extends State<AttendGardenersScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(['Appointments', 'Chats', 'Payment'][currentPage]),
        //actions: _getActions(currentPage, context),
      ),
      body: _getPageView(),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.access_time_filled), label: 'Appointments'),
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
        return AppointmentsPageBotanist();

      case 1:
        return ChatPage();

      case 2:
        return PaymentsPageBotanist();

      default:
        return AppointmentsPageBotanist();
    }
  }
}
