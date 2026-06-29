import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/mock_data.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';

// ============================================================
// ÉCRAN AJOUT : Formulaire pour ajouter une voiture
// ============================================================
class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _priceController = TextEditingController();
  final _mileageController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _colorController = TextEditingController();
  final _locationController = TextEditingController(text: 'Abidjan');

  String _fuelType = 'Essence';
  String _transmission = 'Manuelle';

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _priceController.dispose();
    _mileageController.dispose();
    _descriptionController.dispose();
    _colorController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newCar = Car(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        brand: _brandController.text.trim(),
        model: _modelController.text.trim(),
        year: int.parse(_yearController.text),
        price: double.parse(_priceController.text),
        imageUrls: [
          // Image placeholder (sera remplacée par image_picker en Phase 5)
          'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=800',
        ],
        description: _descriptionController.text.trim(),
        sellerId: AuthService().currentUser?.id ?? 'unknown',
        fuelType: _fuelType,
        mileage: int.parse(_mileageController.text),
        transmission: _transmission,
        color: _colorController.text.trim(),
        location: _locationController.text.trim(),
        createdAt: DateTime.now(),
      );

      MockData.addCar(newCar);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Annonce "${newCar.fullName}" ajoutée avec succès !'),
          backgroundColor: AppTheme.successColor,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une annonce'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Zone d'upload d'images (placeholder pour la Phase 5)
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[400]!,
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                    'Ajouter des photos\n(disponible en Phase 5)',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Informations générales',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Marque
            TextFormField(
              controller: _brandController,
              decoration: const InputDecoration(
                labelText: 'Marque *',
                hintText: 'Toyota, BMW, Mercedes...',
                prefixIcon: Icon(Icons.business),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez saisir la marque';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Modèle
            TextFormField(
              controller: _modelController,
              decoration: const InputDecoration(
                labelText: 'Modèle *',
                hintText: 'Corolla, X5, Classe C...',
                prefixIcon: Icon(Icons.directions_car),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez saisir le modèle';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Année
            TextFormField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Année *',
                hintText: '2022',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir l\'année';
                }
                final year = int.tryParse(value);
                if (year == null) {
                  return 'Année invalide';
                }
                if (year < 1990 || year > DateTime.now().year + 1) {
                  return 'Année entre 1990 et ${DateTime.now().year + 1}';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Prix
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Prix (FCFA) *',
                hintText: '12500000',
                prefixIcon: Icon(Icons.attach_money),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir le prix';
                }
                final price = double.tryParse(value);
                if (price == null || price <= 0) {
                  return 'Prix invalide';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Kilométrage
            TextFormField(
              controller: _mileageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Kilométrage *',
                hintText: '25000',
                prefixIcon: Icon(Icons.speed),
                suffixText: 'km',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir le kilométrage';
                }
                final km = int.tryParse(value);
                if (km == null || km < 0) {
                  return 'Kilométrage invalide';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            const Text(
              'Caractéristiques techniques',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Carburant
            DropdownButtonFormField<String>(
              initialValue: _fuelType,
              decoration: const InputDecoration(
                labelText: 'Type de carburant *',
                prefixIcon: Icon(Icons.local_gas_station),
              ),
              items: ['Essence', 'Diesel', 'Hybride', 'Électrique']
                  .map((fuel) => DropdownMenuItem(
                        value: fuel,
                        child: Text(fuel),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _fuelType = value!;
                });
              },
            ),
            const SizedBox(height: 12),

            // Transmission
            DropdownButtonFormField<String>(
              initialValue: _transmission,
              decoration: const InputDecoration(
                labelText: 'Transmission *',
                prefixIcon: Icon(Icons.settings),
              ),
              items: ['Manuelle', 'Automatique']
                  .map((trans) => DropdownMenuItem(
                        value: trans,
                        child: Text(trans),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _transmission = value!;
                });
              },
            ),
            const SizedBox(height: 12),

            // Couleur
            TextFormField(
              controller: _colorController,
              decoration: const InputDecoration(
                labelText: 'Couleur *',
                hintText: 'Blanc, Noir, Gris...',
                prefixIcon: Icon(Icons.palette),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez saisir la couleur';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Localisation
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Localisation *',
                hintText: 'Abidjan, Yamoussoukro...',
                prefixIcon: Icon(Icons.location_on),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez saisir la localisation';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Description
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description détaillée *',
                hintText:
                    'Décrivez votre véhicule : état général, équipements, historique...',
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez saisir une description';
                }
                if (value.trim().length < 20) {
                  return 'Description trop courte (min. 20 caractères)';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Bouton soumettre
            SizedBox(
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.check_circle, color: Colors.white),
                label: const Text(
                  'Publier l\'annonce',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}