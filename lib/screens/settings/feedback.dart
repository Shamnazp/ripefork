// import 'package:flutter/material.dart';

// class FeedbackScreen extends StatefulWidget {
//   const FeedbackScreen({super.key});

//   @override
//   _FeedbackScreenState createState() => _FeedbackScreenState();
// }

// class _FeedbackScreenState extends State<FeedbackScreen> {
//   final TextEditingController _feedbackController = TextEditingController();

//   void _submitFeedback() {
//     String feedbackText = _feedbackController.text.trim();
//     if (feedbackText.isNotEmpty) {
//       // Handle the feedback submission logic (e.g., send it to Firebase or an API)
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Thank you for your feedback!')),
//       );
//       _feedbackController.clear();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter your feedback before submitting.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Feedback & Suggestions'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'We value your feedback!',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Let us know your thoughts, report a bug, or suggest improvements.',
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _feedbackController,
//               maxLines: 5,
//               decoration: InputDecoration(
//                 hintText: 'Write your feedback here...',
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _submitFeedback,
//                 child: const Text('Submit'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
