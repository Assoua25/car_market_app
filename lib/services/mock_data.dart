import '../models/car.dart';

// ============================================================
// SERVICE : Données fictives pour le développement local
// ============================================================
class MockData {
  // Liste de voitures fictives (sera remplacée par Firestore en Phase 3)
  static List<Car> cars = [
    Car(
      id: '1',
      brand: 'Toyota',
      model: 'Corolla',
      year: 2022,
      price: 12500000,
      imageUrls: [
        'https://images.unsplash.com/photo-1623006772851-a8bf2c08b6f6?w=800',
        'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800',
      ],
      description:
          'Toyota Corolla en excellent état, très bien entretenue. Climatisation, GPS, caméra de recul, bluetooth. Carrosserie impeccable, intérieur propre. Première main, carnet d\'entretien à jour.',
      sellerId: 'user1',
      fuelType: 'Essence',
      mileage: 25000,
      transmission: 'Automatique',
      color: 'Blanc',
      location: 'Abidjan',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Car(
      id: '2',
      brand: 'BMW',
      model: 'X5',
      year: 2021,
      price: 35000000,
      imageUrls: [
        'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800',
        'https://images.unsplash.com/photo-1556189250-72ba954cfc2b?w=800',
      ],
      description:
          'BMW X5 SUV de luxe, full options. Cuir, toit panoramique, sièges chauffants, système son Harman Kardon. Conduite assistée, caméra 360°. Véhicule d\'exception.',
      sellerId: 'user2',
      fuelType: 'Diesel',
      mileage: 45000,
      transmission: 'Automatique',
      color: 'Noir',
      location: 'Abidjan',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Car(
      id: '3',
      brand: 'Mercedes',
      model: 'Classe C',
      year: 2020,
      price: 22000000,
      imageUrls: [
        'https://images.unsplash.com/photo-1617531653332-bd46c24f2068?w=800',
      ],
      description:
          'Mercedes Classe C élégante et performante. Intérieur cuir, ambiance lumineuse, GPS, Apple CarPlay. État neuf.',
      sellerId: 'user3',
      fuelType: 'Essence',
      mileage: 38000,
      transmission: 'Automatique',
      color: 'Gris',
      location: 'Yamoussoukro',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Car(
      id: '4',
      brand: 'Hyundai',
      model: 'Tucson',
      year: 2023,
      price: 18500000,
      imageUrls: [
        'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=800',
      ],
      description:
          'Hyundai Tucson SUV moderne, économique en carburant. Parfait pour les familles. Caméra de recul, écran tactile, climatisation automatique bi-zone.',
      sellerId: 'user1',
      fuelType: 'Hybride',
      mileage: 12000,
      transmission: 'Automatique',
      color: 'Bleu',
      location: 'Bouaké',
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    Car(
      id: '5',
      brand: 'Renault',
      model: 'Duster',
      year: 2021,
      price: 8500000,
      imageUrls: [
        'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=800',
      ],
      description:
          'Renault Duster SUV robuste, idéal pour les routes ivoiriennes. Excellent rapport qualité-prix. Climatisation, direction assistée.',
      sellerId: 'user4',
      fuelType: 'Diesel',
      mileage: 65000,
      transmission: 'Manuelle',
      color: 'Rouge',
      location: 'Abidjan',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Car(
      id: '6',
      brand: 'Peugeot',
      model: '3008',
      year: 2022,
      price: 16500000,
      imageUrls: [
        'https://images.unsplash.com/photo-1542362567-b07e54358753?w=800',
      ],
      description:
          'Peugeot 3008 GT Line. Design moderne, intérieur i-Cockpit. Toit panoramique, jantes alliage, GPS connecté.',
      sellerId: 'user2',
      fuelType: 'Essence',
      mileage: 22000,
      transmission: 'Automatique',
      color: 'Gris',
      location: 'Abidjan',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Car(
      id: '7',
      brand: 'Kia',
      model: 'Sportage',
      year: 2023,
      price: 19000000,
      imageUrls: [
        'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=800',
      ],
      description:
          'Kia Sportage flambant neuf. Garantie constructeur 5 ans. Technologie de pointe, sécurité maximale.',
      sellerId: 'user3',
      fuelType: 'Essence',
      mileage: 5000,
      transmission: 'Automatique',
      color: 'Blanc',
      location: 'Abidjan',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    Car(
      id: '8',
      brand: 'Ford',
      model: 'Ranger',
      year: 2020,
      price: 15000000,
      imageUrls: [
        'https://images.unsplash.com/photo-1605559424843-9e4c228bf1c2?w=800',
      ],
      description:
          'Ford Ranger Pick-up 4x4. Idéal pour les déplacements professionnels et les routes difficiles. Très robuste.',
      sellerId: 'user5',
      fuelType: 'Diesel',
      mileage: 78000,
      transmission: 'Manuelle',
      color: 'Noir',
      location: 'San-Pédro',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];

  // Méthode pour ajouter une nouvelle voiture (simulation)
  static void addCar(Car car) {
    cars.insert(0, car);
  }

  // Méthode pour supprimer une voiture
  static void removeCar(String id) {
    cars.removeWhere((car) => car.id == id);
  }

  // Méthode pour récupérer une voiture par ID
  static Car? getCarById(String id) {
    try {
      return cars.firstWhere((car) => car.id == id);
    } catch (e) {
      return null;
    }
  }

  // Méthode pour récupérer les marques uniques (pour les filtres)
  static List<String> getUniqueBrands() {
    final brands = cars.map((car) => car.brand).toSet().toList();
    brands.sort();
    return brands;
  }
}