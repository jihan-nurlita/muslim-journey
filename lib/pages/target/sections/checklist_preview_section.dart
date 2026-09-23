// import 'package:flutter/material.dart';
// import 'package:ibadah_journey/core/constants/colors.dart';
// import 'package:ibadah_journey/pages/target/pages/all_checklist_page.dart';

// import '../data/target_data.dart';

// class ChecklistPreviewSection extends StatelessWidget {
//   const ChecklistPreviewSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final previewTargets = targetList.take(5).toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// HEADER
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Checklist Hari Ini',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.black,
//               ),
//             ),

//             /// BUTTON LIHAT SEMUA
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const AllChecklistPage(),
//                   ),
//                 );
//               },
//               child: const Text(
//                 'Lihat Semua',
//                 style: TextStyle(
//                   color: AppColors.primary,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),

//         const SizedBox(height: 18),

//         /// LIST PREVIEW
//         ListView.separated(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: previewTargets.length,
//           separatorBuilder: (_, __) => const SizedBox(height: 14),
//           itemBuilder: (context, index) {
//             final target = previewTargets[index];

//             return Container(
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(24),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.03),
//                     blurRadius: 12,
//                     offset: const Offset(0, 6),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   /// ICON
//                   Container(
//                     width: 56,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       color: AppColors.secondary,
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                     child: Icon(
//                       target.icon,
//                       color: AppColors.primary,
//                     ),
//                   ),

//                   const SizedBox(width: 14),

//                   /// TITLE + SUBTITLE
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           target.title,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: AppColors.black,
//                           ),
//                         ),

//                         const SizedBox(height: 4),

//                         Text(
//                           target.subtitle,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             color: AppColors.grey,
//                             fontSize: 13,
//                           ),
//                         ),

//                         const SizedBox(height: 10),

//                         /// PROGRESS
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           child: LinearProgressIndicator(
//                             value: target.progress,
//                             minHeight: 7,
//                             backgroundColor: Colors.grey.shade200,
//                             valueColor: const AlwaysStoppedAnimation(
//                               AppColors.primary,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(width: 14),

//                   /// CHECK BUTTON
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 250),
//                     width: 34,
//                     height: 34,
//                     decoration: BoxDecoration(
//                       color: target.isCompleted
//                           ? AppColors.primary
//                           : Colors.transparent,
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: target.isCompleted
//                             ? AppColors.primary
//                             : Colors.grey.shade300,
//                         width: 2,
//                       ),
//                     ),
//                     child: Icon(
//                       Icons.check_rounded,
//                       size: 18,
//                       color: target.isCompleted
//                           ? Colors.white
//                           : Colors.grey.shade400,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
