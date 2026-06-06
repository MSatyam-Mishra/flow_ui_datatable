// import 'package:flutter/material.dart';
// import 'package:lucide_icons_flutter/lucide_icons.dart';
// import 'package:task_management/shared/core/theme/app_colors.dart';
// import 'package:task_management/shared/core/widgets/user_avatar.dart';

// class MockUserData {
//   final String id;
//   final String name;
//   final String email;
//   final String role;
//   final String department;
//   final String status;
//   final String joinedDate;
//   final String phone;
//   final int tasksCompleted;
//   final String lastActive;

//   MockUserData({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.role,
//     required this.department,
//     required this.status,
//     required this.joinedDate,
//     required this.phone,
//     required this.tasksCompleted,
//     required this.lastActive,
//   });
// }

// class UniversalTable extends StatelessWidget {
//   final List<MockUserData> data = [
//     MockUserData(
//       id: "1",
//       name: "John Doe",
//       email: "john.doe@company.com",
//       role: "Admin",
//       department: "Engineering",
//       status: "Active",
//       joinedDate: "2024-01-15",
//       phone: "+1 (555) 123-4567",
//       tasksCompleted: 42,
//       lastActive: "Online",
//     ),
//     MockUserData(
//       id: "2",
//       name: "Jane Smith",
//       email: "jane.smith@company.com",
//       role: "Member",
//       department: "Design",
//       status: "Active",
//       joinedDate: "2024-02-10",
//       phone: "+1 (555) 987-6543",
//       tasksCompleted: 28,
//       lastActive: "2 hours ago",
//     ),
//     MockUserData(
//       id: "3",
//       name: "Robert Johnson",
//       email: "robert.j@company.com",
//       role: "Member",
//       department: "Marketing",
//       status: "Pending",
//       joinedDate: "2024-05-01",
//       phone: "+1 (555) 456-7890",
//       tasksCompleted: 5,
//       lastActive: "1 day ago",
//     ),
//     MockUserData(
//       id: "4",
//       name: "Emily Davis",
//       email: "emily.d@company.com",
//       role: "Owner",
//       department: "Product",
//       status: "Active",
//       joinedDate: "2023-11-20",
//       phone: "+1 (555) 234-5678",
//       tasksCompleted: 156,
//       lastActive: "Online",
//     ),
//     MockUserData(
//       id: "5",
//       name: "Michael Brown",
//       email: "michael.b@company.com",
//       role: "Member",
//       department: "Engineering",
//       status: "Inactive",
//       joinedDate: "2024-03-18",
//       phone: "+1 (555) 876-5432",
//       tasksCompleted: 19,
//       lastActive: "3 days ago",
//     ),
//   ];

//   UniversalTable({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final brightness = isDarkMode ? Brightness.dark : Brightness.light;
//     final borderColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
//     final headerBgColor = isDarkMode ? Colors.grey[900]! : Colors.grey[50]!;
//     final indexBgColor = isDarkMode ? Colors.grey[900]! : Colors.grey[50]!;
//     final cellBgColor = isDarkMode ? const Color(0xFF0F0F0F) : Colors.white;

//     // Minimum width required to show 10 columns comfortably
//     const minTableWidth = 1400.0;

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final tableWidth = constraints.maxWidth > minTableWidth
//             ? constraints.maxWidth
//             : minTableWidth;

