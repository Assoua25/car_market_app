// ============================================================
// MODÈLE : Représente un véhicule dans l'application
// ============================================================
class Car {
  final String id;
  final String brand;       // Marque (Toyota, BMW, etc.)
  final String model;       // Modèle (Corolla, X5, etc.)
  final int year;           // Année
  final double price;       // Prix en FCFA
  final List<String> imageUrls; // URLs des photos
  final String description; // Description détaillée
  final String sellerId;    // ID du vendeur
  final String fuelType;    // Essence, Diesel, Hybride, Électrique
  final int mileage;        // Kilométrage
  final String transmission; // Manuelle, Automatique
  final String color;       // Couleur
  final String location;    // Ville
  final DateTime createdAt; // Date de publication

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.price,
    required this.imageUrls,
    required this.description,
    required this.sellerId,
    required this.fuelType,
    required this.mileage,
    required this.transmission,
    required this.color,
    required this.location,
    required this.createdAt,
  });

  // Getter utile : nom complet de la voiture
  String get fullName => '$brand $model';

  // Getter utile : prix formaté en FCFA
  String get formattedPrice {
    return '${price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]} ',
        )} FCFA';
  }

  // Conversion depuis une Map (utile plus tard pour Firestore)
  factory Car.fromMap(Map<String, dynamic> data, String documentId) {
    return Car(
      id: documentId,
      brand: data['brand'] ?? '',
      model: data['model'] ?? '',
      year: data['year'] ?? 2000,
      price: (data['price'] as num).toDouble(),
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      description: data['description'] ?? '',
      sellerId: data['sellerId'] ?? '',
      fuelType: data['fuelType'] ?? 'Essence',
      mileage: data['mileage'] ?? 0,
      transmission: data['transmission'] ?? 'Manuelle',
      color: data['color'] ?? 'Noir',
      location: data['location'] ?? 'Abidjan',
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'])
          : DateTime.now(),
    );
  }

  // Conversion vers une Map (utile plus tard pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'model': model,
      'year': year,
      'price': price,
      'imageUrls': imageUrls,
      'description': description,
      'sellerId': sellerId,
      'fuelType': fuelType,
      'mileage': mileage,
      'transmission': transmission,
      'color': color,
      'location': location,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}