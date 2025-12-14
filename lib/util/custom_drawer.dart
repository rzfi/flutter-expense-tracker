// import 'package:flutter/material.dart';
// import 'package:parenting/provider/budget_provider.dart';
// import 'package:provider/provider.dart';

// class CustomDrawer extends StatelessWidget {
//   final void Function(BuildContext) onSetBudget;
//   final void Function(BuildContext) onResetExpenses;
//   const CustomDrawer({
//     super.key,
//     required this.onSetBudget,
//     required this.onResetExpenses,
//   });

//   @override
//   Widget build(BuildContext context) {
//     void _showBudgetDialog(BuildContext context, double currentBudget) {
//     showDialog(
//       context: context,
//       builder: (context) => BudgetDialog(currentBudget: currentBudget),
//     );
//   }
//     return Drawer(
//       child: SafeArea(
//         child: Column(
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(50)),
//                 color: Theme.of(context).colorScheme.primary,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Theme.of(context).colorScheme.onPrimary,
//                     child: Icon(
//                       Icons.account_balance_wallet_rounded,
//                       size: 40,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             DrawerTile(
//               icon: Icons.account_balance_wallet_rounded,
//               title: 'Set Budget',
//               iconColor: Theme.of(context).colorScheme.primary,
//               onTap: () {
//                 final budget = context.read<BudgetProvider>().budget;
//                 onSetBudget(context);
//                 Navigator.pop(context);
//               },
//             ),
//             DrawerTile(
//               icon: Icons.settings,
//               title: 'Settings',
//               iconColor: Theme.of(context).colorScheme.primary,
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/settings');
//               },
//             ),
//             DrawerTile(
//               icon: Icons.delete_forever,
//               title: 'Reset Expenses',
//               iconColor: Theme.of(context).colorScheme.error,
//               onTap: () {
//                 onResetExpenses(context);
//                 Navigator.pop(context);
//               },
//             ),
//             DrawerTile(
//               icon: Icons.logout,
//               title: 'Logout',
//               iconColor: Theme.of(context).colorScheme.primary,
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DrawerTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;
//   final Color iconColor;

//   const DrawerTile({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.onTap,
//     required this.iconColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Icon(icon, color: iconColor),
//       title: Text(title),
//       onTap: onTap,
//       trailing: const Icon(Icons.arrow_forward_ios, size: 14),
//     );
//   }
// }

// class BudgetDialog extends StatelessWidget {
//   final double currentBudget;
//   const BudgetDialog({super.key, required this.currentBudget});

//   @override
//   Widget build(BuildContext context) {
//     final controller = TextEditingController(text: currentBudget.toStringAsFixed(2));
//     final color = Theme.of(context).colorScheme;
//     return AlertDialog(
//       title: const Text('Set Overall Budget'),
//       content: TextField(
//         controller: controller,
//         keyboardType: TextInputType.numberWithOptions(decimal: true),
//         decoration: const InputDecoration(
//           labelText: 'Budget (₹)',
//           border: OutlineInputBorder(),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: color.primary,
//             foregroundColor: color.onPrimary,
//           ),
//           onPressed: () {
//             final value = double.tryParse(controller.text);
//             if (value != null && value > 0) {
//               Provider.of<BudgetProvider>(context, listen: false).setBudget(value);
//               Navigator.pop(context);
//             }
//           },
//           child: const Text('Save'),
//         ),
//       ],
//     );
//   }
// }

// class ResetExpensesDialog extends StatelessWidget {
//   final VoidCallback onReset;
//   const ResetExpensesDialog({super.key, required this.onReset});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text("Confirm Reset"),
//       content: const Text("Are you sure you want to delete all expenses?"),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context, false),
//           child: const Text("Cancel"),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             onReset();
//             Navigator.pop(context, true);
//           },
//           child: const Text("Reset"),
//         ),
//       ],
//     );
//   }
// }
