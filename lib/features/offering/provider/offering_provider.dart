import 'package:flutter/material.dart';
import 'package:holistic/features/offering/data/offerings.dart';

class OfferingsProvider extends ChangeNotifier {
  final List<Offering> _offerings = [
    Offering(
      title: 'Child Therapy',
      category: 'Mental',
      practitionerName: 'John Doe',
      description: 'A comprehensive approach to help children cope with emotions.',
      duration: '1 hr',
      price: 50.0,
      type: 'In-Person',
    ),
    Offering(
      title: 'Meditation for Beginners',
      category: 'Spiritual',
      practitionerName: 'Jane Smith',
      description: 'A peaceful meditation session to clear your mind and reduce stress.',
      duration: '30 min',
      price: 30.0,
      type: 'Online',
    ),
    Offering(
      title: 'Yoga for Flexibility',
      category: 'Physical',
      practitionerName: 'Alice Johnson',
      description: 'A yoga session focused on improving flexibility and mobility.',
      duration: '1 hr',
      price: 40.0,
      type: 'In-Person',
    ),
    Offering(
      title: 'Mindfulness for Stress Relief',
      category: 'Mental',
      practitionerName: 'Robert Brown',
      description: 'A guided mindfulness session to manage stress and anxiety.',
      duration: '1 hr',
      price: 60.0,
      type: 'Online',
    ),
  ];

  List<Offering> get offerings => _offerings;

  void addOffering(Offering offering) {
    _offerings.add(offering);
    notifyListeners();
  }

  void deleteOffering(int index) {
    _offerings.removeAt(index);
    notifyListeners();
  }
  void updateOffering(int index, Offering updatedOffering) {
    _offerings[index] = updatedOffering;
    notifyListeners(); // Notify listeners when data changes
  }
}
