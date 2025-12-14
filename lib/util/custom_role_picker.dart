// lib/widgets/custom_role_picker.dart
import 'package:flutter/material.dart';

class CustomRolePicker extends StatefulWidget {
  final Function(String role) onRoleSelected;
  final String? initialRole;

  const CustomRolePicker({
    super.key,
    required this.onRoleSelected,
    this.initialRole,
  });

  @override
  State<CustomRolePicker> createState() => _CustomRolePickerState();
}

class _CustomRolePickerState extends State<CustomRolePicker> {
  late String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialRole;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Role',
          style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildRoleButton(
              title: 'Parent',
              icon: Icons.supervisor_account,
              role: 'parent',
            ),
            const SizedBox(width: 16),
            _buildRoleButton(
              title: 'Child',
              icon: Icons.child_care,
              role: 'child',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleButton({
    required String title,
    required IconData icon,
    required String role,
  }) {
    final theme = Theme.of(context).colorScheme;
    final isSelected = _selectedRole == role;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedRole = role;
          });
          widget.onRoleSelected(role);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? theme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.primary, width: 1.5),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: theme.primary.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : theme.primary,
                size: 28,
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : theme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
