import 'package:flutter/material.dart';

import '../state/app_state.dart';

class AlertsLaunchesScreen extends StatelessWidget {
  const AlertsLaunchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState state = AppStateScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Alerts & launches')),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: const Text('Completed transactions'),
            subtitle: const Text('Sent right after a purchase'),
            value: state.notifyCompletedTransactions,
            onChanged: (bool v) => state.setNotifyCompletedTransactions(v),
          ),
          const Divider(height: 1),
          SwitchListTile(
            title: const Text('Available discounts'),
            value: state.notifyAvailableDiscounts,
            onChanged: (bool v) => state.setNotifyAvailableDiscounts(v),
          ),
          const Divider(height: 1),
          SwitchListTile(
            title: const Text('New products'),
            value: state.notifyNewProducts,
            onChanged: (bool v) => state.setNotifyNewProducts(v),
          ),
        ],
      ),
    );
  }
}