//         return SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: SizedBox(
//             width: tableWidth,
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: cellBgColor,
//                   border: Border.all(color: borderColor),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(7),
//                   child: Table(
//                     border: TableBorder(
//                       horizontalInside: BorderSide(color: borderColor, width: 1),
//                       verticalInside: BorderSide(color: borderColor, width: 1),
//                     ),
//                     columnWidths: const {
//                       0: FixedColumnWidth(50), // Index
//                       1: FlexColumnWidth(2.0), // User Profile
//                       2: FlexColumnWidth(1.0), // Role
//                       3: FlexColumnWidth(1.2), // Department
//                       4: FlexColumnWidth(1.0), // Status
//                       5: FlexColumnWidth(1.2), // Joined Date
//                       6: FlexColumnWidth(1.5), // Phone Number
//                       7: FlexColumnWidth(1.2), // Tasks Completed
//                       8: FlexColumnWidth(1.2), // Last Active
//                       9: FixedColumnWidth(80), // Actions
//                     },
//                     defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                     children: [
//                       // Header Row
//                       TableRow(
//                         decoration: BoxDecoration(color: headerBgColor),
//                         children: [
//                           _buildHeaderCell("#", isDarkMode, center: true),
//                           _buildHeaderCell("User Info", isDarkMode, icon: LucideIcons.user),
//                           _buildHeaderCell("System Role", isDarkMode, icon: LucideIcons.shield),
//                           _buildHeaderCell("Department", isDarkMode, icon: LucideIcons.briefcase),
//                           _buildHeaderCell("Status", isDarkMode, icon: LucideIcons.activity),
//                           _buildHeaderCell("Joined Date", isDarkMode, icon: LucideIcons.calendar),
//                           _buildHeaderCell("Phone", isDarkMode, icon: LucideIcons.phone),
//                           _buildHeaderCell("Tasks", isDarkMode, icon: LucideIcons.checkSquare),
//                           _buildHeaderCell("Last Active", isDarkMode, icon: LucideIcons.clock),
//                           _buildHeaderCell("Actions", isDarkMode, center: true),
//                         ],
//                       ),

//                       // Data Rows
//                       ...data.map((user) {
//                         return TableRow(
//                           children: [
//                             // 1. Index
//                             _InteractiveSpreadsheetCell(
//                               brightness: brightness,
//                               baseBgColor: indexBgColor,
//                               alignment: Alignment.center,
//                               child: Text(
//                                 user.id,
//                                 style: TextStyle(
//                                   fontFamily: "Inter",
//                                   fontSize: 13,
//                                   color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),

//                             // 2. User Info (Avatar + Name & Email)
//                             _InteractiveSpreadsheetCell(
//                               brightness: brightness,
//                               child: Row(
//                                 children: [
//                                   UserAvatar(
//                                     name: user.name,
//                                     radius: 16,
//                                     fontSize: 14,
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           user.name,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: TextStyle(
//                                             fontFamily: "Inter",
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 14,
//                                             color: AppColors.getTextPrimary(brightness),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 2),
//                                         Text(
//                                           user.email,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: TextStyle(
//                                             fontFamily: "Inter",
//                                             color: AppColors.getTextSecondary(brightness),
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             // 3. Role
//                             _InteractiveSpreadsheetCell(
//                               brightness: brightness,
//                               child: Text(
//                                 user.role,
//                                 style: TextStyle(
//                                   fontFamily: "Inter",
//                                   fontSize: 13,
//                                   color: AppColors.getTextPrimary(brightness),
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),

//                             // 4. Department
//                             _InteractiveSpreadsheetCell(
//                               brightness: brightness,
//                               child: Text(
//                                 user.department,
//                                 style: TextStyle(
//                                   fontFamily: "Inter",
//                                   fontSize: 13,
//                                   color: AppColors.getTextPrimary(brightness),
//                                 ),
//                               ),
//                             ),

//                             // 5. Status Pill
//                             _InteractiveSpreadsheetCell(
//                               brightness: brightness,
//                               child: _buildStatusPill(user.status),
//                             ),

//                             // 6. Joined Date
//                             _InteractiveSpreadsheetCell(
//                               brightness: brightness,
//                               child: Text(
//                                 user.joinedDate,
//                                 style: TextStyle(
//                                   fontFamily: "Inter",
//                                   fontSize: 13,
//                                   color: AppColors.getTextPrimary(brightness),
//                                 ),
//                               ),
//                             ),

//                             // 7. Phone
//                             _InteractiveSpreadsheetCell(
//                               brightness: brightness,
//                               child: Text(
//                                 user.phone,
//                                 style: TextStyle(
//                                   fontFamily: "Inter",
//                                   fontSize: 13,
//                                   color: AppColors.getTextPrimary(brightness),
//                                 ),
//                               ),
//                             ),

