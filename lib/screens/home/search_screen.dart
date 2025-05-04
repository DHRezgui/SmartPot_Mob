import 'package:flutter/material.dart';
import 'package:smartpot/widgets/custom_bottom_navbar.dart';

class Plant {
  final String name;
  final String scientificName;
  final String imageUrl;
  final String category;
  final String description;

  const Plant({
    required this.name,
    required this.scientificName,
    required this.imageUrl,
    required this.category,
    required this.description,
  });
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Plant> _searchResults = [];
  bool _showNoResults = false;
  Plant? _selectedPlant;

  // Méthode pour obtenir toutes les plantes (fusion de toutes les catégories)
  List<Plant> _getAllPlants() {
    return [
      ...getPlantsByCategory('foliage'),
      ...getPlantsByCategory('flowering'),
      ...getPlantsByCategory('succulents'),
      ...getPlantsByCategory('trees'),
      ...getPlantsByCategory('weeds'),
      ...getPlantsByCategory('shrubs'),
      ...getPlantsByCategory('fruits'),
      ...getPlantsByCategory('vegetables'),
      ...getPlantsByCategory('herbs'),
      ...getPlantsByCategory('mushrooms'),
      ...getPlantsByCategory('toxic'),
    ];
  }

  // Méthode pour effectuer la recherche
  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _showNoResults = false;
        _selectedPlant = null;
      });
      return;
    }

    final allPlants = _getAllPlants();
    final lowerQuery = query.toLowerCase();

    // Filtrer les plantes qui correspondent partiellement ou complètement
    final results =
        allPlants.where((plant) {
          return plant.name.toLowerCase().contains(lowerQuery) ||
              plant.scientificName.toLowerCase().contains(lowerQuery);
        }).toList();

    // Trier par pertinence (les correspondances exactes d'abord)
    results.sort((a, b) {
      final aNameMatch = a.name.toLowerCase() == lowerQuery;
      final bNameMatch = b.name.toLowerCase() == lowerQuery;
      final aSciMatch = a.scientificName.toLowerCase() == lowerQuery;
      final bSciMatch = b.scientificName.toLowerCase() == lowerQuery;

      if (aNameMatch || aSciMatch) return -1;
      if (bNameMatch || bSciMatch) return 1;
      return a.name
          .toLowerCase()
          .indexOf(lowerQuery)
          .compareTo(b.name.toLowerCase().indexOf(lowerQuery));
    });

    setState(() {
      _searchResults = results;
      _showNoResults = results.isEmpty;
      _selectedPlant = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    int bottomNavIndex = 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Search Plants',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset(
            'assets/images/logoApp1.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            semanticLabel: 'App logo',
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Builder(
              builder: (context) {
                return TextField(
                  controller: _searchController,
                  onChanged: (text) {
                    _performSearch(text);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search plants..',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade400,
                      size: 18,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child:
                _showNoResults
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '😢',
                            style: TextStyle(fontSize: 60, color: Colors.green),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No plants found',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Check your keywords or try searching with different ones',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final plant = _searchResults[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                plant.imageUrl,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              plant.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Text(
                              plant.scientificName,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontStyle: FontStyle.italic,
                                fontSize: 13,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: Colors.green,
                            ),
                            onTap: () {
                              setState(() {
                                _selectedPlant = plant;
                              });
                            },
                          ),
                        );
                      },
                    ),
          ),

          // Ajout de la carte de détails de la plante sélectionnée
          if (_selectedPlant != null) ...[
            const SizedBox(height: 20),
            Center(
              // Ajout d'un Center pour centrer horizontalement
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  // Utilisation d'un Stack pour positionner la croix
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  _selectedPlant!.imageUrl,
                                  height:
                                      200, // Image plus grande (200 au lieu de 120)
                                  width:
                                      double
                                          .infinity, // Prend toute la largeur disponible
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _selectedPlant!.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _selectedPlant!.scientificName,
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.category,
                                  size: 18,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _selectedPlant!.category,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _selectedPlant!.description,
                              style: const TextStyle(fontSize: 14),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Bouton de fermeture (croix)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedPlant = null; // Ferme le rectangle
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: bottomNavIndex,
        selectedColor: Color(0xFF047857),
        unselectedColor: Color(0xFF6B7280),
        selectedFontSize: 12,
        unselectedFontSize: 10,
      ),
    );
  }

  List<Plant> getPlantsByCategory(String categoryId) {
    switch (categoryId.toLowerCase()) {
      case 'foliage':
        return [
          Plant(
            name: 'Prayer Plant',
            scientificName: 'Goeppertia orbifolia',
            imageUrl: 'assets/images/prayer_plant.jpeg',
            category: 'Foliage',
            description:
                'Known for its striking leaf patterns that fold upward in the evening like praying hands. Prefers humid environments and indirect light.',
          ),
          Plant(
            name: 'Baby Rubber Plant',
            scientificName: 'Peperomia obtusifolia',
            imageUrl: 'assets/images/baby_rubber_plant.jpeg',
            category: 'Foliage',
            description:
                'Compact plant with thick, glossy leaves. Easy to care for, prefers bright indirect light and moderate watering.',
          ),
          Plant(
            name: 'Snake Plant',
            scientificName: 'Sansevieria trifasciata',
            imageUrl: 'assets/images/snake_plant.jpeg',
            category: 'Foliage',
            description:
                'Extremely hardy with upright, sword-like leaves. Purifies air and thrives in low light with infrequent watering.',
          ),
          Plant(
            name: 'ZZ Plant',
            scientificName: 'Zamioculcas zamiifolia',
            imageUrl: 'assets/images/zz_plant.jpeg',
            category: 'Foliage',
            description:
                'Drought-tolerant with glossy green leaves. Perfect for beginners as it survives low light and irregular watering.',
          ),
          Plant(
            name: 'Pothos',
            scientificName: 'Epipremnum aureum',
            imageUrl: 'assets/images/pothos.jpeg',
            category: 'Foliage',
            description:
                'Fast-growing vine with heart-shaped leaves. Adapts to various light conditions and purifies indoor air.',
          ),
          Plant(
            name: 'Philodendron',
            scientificName: 'Philodendron scandens',
            imageUrl: 'assets/images/philodendron.jpeg',
            category: 'Foliage',
            description:
                'Popular climbing plant with heart-shaped leaves. Prefers medium light and moderate watering.',
          ),
          Plant(
            name: 'Swiss Cheese Plant',
            scientificName: 'Monstera deliciosa',
            imageUrl: 'assets/images/swiss_cheese_plant.jpeg',
            category: 'Foliage',
            description:
                'Iconic plant with large, fenestrated leaves. Enjoys bright indirect light and humid conditions.',
          ),
          Plant(
            name: 'Chinese Evergreen',
            scientificName: 'Aglaonema commutatum',
            imageUrl: 'assets/images/chinese_evergreen.jpeg',
            category: 'Foliage',
            description:
                'Colorful, low-maintenance plant that tolerates low light. Leaves feature beautiful patterns in silver and green.',
          ),
          Plant(
            name: 'Cast Iron Plant',
            scientificName: 'Aspidistra elatior',
            imageUrl: 'assets/images/cast_iron_plant.jpeg',
            category: 'Foliage',
            description:
                'Extremely tough plant that survives neglect, low light, and temperature fluctuations. Dark green strappy leaves.',
          ),
          Plant(
            name: 'Croton',
            scientificName: 'Codiaeum variegatum',
            imageUrl: 'assets/images/croton.jpeg',
            category: 'Foliage',
            description:
                'Colorful plant with vibrant multicolored leaves. Requires bright light to maintain its striking colors.',
          ),
        ];

      case 'flowering':
        return [
          Plant(
            name: 'African Violet',
            scientificName: 'Saintpaulia ionantha',
            imageUrl: 'assets/images/african_violet.jpeg',
            category: 'Flowering',
            description:
                'Compact flowering plant with velvety leaves and clusters of purple, pink, or white flowers. Prefers bright indirect light.',
          ),
          Plant(
            name: 'Peace Lily',
            scientificName: 'Spathiphyllum wallisii',
            imageUrl: 'assets/images/peace_lily.jpeg',
            category: 'Flowering',
            description:
                'Produces elegant white spathes and thrives in low light. Excellent air purifier that indicates when it needs water by drooping.',
          ),
          Plant(
            name: 'Orchid',
            scientificName: 'Phalaenopsis spp.',
            imageUrl: 'assets/images/orchid.jpeg',
            category: 'Flowering',
            description:
                'Exotic flowers that last for months. Prefers bright indirect light, high humidity, and specialized orchid potting mix.',
          ),
          Plant(
            name: 'Anthurium',
            scientificName: 'Anthurium andraeanum',
            imageUrl: 'assets/images/anthurium.jpeg',
            category: 'Flowering',
            description:
                'Known for its glossy red spathes and yellow spadices. Blooms repeatedly with proper care and bright filtered light.',
          ),
          Plant(
            name: 'Begonia',
            scientificName: 'Begonia semperflorens',
            imageUrl: 'assets/images/begonia.jpeg',
            category: 'Flowering',
            description:
                'Colorful flowers with attractive foliage. Prefers humid conditions and consistent moisture without waterlogging.',
          ),
          Plant(
            name: 'Geranium',
            scientificName: 'Pelargonium spp.',
            imageUrl: 'assets/images/geranium.jpeg',
            category: 'Flowering',
            description:
                'Popular garden plant with clusters of vibrant flowers. Prefers full sun and well-draining soil.',
          ),
          Plant(
            name: 'Hibiscus',
            scientificName: 'Hibiscus rosa-sinensis',
            imageUrl: 'assets/images/hibiscus.jpeg',
            category: 'Flowering',
            description:
                'Large, showy flowers in tropical colors. Requires plenty of sunlight and regular watering during growing season.',
          ),
          Plant(
            name: 'Petunia',
            scientificName: 'Petunia × atkinsiana',
            imageUrl: 'assets/images/petunia.jpeg',
            category: 'Flowering',
            description:
                'Cascading flowers ideal for hanging baskets. Blooms profusely in full sun with regular deadheading.',
          ),
          Plant(
            name: 'Marigold',
            scientificName: 'Tagetes erecta',
            imageUrl: 'assets/images/marigold.jpeg',
            category: 'Flowering',
            description:
                'Bright orange or yellow flowers that repel garden pests. Easy to grow in full sun with well-drained soil.',
          ),
          Plant(
            name: 'Rose',
            scientificName: 'Rosa spp.',
            imageUrl: 'assets/images/rose.jpeg',
            category: 'Flowering',
            description:
                'Classic flowering shrub with fragrant blooms. Requires full sun, rich soil, and regular pruning for best results.',
          ),
        ];

      case 'succulents':
        return [
          Plant(
            name: 'Aloe Vera',
            scientificName: 'Aloe barbadensis miller',
            imageUrl: 'assets/images/aloe_vera.jpeg',
            category: 'Succulent',
            description:
                'Medicinal plant with soothing gel inside its leaves. Thrives in bright light with infrequent watering.',
          ),
          Plant(
            name: 'Zebra Haworthia',
            scientificName: 'Haworthiopsis attenuata',
            imageUrl: 'assets/images/zebra_haworthia.jpeg',
            category: 'Succulent',
            description:
                'Small succulent with white striped pattern. Prefers bright indirect light and minimal watering.',
          ),
          Plant(
            name: 'Jade Plant',
            scientificName: 'Crassula ovata',
            imageUrl: 'assets/images/jade_plant.jpeg',
            category: 'Succulent',
            description:
                'Tree-like succulent with thick, oval leaves. Considered a symbol of good luck and requires bright light.',
          ),
          Plant(
            name: "Burro's Tail",
            scientificName: 'Sedum morganianum',
            imageUrl: 'assets/images/burros_tail.jpeg',
            category: 'Succulent',
            description:
                'Trailing succulent with plump, blue-green leaves. Perfect for hanging baskets in bright light.',
          ),
          Plant(
            name: 'Echeveria',
            scientificName: 'Echeveria elegans',
            imageUrl: 'assets/images/echeveria.jpeg',
            category: 'Succulent',
            description:
                'Rosette-forming succulent with pastel tones. Needs plenty of sunlight to maintain compact form.',
          ),
          Plant(
            name: 'Panda Plant',
            scientificName: 'Kalanchoe tomentosa',
            imageUrl: 'assets/images/panda_plant.jpeg',
            category: 'Succulent',
            description:
                'Fuzzy leaves with brown edges resembling panda paws. Prefers bright light and infrequent watering.',
          ),
          Plant(
            name: 'Crown of Thorns',
            scientificName: 'Euphorbia milii',
            imageUrl: 'assets/images/crown_of_thorns.jpeg',
            category: 'Succulent',
            description:
                'Thorny stems with colorful bracts that bloom year-round. Tolerates drought but needs bright light.',
          ),
          Plant(
            name: 'Lithops',
            scientificName: 'Lithops spp.',
            imageUrl: 'assets/images/lithops.jpeg',
            category: 'Succulent',
            description:
                'Unique "living stones" that mimic pebbles. Requires very little water and plenty of sunlight.',
          ),
          Plant(
            name: 'Agave',
            scientificName: 'Agave americana',
            imageUrl: 'assets/images/agave.jpeg',
            category: 'Succulent',
            description:
                'Large rosette with spiky leaves. Drought-tolerant but needs space as it can grow quite large.',
          ),
          Plant(
            name: 'Christmas Cactus',
            scientificName: 'Schlumbergera bridgesii',
            imageUrl: 'assets/images/christmas_cactus.jpeg',
            category: 'Succulent',
            description:
                'Holiday-blooming cactus with segmented stems. Prefers more water than desert cacti and indirect light.',
          ),
        ];

      case 'trees':
        return [
          Plant(
            name: 'Oak Tree',
            scientificName: 'Quercus robur',
            imageUrl: 'assets/images/oak_tree.jpeg',
            category: 'Tree',
            description:
                'Majestic deciduous tree with lobed leaves and acorns. Symbol of strength, can live for centuries.',
          ),
          Plant(
            name: 'Maple Tree',
            scientificName: 'Acer saccharum',
            imageUrl: 'assets/images/maple_tree.jpeg',
            category: 'Tree',
            description:
                'Known for its spectacular fall colors and maple syrup. Prefers temperate climates with distinct seasons.',
          ),
          Plant(
            name: 'Pine Tree',
            scientificName: 'Pinus sylvestris',
            imageUrl: 'assets/images/pine_tree.jpeg',
            category: 'Tree',
            description:
                'Evergreen conifer with needle-like leaves and pine cones. Adaptable to various soil conditions.',
          ),
          Plant(
            name: 'Cherry Tree',
            scientificName: 'Prunus avium',
            imageUrl: 'assets/images/cherry_tree.jpeg',
            category: 'Tree',
            description:
                'Ornamental tree famous for its spring blossoms. Some varieties produce edible cherries in summer.',
          ),
          Plant(
            name: 'Apple Tree',
            scientificName: 'Malus domestica',
            imageUrl: 'assets/images/apple_tree.jpeg',
            category: 'Tree',
            description:
                'Fruit-bearing tree requiring cross-pollination. Needs winter chill for proper fruiting.',
          ),
          Plant(
            name: 'Cedar',
            scientificName: 'Cedrus libani',
            imageUrl: 'assets/images/cedar.jpeg',
            category: 'Tree',
            description:
                'Aromatic evergreen with horizontal branching. Used for timber and its insect-repelling properties.',
          ),
          Plant(
            name: 'Olive Tree',
            scientificName: 'Olea europaea',
            imageUrl: 'assets/images/olive_tree.jpeg',
            category: 'Tree',
            description:
                'Mediterranean tree with silvery leaves. Drought-resistant and can live for over 1,000 years.',
          ),
          Plant(
            name: 'Eucalyptus',
            scientificName: 'Eucalyptus globulus',
            imageUrl: 'assets/images/eucalyptus.jpeg',
            category: 'Tree',
            description:
                'Fast-growing with aromatic leaves. Oil has medicinal properties but can be invasive in some areas.',
          ),
          Plant(
            name: 'Birch',
            scientificName: 'Betula pendula',
            imageUrl: 'assets/images/birch.jpeg',
            category: 'Tree',
            description:
                'Elegant tree with distinctive white bark. Prefers cool climates and moist, well-drained soil.',
          ),
          Plant(
            name: 'Magnolia',
            scientificName: 'Magnolia grandiflora',
            imageUrl: 'assets/images/magnolia.jpeg',
            category: 'Tree',
            description:
                'Ancient flowering tree with large, fragrant blooms. Some species are evergreen while others deciduous.',
          ),
        ];

      case 'weeds':
        return [
          Plant(
            name: 'Dandelion',
            scientificName: 'Taraxacum officinale',
            imageUrl: 'assets/images/dandelion.jpeg',
            category: 'Weed',
            description:
                'Common weed with yellow flowers that turn into puffballs. Edible leaves are rich in vitamins.',
          ),
          Plant(
            name: 'Crabgrass',
            scientificName: 'Digitaria sanguinalis',
            imageUrl: 'assets/images/crabgrass.jpeg',
            category: 'Weed',
            description:
                'Annual grass that spreads quickly in lawns. Difficult to control once established.',
          ),
          Plant(
            name: 'Bindweed',
            scientificName: 'Convolvulus arvensis',
            imageUrl: 'assets/images/bindweed.jpeg',
            category: 'Weed',
            description:
                'Vining weed with morning glory-like flowers. Spreads aggressively through deep roots.',
          ),
          Plant(
            name: 'Pigweed',
            scientificName: 'Amaranthus retroflexus',
            imageUrl: 'assets/images/pigweed.jpeg',
            category: 'Weed',
            description:
                'Fast-growing weed that competes with crops. Some species are edible and nutritious.',
          ),
          Plant(
            name: 'Ground Ivy',
            scientificName: 'Glechoma hederacea',
            imageUrl: 'assets/images/ground_ivy.jpeg',
            category: 'Weed',
            description:
                'Creeping perennial with scalloped leaves. Difficult to eradicate once established in lawns.',
          ),
          Plant(
            name: "Lamb's Quarters",
            scientificName: 'Chenopodium album',
            imageUrl: 'assets/images/lambs_quarters.jpeg',
            category: 'Weed',
            description:
                'Edible weed high in nutrients. Often found in disturbed soils and agricultural fields.',
          ),
          Plant(
            name: 'Chickweed',
            scientificName: 'Stellaria media',
            imageUrl: 'assets/images/chickweed.jpeg',
            category: 'Weed',
            description:
                'Low-growing annual with small white flowers. Common in gardens and prefers cool, moist conditions.',
          ),
          Plant(
            name: 'Creeping Charlie',
            scientificName: 'Glechoma hederacea',
            imageUrl: 'assets/images/creeping_charlie.jpeg',
            category: 'Weed',
            description:
                'Aggressive ground cover with rounded leaves. Spreads rapidly through both seeds and stems.',
          ),
          Plant(
            name: 'Nutsedge',
            scientificName: 'Cyperus esculentus',
            imageUrl: 'assets/images/nutsedge.jpeg',
            category: 'Weed',
            description:
                'Grass-like weed with triangular stems. Forms tubers that make it difficult to control.',
          ),
          Plant(
            name: 'Purslane',
            scientificName: 'Portulaca oleracea',
            imageUrl: 'assets/images/purslane.jpeg',
            category: 'Weed',
            description:
                'Succulent weed with edible leaves high in omega-3s. Spreads quickly in warm weather.',
          ),
        ];

      case 'shrubs':
        return [
          Plant(
            name: 'Boxwood',
            scientificName: 'Buxus sempervirens',
            imageUrl: 'assets/images/boxwood.jpeg',
            category: 'Shrub',
            description:
                'Dense evergreen shrub popular for hedges and topiary. Slow-growing with small, glossy leaves.',
          ),
          Plant(
            name: 'Hydrangea',
            scientificName: 'Hydrangea macrophylla',
            imageUrl: 'assets/images/hydrangea.jpeg',
            category: 'Shrub',
            description:
                'Flowering shrub with large blooms that change color based on soil pH. Prefers partial shade.',
          ),
          Plant(
            name: 'Azalea',
            scientificName: 'Rhododendron spp.',
            imageUrl: 'assets/images/azalea.jpeg',
            category: 'Shrub',
            description:
                'Spring-blooming shrub with vibrant flowers. Prefers acidic soil and dappled shade.',
          ),
          Plant(
            name: 'Forsythia',
            scientificName: 'Forsythia x intermedia',
            imageUrl: 'assets/images/forsythia.jpeg',
            category: 'Shrub',
            description:
                'Early bloomer with bright yellow flowers before leaves appear. Fast-growing and hardy.',
          ),
          Plant(
            name: 'Lilac',
            scientificName: 'Syringa vulgaris',
            imageUrl: 'assets/images/lilac.jpeg',
            category: 'Shrub',
            description:
                'Fragrant spring flowers in shades of purple, white, and pink. Prefers full sun and well-drained soil.',
          ),
          Plant(
            name: 'Spirea',
            scientificName: 'Spiraea japonica',
            imageUrl: 'assets/images/spirea.jpeg',
            category: 'Shrub',
            description:
                'Hardy shrub with clusters of small flowers. Many varieties with different bloom colors and growth habits.',
          ),
          Plant(
            name: 'Butterfly Bush',
            scientificName: 'Buddleja davidii',
            imageUrl: 'assets/images/butterfly_bush.jpeg',
            category: 'Shrub',
            description:
                'Produces long spikes of flowers that attract butterflies. Fast-growing and drought-tolerant once established.',
          ),
          Plant(
            name: 'Weigela',
            scientificName: 'Weigela florida',
            imageUrl: 'assets/images/weigela.jpeg',
            category: 'Shrub',
            description:
                'Spring-flowering shrub with trumpet-shaped blooms. Some varieties have colorful foliage.',
          ),
          Plant(
            name: 'Hibiscus Shrub',
            scientificName: 'Hibiscus syriacus',
            imageUrl: 'assets/images/hibiscus_shrub.jpeg',
            category: 'Shrub',
            description:
                'Summer-blooming shrub with large, showy flowers. Also known as Rose of Sharon.',
          ),
          Plant(
            name: 'Rose of Sharon',
            scientificName: 'Hibiscus syriacus',
            imageUrl: 'assets/images/rose_of_sharon.jpeg',
            category: 'Shrub',
            description:
                'Late summer bloomer with hibiscus-like flowers. Tolerates poor soil and drought conditions.',
          ),
        ];

      case 'fruits':
        return [
          Plant(
            name: 'Apple',
            scientificName: 'Malus domestica',
            imageUrl: 'assets/images/apple.jpeg',
            category: 'Fruit',
            description:
                'Popular temperate fruit with thousands of varieties. Requires cross-pollination and winter chilling.',
          ),
          Plant(
            name: 'Banana',
            scientificName: 'Musa spp.',
            imageUrl: 'assets/images/banana.jpeg',
            category: 'Fruit',
            description:
                'Tropical herbaceous plant producing elongated fruits. Actually a giant herb, not a tree.',
          ),
          Plant(
            name: 'Orange',
            scientificName: 'Citrus × sinensis',
            imageUrl: 'assets/images/orange.jpeg',
            category: 'Fruit',
            description:
                'Citrus fruit rich in vitamin C. Evergreen trees prefer subtropical climates with warm winters.',
          ),
          Plant(
            name: 'Strawberry',
            scientificName: 'Fragaria × ananassa',
            imageUrl: 'assets/images/strawberry.jpeg',
            category: 'Fruit',
            description:
                'Small perennial producing sweet red fruits. Grows well in containers and garden beds.',
          ),
          Plant(
            name: 'Mango',
            scientificName: 'Mangifera indica',
            imageUrl: 'assets/images/mango.jpeg',
            category: 'Fruit',
            description:
                'Tropical stone fruit with sweet, juicy flesh. Trees can grow very large in suitable climates.',
          ),
          Plant(
            name: 'Pineapple',
            scientificName: 'Ananas comosus',
            imageUrl: 'assets/images/pineapple.jpeg',
            category: 'Fruit',
            description:
                'Tropical bromeliad that grows as a ground plant. Takes 18-24 months to produce a single fruit.',
          ),
          Plant(
            name: 'Grapes',
            scientificName: 'Vitis vinifera',
            imageUrl: 'assets/images/grapes.jpeg',
            category: 'Fruit',
            description:
                'Vining fruit grown for fresh eating, wine, or raisins. Requires pruning and support structures.',
          ),
          Plant(
            name: 'Peach',
            scientificName: 'Prunus persica',
            imageUrl: 'assets/images/peach.jpeg',
            category: 'Fruit',
            description:
                'Juicy stone fruit with fuzzy skin. Trees require winter chilling and protection from late frosts.',
          ),
          Plant(
            name: 'Lemon',
            scientificName: 'Citrus limon',
            imageUrl: 'assets/images/lemon.jpeg',
            category: 'Fruit',
            description:
                'Acidic citrus fruit used for juice and flavoring. Evergreen trees are sensitive to cold temperatures.',
          ),
          Plant(
            name: 'Papaya',
            scientificName: 'Carica papaya',
            imageUrl: 'assets/images/papaya.jpeg',
            category: 'Fruit',
            description:
                'Fast-growing tropical tree with melon-like fruits. Both the fruit and leaves are edible.',
          ),
        ];

      case 'vegetables':
        return [
          Plant(
            name: 'Tomato',
            scientificName: 'Solanum lycopersicum',
            imageUrl: 'assets/images/tomato.jpeg',
            category: 'Vegetable',
            description:
                'Versatile fruit (used as vegetable) with many varieties. Requires full sun and consistent watering.',
          ),
          Plant(
            name: 'Carrot',
            scientificName: 'Daucus carota',
            imageUrl: 'assets/images/carrot.jpeg',
            category: 'Vegetable',
            description:
                'Root vegetable rich in beta-carotene. Prefers loose, sandy soil for straight root development.',
          ),
          Plant(
            name: 'Potato',
            scientificName: 'Solanum tuberosum',
            imageUrl: 'assets/images/potato.jpeg',
            category: 'Vegetable',
            description:
                'Starchy tuber grown underground. Requires hilling as plants grow to prevent greening of tubers.',
          ),
          Plant(
            name: 'Lettuce',
            scientificName: 'Lactuca sativa',
            imageUrl: 'assets/images/lettuce.jpeg',
            category: 'Vegetable',
            description:
                'Leafy green that grows best in cool weather. Many varieties from crisphead to loose-leaf.',
          ),
          Plant(
            name: 'Broccoli',
            scientificName: 'Brassica oleracea var. italica',
            imageUrl: 'assets/images/broccoli.jpeg',
            category: 'Vegetable',
            description:
                'Cool-season crop harvested for its edible flower heads. Rich in vitamins and minerals.',
          ),
          Plant(
            name: 'Spinach',
            scientificName: 'Spinacia oleracea',
            imageUrl: 'assets/images/spinach.jpeg',
            category: 'Vegetable',
            description:
                'Nutrient-dense leafy green. Grows quickly in cool weather and can be harvested multiple times.',
          ),
          Plant(
            name: 'Cabbage',
            scientificName: 'Brassica oleracea var. capitata',
            imageUrl: 'assets/images/cabbage.jpeg',
            category: 'Vegetable',
            description:
                'Forms tight heads of leaves. Comes in green, red, and savoy types. Prefers cool growing conditions.',
          ),
          Plant(
            name: 'Onion',
            scientificName: 'Allium cepa',
            imageUrl: 'assets/images/onion.jpeg',
            category: 'Vegetable',
            description:
                'Bulb vegetable used as flavor base. Can be grown from seeds, sets, or transplants.',
          ),
          Plant(
            name: 'Garlic',
            scientificName: 'Allium sativum',
            imageUrl: 'assets/images/garlic.jpeg',
            category: 'Vegetable',
            description:
                'Pungent bulb divided into cloves. Planted in fall for harvest the following summer in most climates.',
          ),
          Plant(
            name: 'Pepper',
            scientificName: 'Capsicum annuum',
            imageUrl: 'assets/images/pepper.jpeg',
            category: 'Vegetable',
            description:
                'Includes sweet and hot varieties. Requires warm temperatures and full sun for best production.',
          ),
        ];

      case 'herbs':
        return [
          Plant(
            name: 'Basil',
            scientificName: 'Ocimum basilicum',
            imageUrl: 'assets/images/basil.jpeg',
            category: 'Herb',
            description:
                'Fragrant annual herb essential for Italian cuisine. Prefers warm weather and regular harvesting to prevent flowering.',
          ),
          Plant(
            name: 'Parsley',
            scientificName: 'Petroselinum crispum',
            imageUrl: 'assets/images/parsley.jpeg',
            category: 'Herb',
            description:
                'Biennial herb used as garnish and flavoring. Rich in vitamins and takes patience to germinate from seed.',
          ),
          Plant(
            name: 'Mint',
            scientificName: 'Mentha spp.',
            imageUrl: 'assets/images/mint.jpeg',
            category: 'Herb',
            description:
                'Vigorous perennial with many varieties. Best contained as it spreads aggressively via runners.',
          ),
          Plant(
            name: 'Thyme',
            scientificName: 'Thymus vulgaris',
            imageUrl: 'assets/images/thyme.jpeg',
            category: 'Herb',
            description:
                'Low-growing perennial with tiny aromatic leaves. Drought-tolerant once established and prefers full sun.',
          ),
          Plant(
            name: 'Rosemary',
            scientificName: 'Salvia rosmarinus',
            imageUrl: 'assets/images/rosemary.jpeg',
            category: 'Herb',
            description:
                'Woody perennial with needle-like leaves. Prefers dry conditions and can grow into large bushes in warm climates.',
          ),
          Plant(
            name: 'Cilantro',
            scientificName: 'Coriandrum sativum',
            imageUrl: 'assets/images/cilantro.jpeg',
            category: 'Herb',
            description:
                'Cool-season herb where leaves are cilantro and seeds are coriander. Bolts quickly in warm weather.',
          ),
          Plant(
            name: 'Oregano',
            scientificName: 'Origanum vulgare',
            imageUrl: 'assets/images/oregano.jpeg',
            category: 'Herb',
            description:
                'Essential for Mediterranean cuisine. Flavor intensifies when dried. Spreads readily in the garden.',
          ),
          Plant(
            name: 'Chives',
            scientificName: 'Allium schoenoprasum',
            imageUrl: 'assets/images/chives.jpeg',
            category: 'Herb',
            description:
                'Mild onion-flavored perennial. Produces edible purple flowers and regrows quickly after cutting.',
          ),
          Plant(
            name: 'Dill',
            scientificName: 'Anethum graveolens',
            imageUrl: 'assets/images/dill.jpeg',
            category: 'Herb',
            description:
                'Feathery annual herb used for pickling and flavoring. Attracts beneficial insects to the garden.',
          ),
          Plant(
            name: 'Sage',
            scientificName: 'Salvia officinalis',
            imageUrl: 'assets/images/sage.jpeg',
            category: 'Herb',
            description:
                'Woody perennial with velvety gray-green leaves. Used in stuffings and prefers dry growing conditions.',
          ),
        ];

      case 'mushrooms':
        return [
          Plant(
            name: 'Button Mushroom',
            scientificName: 'Agaricus bisporus',
            imageUrl: 'assets/images/button_mushroom.jpeg',
            category: 'Mushroom',
            description:
                'Common edible mushroom available in white and brown varieties. Grows on composted organic material.',
          ),
          Plant(
            name: 'Shiitake',
            scientificName: 'Lentinula edodes',
            imageUrl: 'assets/images/shiitake.jpeg',
            category: 'Mushroom',
            description:
                'Meaty-textured mushroom with rich flavor. Traditionally grown on hardwood logs or sawdust blocks.',
          ),
          Plant(
            name: 'Oyster Mushroom',
            scientificName: 'Pleurotus ostreatus',
            imageUrl: 'assets/images/oyster_mushroom.jpeg',
            category: 'Mushroom',
            description:
                'Fast-growing mushroom that fruits in clusters. Can be cultivated on various substrates including coffee grounds.',
          ),
          Plant(
            name: 'Portobello',
            scientificName: 'Agaricus bisporus',
            imageUrl: 'assets/images/portobello.jpeg',
            category: 'Mushroom',
            description:
                'Mature version of the button mushroom with meaty texture. Often grilled or used as vegetarian burger patties.',
          ),
          Plant(
            name: 'Enoki',
            scientificName: 'Flammulina velutipes',
            imageUrl: 'assets/images/enoki.jpeg',
            category: 'Mushroom',
            description:
                'Long, thin mushrooms with small caps. Grown in high-CO2 environments to produce their distinctive shape.',
          ),
          Plant(
            name: 'Chanterelle',
            scientificName: 'Cantharellus cibarius',
            imageUrl: 'assets/images/chanterelle.jpeg',
            category: 'Mushroom',
            description:
                'Prized wild mushroom with fruity aroma and mild peppery taste. Forms mycorrhizal relationships with trees.',
          ),
          Plant(
            name: 'Morel',
            scientificName: 'Morchella esculenta',
            imageUrl: 'assets/images/morel.jpeg',
            category: 'Mushroom',
            description:
                'Highly sought-after wild mushroom with honeycomb appearance. Difficult to cultivate commercially.',
          ),
          Plant(
            name: 'King Oyster',
            scientificName: 'Pleurotus eryngii',
            imageUrl: 'assets/images/king_oyster.jpeg',
            category: 'Mushroom',
            description:
                'Meaty mushroom with thick stems. Popular in Asian cuisine and valued for its firm texture when cooked.',
          ),
          Plant(
            name: 'Turkey Tail',
            scientificName: 'Trametes versicolor',
            imageUrl: 'assets/images/turkey_tail.jpeg',
            category: 'Mushroom',
            description:
                'Colorful polypore mushroom known for medicinal properties. Grows on dead hardwood logs.',
          ),
          Plant(
            name: "Lion's Mane",
            scientificName: 'Hericium erinaceus',
            imageUrl: 'assets/images/lions_mane.jpeg',
            category: 'Mushroom',
            description:
                'Unique mushroom with cascading spines. Research suggests potential cognitive benefits from consumption.',
          ),
        ];

      case 'toxic':
        return [
          Plant(
            name: 'Oleander',
            scientificName: 'Nerium oleander',
            imageUrl: 'assets/images/oleander.jpeg',
            category: 'Toxic Plant',
            description:
                'All parts of this flowering shrub are extremely poisonous. Even smoke from burning oleander can be toxic.',
          ),
          Plant(
            name: 'Foxglove',
            scientificName: 'Digitalis purpurea',
            imageUrl: 'assets/images/foxglove.jpeg',
            category: 'Toxic Plant',
            description:
                'Beautiful but deadly - source of digitalis used in medicine but highly toxic if ingested directly.',
          ),
          Plant(
            name: 'Castor Bean',
            scientificName: 'Ricinus communis',
            imageUrl: 'assets/images/castor_bean.jpeg',
            category: 'Toxic Plant',
            description:
                'Seeds contain ricin, one of the most toxic naturally occurring substances. Ornamental in gardens.',
          ),
          Plant(
            name: 'Lily of the Valley',
            scientificName: 'Convallaria majalis',
            imageUrl: 'assets/images/lily_of_the_valley.jpeg',
            category: 'Toxic Plant',
            description:
                'Fragrant spring flowers but all parts contain cardiac glycosides that can cause heart problems if ingested.',
          ),
          Plant(
            name: 'Dumb Cane',
            scientificName: 'Dieffenbachia spp.',
            imageUrl: 'assets/images/dumb_cane.jpeg',
            category: 'Toxic Plant',
            description:
                'Popular houseplant whose sap contains calcium oxalate crystals that can cause temporary inability to speak if ingested.',
          ),
          Plant(
            name: 'Nightshade',
            scientificName: 'Atropa belladonna',
            imageUrl: 'assets/images/nightshade.jpeg',
            category: 'Toxic Plant',
            description:
                'Also called deadly nightshade, all parts are toxic. Historically used to make poison-tipped arrows.',
          ),
          Plant(
            name: 'Hemlock',
            scientificName: 'Conium maculatum',
            imageUrl: 'assets/images/hemlock.jpeg',
            category: 'Toxic Plant',
            description:
                'Infamous for being the poison that killed Socrates. Resembles edible plants like wild carrot but is fatally toxic.',
          ),
          Plant(
            name: "Angel's Trumpet",
            scientificName: 'Brugmansia spp.',
            imageUrl: 'assets/images/angels_trumpet.jpeg',
            category: 'Toxic Plant',
            description:
                'Tropical plant with large, hanging flowers. Contains tropane alkaloids that can cause hallucinations and death.',
          ),
          Plant(
            name: 'Yew',
            scientificName: 'Taxus baccata',
            imageUrl: 'assets/images/yew.jpeg',
            category: 'Toxic Plant',
            description:
                'Evergreen tree where all parts except the berry flesh are poisonous. Used in cancer drug paclitaxel.',
          ),
          Plant(
            name: 'Autumn Crocus',
            scientificName: 'Colchicum autumnale',
            imageUrl: 'assets/images/autumn_crocus.jpeg',
            category: 'Toxic Plant',
            description:
                'Contains colchicine, a toxic compound that can cause organ failure. Resembles edible spring crocuses.',
          ),
        ];

      default:
        return const [];
    }
  }
}
