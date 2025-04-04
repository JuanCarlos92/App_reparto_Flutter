import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  final String clientName;
  final String clientAddress;

  const DetailWidget({
    super.key,
    required this.clientName,
    required this.clientAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            clientName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            clientAddress,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
