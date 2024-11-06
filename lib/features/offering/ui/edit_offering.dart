import 'package:flutter/material.dart';
import 'package:holistic/features/offering/data/offerings.dart';
import 'package:holistic/features/offering/provider/offering_provider.dart';
import 'package:provider/provider.dart';

class AddEditOfferingScreen extends StatefulWidget {
  final Offering? offering;
  final int? index;

  const AddEditOfferingScreen({super.key, this.offering, this.index});

  @override
  // ignore: library_private_types_in_public_api
  _AddEditOfferingScreenState createState() => _AddEditOfferingScreenState();
}

class _AddEditOfferingScreenState extends State<AddEditOfferingScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _durationController = TextEditingController();
  final _priceController = TextEditingController();
  final _practitionerController = TextEditingController();

  String? _selectedCategory;
  String _selectedType = 'In-Person';

  final List<String> _categories = ['Spiritual', 'Mental', 'Emotional','Physical'];
  final List<String> _durations = ['30 min', '1 hr', '2 hrs'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 

  @override
  void initState() {
    super.initState();
    if (widget.offering != null) {
      _titleController.text = widget.offering!.title;
      _descriptionController.text = widget.offering!.description;
      _categoryController.text = widget.offering!.category;
      _durationController.text = widget.offering!.duration;
      _priceController.text = widget.offering!.price.toString();
      _practitionerController.text = widget.offering!.practitionerName;
      _selectedCategory = widget.offering!.category;
      _selectedType = widget.offering!.type;
    }
  }

  void _saveOffering() {
    if (!_formKey.currentState!.validate()) {
      return; 
    }

    final title = _titleController.text;
    final description = _descriptionController.text;
    final category = _selectedCategory ?? '';
    final duration = _durationController.text;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    final practitionerName = _practitionerController.text;

    final newOffering = Offering(
      title: title,
      description: description,
      category: category,
      duration: duration,
      price: price,
      practitionerName: practitionerName,
      type: _selectedType,
    );

    final offeringsProvider = Provider.of<OfferingsProvider>(context, listen: false);

    if (widget.index == null) {
      offeringsProvider.addOffering(newOffering);
    } else {
      offeringsProvider.updateOffering(widget.index!, newOffering);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.offering == null ? 'Add Offering' : 'Edit Offering'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, 
          child: ListView(
            children: [
              TextFormField(
                controller: _practitionerController,
                decoration: const InputDecoration(labelText: 'Practitioner Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the practitioner\'s name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                value: _durationController.text.isNotEmpty ? _durationController.text : '30 min',
                decoration: const InputDecoration(labelText: 'Duration'),
                onChanged: (newValue) {
                  setState(() {
                    _durationController.text = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a duration';
                  }
                  return null;
                },
                items: _durations.map((duration) {
                  return DropdownMenuItem(
                    value: duration,
                    child: Text(duration),
                  );
                }).toList(),
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'In-Person',
                    groupValue: _selectedType,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                  const Text('In-Person'),
                  Radio<String>(
                    value: 'Online',
                    groupValue: _selectedType,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                  const Text('Online'),
                ],
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveOffering,
                child: const Text('Save Offering'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