//                             // 8. Tasks Completed
//                             _InteractiveSpreadsheetCell(
//                               brightness: brightness,
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     LucideIcons.checkCircle2,
//                                     size: 14,
//                                     color: Colors.green[500],
//                                   ),
//                                   const SizedBox(width: 6),
//                                   Text(
//                                     "${user.tasksCompleted} done",
//                                     style: TextStyle(
//                                       fontFamily: "Inter",
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w600,
//                                       color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             // 9. Last Active
//                             _InteractiveSpreadsheetCell(
//                               brightness: brightness,
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     width: 6,
//                                     height: 6,
//                                     decoration: BoxDecoration(
//                                       color: user.lastActive == "Online" ? Colors.green : Colors.grey,
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 6),
//                                   Text(
//                                     user.lastActive,
//                                     style: TextStyle(
//                                       fontFamily: "Inter",
//                                       fontSize: 13,
//                                       color: AppColors.getTextPrimary(brightness),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             // 10. Actions Button
//                             _InteractiveSpreadsheetCell(
//                               brightness: brightness,
//                               alignment: Alignment.center,
//                               child: IconButton(
//                                 icon: const Icon(LucideIcons.moreHorizontal, size: 18),
//                                 padding: EdgeInsets.zero,
//                                 constraints: const BoxConstraints(),
//                                 onPressed: () {},
//                               ),
//                             ),
//                           ],
//                         );
//                       }),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildHeaderCell(String label, bool isDarkMode, {IconData? icon, bool center = false}) {
//     return Container(
//       height: 38,
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       alignment: center ? Alignment.center : Alignment.centerLeft,
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (icon != null) ...[
//             Icon(
//               icon,
//               size: 14,
//               color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
//             ),
//             const SizedBox(width: 6),
//           ],
//           Text(
//             label,
//             style: TextStyle(
//               fontFamily: "Inter",
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatusPill(String status) {
//     Color bgColor;
//     Color textColor;

//     switch (status) {
//       case "Active":
//         bgColor = Colors.green.withValues(alpha: 0.15);
//         textColor = Colors.green[700]!;
//         break;
//       case "Pending":
//         bgColor = Colors.orange.withValues(alpha: 0.15);
//         textColor = Colors.orange[700]!;
//         break;
//       default:
//         bgColor = Colors.grey.withValues(alpha: 0.15);
//         textColor = Colors.grey[700]!;
//         break;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         status,
//         style: TextStyle(
//           fontFamily: "Inter",
//           fontSize: 11,
//           fontWeight: FontWeight.bold,
//           color: textColor,
//         ),
//       ),
//     );
//   }
// }

// class _InteractiveSpreadsheetCell extends StatefulWidget {
//   final Widget child;
//   final AlignmentGeometry alignment;
//   final Brightness brightness;
//   final Color? baseBgColor;
//   final VoidCallback? onTap;

//   const _InteractiveSpreadsheetCell({
//     required this.child,
//     required this.brightness,
//     this.alignment = Alignment.centerLeft,
//     this.baseBgColor,
//     this.onTap,
//   });

//   @override
//   State<_InteractiveSpreadsheetCell> createState() => _InteractiveSpreadsheetCellState();
// }

// class _InteractiveSpreadsheetCellState extends State<_InteractiveSpreadsheetCell> {
//   bool _isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = widget.brightness == Brightness.dark;
//     final hoverColor = isDarkMode 
//         ? Colors.white.withValues(alpha: 0.06) 
//         : Colors.black.withValues(alpha: 0.04);

//     Widget result = AnimatedContainer(
//       duration: const Duration(milliseconds: 150),
//       height: 56,
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       alignment: widget.alignment,
//       decoration: BoxDecoration(
//         color: _isHovered ? hoverColor : (widget.baseBgColor ?? Colors.transparent),
//       ),
//       child: AnimatedScale(
//         scale: _isHovered ? 1.05 : 1.0,
//         duration: const Duration(milliseconds: 150),
//         curve: Curves.easeOut,
//         child: widget.child,
//       ),
//     );

//     if (widget.onTap != null) {
//       result = GestureDetector(
//         onTap: widget.onTap,
//         child: MouseRegion(
//           cursor: SystemMouseCursors.click,
//           child: result,
//         ),
//       );
//     }

//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() => _isHovered = false),
//       child: result,
//     );
//   }
// }