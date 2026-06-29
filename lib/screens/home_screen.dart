import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/mock_data.dart';
import '../widgets/car_card.dart';
import '../theme/app_theme.dart';
import 'car_detail_screen.dart';

// ============================================================
// ÉCRAN ACCUEIL : Catalogue des véhicules
// ============================================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedBrand = 'Tous';
  String _selectedFuel = 'Tous';
  String _sortBy = 'Plus récent';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Liste filtrée des voitures
  List<Car> get _filteredCars {
    List<Car> result = List.from(MockData.cars);

    // Filtre par recherche
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      result = result.where((car) {
        return car.brand.toLowerCase().contains(query) ||
            car.model.toLowerCase().contains(query) ||
            car.location.toLowerCase().contains(query);
      }).toList();
    }

    // Filtre par marque
    if (_selectedBrand != 'Tous') {
      result = result.where((car) => car.brand == _selectedBrand).toList();
    }

    // Filtre par carburant
    if (_selectedFuel != 'Tous') {
      result = result.where((car) => car.fuelType == _selectedFuel).toList();
    }

    // Tri
    if (_sortBy == 'Prix croissant') {
      result.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'Prix décroissant') {
      result.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortBy == 'Plus récent') {
      result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return result;
  }

  // Affiche le modal de filtres
  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filtres',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Marque
                  const Text(
                    'Marque',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedBrand,
                    items: ['Tous', ...MockData.getUniqueBrands()]
                        .map((brand) => DropdownMenuItem(
                              value: brand,
                              child: Text(brand),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setModalState(() {
                        _selectedBrand = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Carburant
                  const Text(
                    'Type de carburant',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedFuel,
                    items: ['Tous', 'Essence', 'Diesel', 'Hybride', 'Électrique']
                        .map((fuel) => DropdownMenuItem(
                              value: fuel,
                              child: Text(fuel),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setModalState(() {
                        _selectedFuel = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Tri
                  const Text(
                    'Trier par',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _sortBy,
                    items: ['Plus récent', 'Prix croissant', 'Prix décroissant']
                        .map((sort) => DropdownMenuItem(
                              value: sort,
                              child: Text(sort),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setModalState(() {
                        _sortBy = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  // Boutons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setModalState(() {
                              _selectedBrand = 'Tous';
                              _selectedFuel = 'Tous';
                              _sortBy = 'Plus récent';
                            });
                          },
                          child: const Text('Réinitialiser'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: const Text('Appliquer'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredCars = _filteredCars;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Market'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilters,
            tooltip: 'Filtres',
          ),
        ],
      ),
      body: Column(
        children: [
          // Barre de recherche
          Container(
            padding: const EdgeInsets.all(16),
            color: AppTheme.primaryColor,
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Rechercher une voiture...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Compteur de résultats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredCars.length} véhicule(s) trouvé(s)',
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
                if (_selectedBrand != 'Tous' || _selectedFuel != 'Tous')
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedBrand = 'Tous';
                        _selectedFuel = 'Tous';
                      });
                    },
                    icon: const Icon(Icons.close, size: 16),
                    label: const Text('Effacer filtres'),
                  ),
              ],
            ),
          ),

          // GridView des voitures
          Expanded(
            child: filteredCars.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Aucun véhicule trouvé',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: filteredCars.length,
                    itemBuilder: (context, index) {
                      final car = filteredCars[index];
                      return CarCard(
                        car: car,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CarDetailScreen(car: car),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}