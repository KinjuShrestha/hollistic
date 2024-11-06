import 'package:flutter/material.dart';
import 'package:holistic/features/offering/provider/offering_provider.dart';
import 'package:holistic/features/offering/ui/edit_offering.dart';
import 'package:provider/provider.dart';

class OfferingsListScreen extends StatelessWidget {
  final List<Color> tileColors = [
    const Color(0xFFF8E9F1), 
    const Color(0xFFE3F6FC), 
    const Color(0xFFF4F8E8), 
  ];

  OfferingsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Holistic Offerings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[50],
      body: Consumer<OfferingsProvider>(
        builder: (context, offeringsProvider, child) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            itemCount: offeringsProvider.offerings.length,
            itemBuilder: (context, index) {
              final offering = offeringsProvider.offerings[index];
              final backgroundColor = tileColors[index % tileColors.length];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditOfferingScreen(
                        offering: offering,
                        index: index,
                      ),
                    ),
                  ),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offering.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Practitioner: ${offering.practitionerName}',
                                style: const TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                              Text(
                                'Category: ${offering.category}',
                                style: const TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Duration: ${offering.duration}',
                                style: const TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                              Text(
                                'Type: ${offering.type}',
                                style: const TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          Text(
                            '\$${offering.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 8),

                          Text(
                            offering.description.length > 80
                                ? '${offering.description.substring(0, 80)}...'
                                : offering.description,
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(height: 12),

                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => offeringsProvider.deleteOffering(index),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddEditOfferingScreen(),
          ),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
