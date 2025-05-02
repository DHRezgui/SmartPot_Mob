import 'package:flutter/material.dart';

// Modèle de plante
class Plant {
  final String name;
  final String scientificName;
  final String imageUrl;

  const Plant({
    required this.name,
    required this.scientificName,
    required this.imageUrl,
  });
}

// Écran de catégorie de plantes
class PlantCategoryScreen extends StatelessWidget {
  const PlantCategoryScreen({super.key});

  // Méthode pour récupérer les plantes selon la catégorie
  List<Plant> getPlantsByCategory(String categoryId) {
    switch (categoryId.toLowerCase()) {
      case 'foliage':
        return const [
          Plant(
            name: 'Prayer Plant',
            scientificName: 'Goeppertia orbifolia',
            imageUrl: 'assets/images/prayer_plant.jpeg',
          ),
          Plant(
            name: 'Baby Rubber Plant',
            scientificName: 'Peperomia obtusifolia',
            imageUrl: 'assets/images/baby_rubber_plant.jpeg',
          ),
          Plant(
            name: 'Snake Plant',
            scientificName: 'Sansevieria trifasciata',
            imageUrl: 'assets/images/snake_plant.jpeg',
          ),
          Plant(
            name: 'ZZ Plant',
            scientificName: 'Zamioculcas zamiifolia',
            imageUrl: 'assets/images/zz_plant.jpeg',
          ),
          Plant(
            name: 'Pothos',
            scientificName: 'Epipremnum aureum',
            imageUrl: 'assets/images/pothos.jpeg',
          ),
          Plant(
            name: 'Philodendron',
            scientificName: 'Philodendron scandens',
            imageUrl: 'assets/images/philodendron.jpeg',
          ),
          Plant(
            name: 'Swiss Cheese Plant',
            scientificName: 'Monstera deliciosa',
            imageUrl: 'assets/images/swiss_cheese_plant.jpeg',
          ),
          Plant(
            name: 'Chinese Evergreen',
            scientificName: 'Aglaonema commutatum',
            imageUrl: 'assets/images/chinese_evergreen.jpeg',
          ),
          Plant(
            name: 'Cast Iron Plant',
            scientificName: 'Aspidistra elatior',
            imageUrl: 'assets/images/cast_iron_plant.jpeg',
          ),
          Plant(
            name: 'Croton',
            scientificName: 'Codiaeum variegatum',
            imageUrl: 'assets/images/croton.jpeg',
          ),
        ];

      case 'flowering':
        return const [
          Plant(
            name: 'African Violet',
            scientificName: 'Saintpaulia ionantha',
            imageUrl: 'assets/images/african_violet.jpeg',
          ),
          Plant(
            name: 'Peace Lily',
            scientificName: 'Spathiphyllum wallisii',
            imageUrl: 'assets/images/peace_lily.jpeg',
          ),
          Plant(
            name: 'Orchid',
            scientificName: 'Phalaenopsis spp.',
            imageUrl: 'assets/images/orchid.jpeg',
          ),
          Plant(
            name: 'Anthurium',
            scientificName: 'Anthurium andraeanum',
            imageUrl: 'assets/images/anthurium.jpeg',
          ),
          Plant(
            name: 'Begonia',
            scientificName: 'Begonia semperflorens',
            imageUrl: 'assets/images/begonia.jpeg',
          ),
          Plant(
            name: 'Geranium',
            scientificName: 'Pelargonium spp.',
            imageUrl: 'assets/images/geranium.jpeg',
          ),
          Plant(
            name: 'Hibiscus',
            scientificName: 'Hibiscus rosa-sinensis',
            imageUrl: 'assets/images/hibiscus.jpeg',
          ),
          Plant(
            name: 'Petunia',
            scientificName: 'Petunia × atkinsiana',
            imageUrl: 'assets/images/petunia.jpeg',
          ),
          Plant(
            name: 'Marigold',
            scientificName: 'Tagetes erecta',
            imageUrl: 'assets/images/marigold.jpeg',
          ),
          Plant(
            name: 'Rose',
            scientificName: 'Rosa spp.',
            imageUrl: 'assets/images/rose.jpeg',
          ),
        ];

      case 'succulents':
        return const [
          Plant(
            name: 'Aloe Vera',
            scientificName: 'Aloe barbadensis miller',
            imageUrl: 'assets/images/aloe_vera.jpeg',
          ),
          Plant(
            name: 'Zebra Haworthia',
            scientificName: 'Haworthiopsis attenuata',
            imageUrl: 'assets/images/zebra_haworthia.jpeg',
          ),
          Plant(
            name: 'Jade Plant',
            scientificName: 'Crassula ovata',
            imageUrl: 'assets/images/jade_plant.jpeg',
          ),
          Plant(
            name: "Burro's Tail",
            scientificName: 'Sedum morganianum',
            imageUrl: 'assets/images/burros_tail.jpeg',
          ),
          Plant(
            name: 'Echeveria',
            scientificName: 'Echeveria elegans',
            imageUrl: 'assets/images/echeveria.jpeg',
          ),
          Plant(
            name: 'Panda Plant',
            scientificName: 'Kalanchoe tomentosa',
            imageUrl: 'assets/images/panda_plant.jpeg',
          ),
          Plant(
            name: 'Crown of Thorns',
            scientificName: 'Euphorbia milii',
            imageUrl: 'assets/images/crown_of_thorns.jpeg',
          ),
          Plant(
            name: 'Lithops',
            scientificName: 'Lithops spp.',
            imageUrl: 'assets/images/lithops.jpeg',
          ),
          Plant(
            name: 'Agave',
            scientificName: 'Agave americana',
            imageUrl: 'assets/images/agave.jpeg',
          ),
          Plant(
            name: 'Christmas Cactus',
            scientificName: 'Schlumbergera bridgesii',
            imageUrl: 'assets/images/christmas_cactus.jpeg',
          ),
        ];

      case 'trees':
        return const [
          Plant(
            name: 'Oak Tree',
            scientificName: 'Quercus robur',
            imageUrl: 'assets/images/oak_tree.jpeg',
          ),
          Plant(
            name: 'Maple Tree',
            scientificName: 'Acer saccharum',
            imageUrl: 'assets/images/maple_tree.jpeg',
          ),
          Plant(
            name: 'Pine Tree',
            scientificName: 'Pinus sylvestris',
            imageUrl: 'assets/images/pine_tree.jpeg',
          ),
          Plant(
            name: 'Cherry Tree',
            scientificName: 'Prunus avium',
            imageUrl: 'assets/images/cherry_tree.jpeg',
          ),
          Plant(
            name: 'Apple Tree',
            scientificName: 'Malus domestica',
            imageUrl: 'assets/images/apple_tree.jpeg',
          ),
          Plant(
            name: 'Cedar',
            scientificName: 'Cedrus libani',
            imageUrl: 'assets/images/cedar.jpeg',
          ),
          Plant(
            name: 'Olive Tree',
            scientificName: 'Olea europaea',
            imageUrl: 'assets/images/olive_tree.jpeg',
          ),
          Plant(
            name: 'Eucalyptus',
            scientificName: 'Eucalyptus globulus',
            imageUrl: 'assets/images/eucalyptus.jpeg',
          ),
          Plant(
            name: 'Birch',
            scientificName: 'Betula pendula',
            imageUrl: 'assets/images/birch.jpeg',
          ),
          Plant(
            name: 'Magnolia',
            scientificName: 'Magnolia grandiflora',
            imageUrl: 'assets/images/magnolia.jpeg',
          ),
        ];

      case 'weeds':
        return const [
          Plant(
            name: 'Dandelion',
            scientificName: 'Taraxacum officinale',
            imageUrl: 'assets/images/dandelion.jpeg',
          ),
          Plant(
            name: 'Crabgrass',
            scientificName: 'Digitaria sanguinalis',
            imageUrl: 'assets/images/crabgrass.jpeg',
          ),
          Plant(
            name: 'Bindweed',
            scientificName: 'Convolvulus arvensis',
            imageUrl: 'assets/images/bindweed.jpeg',
          ),
          Plant(
            name: 'Pigweed',
            scientificName: 'Amaranthus retroflexus',
            imageUrl: 'assets/images/pigweed.jpeg',
          ),
          Plant(
            name: 'Ground Ivy',
            scientificName: 'Glechoma hederacea',
            imageUrl: 'assets/images/ground_ivy.jpeg',
          ),
          Plant(
            name: "Lamb's Quarters",
            scientificName: 'Chenopodium album',
            imageUrl: 'assets/images/lambs_quarters.jpeg',
          ),
          Plant(
            name: 'Chickweed',
            scientificName: 'Stellaria media',
            imageUrl: 'assets/images/chickweed.jpeg',
          ),
          Plant(
            name: 'Creeping Charlie',
            scientificName: 'Glechoma hederacea',
            imageUrl: 'assets/images/creeping_charlie.jpeg',
          ),
          Plant(
            name: 'Nutsedge',
            scientificName: 'Cyperus esculentus',
            imageUrl: 'assets/images/nutsedge.jpeg',
          ),
          Plant(
            name: 'Purslane',
            scientificName: 'Portulaca oleracea',
            imageUrl: 'assets/images/purslane.jpeg',
          ),
        ];

      case 'shrubs':
        return const [
          Plant(
            name: 'Boxwood',
            scientificName: 'Buxus sempervirens',
            imageUrl: 'assets/images/boxwood.jpeg',
          ),
          Plant(
            name: 'Hydrangea',
            scientificName: 'Hydrangea macrophylla',
            imageUrl: 'assets/images/hydrangea.jpeg',
          ),
          Plant(
            name: 'Azalea',
            scientificName: 'Rhododendron spp.',
            imageUrl: 'assets/images/azalea.jpeg',
          ),
          Plant(
            name: 'Forsythia',
            scientificName: 'Forsythia x intermedia',
            imageUrl: 'assets/images/forsythia.jpeg',
          ),
          Plant(
            name: 'Lilac',
            scientificName: 'Syringa vulgaris',
            imageUrl: 'assets/images/lilac.jpeg',
          ),
          Plant(
            name: 'Spirea',
            scientificName: 'Spiraea japonica',
            imageUrl: 'assets/images/spirea.jpeg',
          ),
          Plant(
            name: 'Butterfly Bush',
            scientificName: 'Buddleja davidii',
            imageUrl: 'assets/images/butterfly_bush.jpeg',
          ),
          Plant(
            name: 'Weigela',
            scientificName: 'Weigela florida',
            imageUrl: 'assets/images/weigela.jpeg',
          ),
          Plant(
            name: 'Hibiscus Shrub',
            scientificName: 'Hibiscus syriacus',
            imageUrl: 'assets/images/hibiscus_shrub.jpeg',
          ),
          Plant(
            name: 'Rose of Sharon',
            scientificName: 'Hibiscus syriacus',
            imageUrl: 'assets/images/rose_of_sharon.jpeg',
          ),
        ];

      case 'fruits':
        return const [
          Plant(
            name: 'Apple',
            scientificName: 'Malus domestica',
            imageUrl: 'assets/images/apple.jpeg',
          ),
          Plant(
            name: 'Banana',
            scientificName: 'Musa spp.',
            imageUrl: 'assets/images/banana.jpeg',
          ),
          Plant(
            name: 'Orange',
            scientificName: 'Citrus × sinensis',
            imageUrl: 'assets/images/orange.jpeg',
          ),
          Plant(
            name: 'Strawberry',
            scientificName: 'Fragaria × ananassa',
            imageUrl: 'assets/images/strawberry.jpeg',
          ),
          Plant(
            name: 'Mango',
            scientificName: 'Mangifera indica',
            imageUrl: 'assets/images/mango.jpeg',
          ),
          Plant(
            name: 'Pineapple',
            scientificName: 'Ananas comosus',
            imageUrl: 'assets/images/pineapple.jpeg',
          ),
          Plant(
            name: 'Grapes',
            scientificName: 'Vitis vinifera',
            imageUrl: 'assets/images/grapes.jpeg',
          ),
          Plant(
            name: 'Peach',
            scientificName: 'Prunus persica',
            imageUrl: 'assets/images/peach.jpeg',
          ),
          Plant(
            name: 'Lemon',
            scientificName: 'Citrus limon',
            imageUrl: 'assets/images/lemon.jpeg',
          ),
          Plant(
            name: 'Papaya',
            scientificName: 'Carica papaya',
            imageUrl: 'assets/images/papaya.jpeg',
          ),
        ];

      case 'vegetables':
        return const [
          Plant(
            name: 'Tomato',
            scientificName: 'Solanum lycopersicum',
            imageUrl: 'assets/images/tomato.jpeg',
          ),
          Plant(
            name: 'Carrot',
            scientificName: 'Daucus carota',
            imageUrl: 'assets/images/carrot.jpeg',
          ),
          Plant(
            name: 'Potato',
            scientificName: 'Solanum tuberosum',
            imageUrl: 'assets/images/potato.jpeg',
          ),
          Plant(
            name: 'Lettuce',
            scientificName: 'Lactuca sativa',
            imageUrl: 'assets/images/lettuce.jpeg',
          ),
          Plant(
            name: 'Broccoli',
            scientificName: 'Brassica oleracea var. italica',
            imageUrl: 'assets/images/broccoli.jpeg',
          ),
          Plant(
            name: 'Spinach',
            scientificName: 'Spinacia oleracea',
            imageUrl: 'assets/images/spinach.jpeg',
          ),
          Plant(
            name: 'Cabbage',
            scientificName: 'Brassica oleracea var. capitata',
            imageUrl: 'assets/images/cabbage.jpeg',
          ),
          Plant(
            name: 'Onion',
            scientificName: 'Allium cepa',
            imageUrl: 'assets/images/onion.jpeg',
          ),
          Plant(
            name: 'Garlic',
            scientificName: 'Allium sativum',
            imageUrl: 'assets/images/garlic.jpeg',
          ),
          Plant(
            name: 'Pepper',
            scientificName: 'Capsicum annuum',
            imageUrl: 'assets/images/pepper.jpeg',
          ),
        ];

      case 'herbs':
        return const [
          Plant(
            name: 'Basil',
            scientificName: 'Ocimum basilicum',
            imageUrl: 'assets/images/basil.jpeg',
          ),
          Plant(
            name: 'Parsley',
            scientificName: 'Petroselinum crispum',
            imageUrl: 'assets/images/parsley.jpeg',
          ),
          Plant(
            name: 'Mint',
            scientificName: 'Mentha spp.',
            imageUrl: 'assets/images/mint.jpeg',
          ),
          Plant(
            name: 'Thyme',
            scientificName: 'Thymus vulgaris',
            imageUrl: 'assets/images/thyme.jpeg',
          ),
          Plant(
            name: 'Rosemary',
            scientificName: 'Salvia rosmarinus',
            imageUrl: 'assets/images/rosemary.jpeg',
          ),
          Plant(
            name: 'Cilantro',
            scientificName: 'Coriandrum sativum',
            imageUrl: 'assets/images/cilantro.jpeg',
          ),
          Plant(
            name: 'Oregano',
            scientificName: 'Origanum vulgare',
            imageUrl: 'assets/images/oregano.jpeg',
          ),
          Plant(
            name: 'Chives',
            scientificName: 'Allium schoenoprasum',
            imageUrl: 'assets/images/chives.jpeg',
          ),
          Plant(
            name: 'Dill',
            scientificName: 'Anethum graveolens',
            imageUrl: 'assets/images/dill.jpeg',
          ),
          Plant(
            name: 'Sage',
            scientificName: 'Salvia officinalis',
            imageUrl: 'assets/images/sage.jpeg',
          ),
        ];

      case 'mushrooms':
        return const [
          Plant(
            name: 'Button Mushroom',
            scientificName: 'Agaricus bisporus',
            imageUrl: 'assets/images/button_mushroom.jpeg',
          ),
          Plant(
            name: 'Shiitake',
            scientificName: 'Lentinula edodes',
            imageUrl: 'assets/images/shiitake.jpeg',
          ),
          Plant(
            name: 'Oyster Mushroom',
            scientificName: 'Pleurotus ostreatus',
            imageUrl: 'assets/images/oyster_mushroom.jpeg',
          ),
          Plant(
            name: 'Portobello',
            scientificName: 'Agaricus bisporus',
            imageUrl: 'assets/images/portobello.jpeg',
          ),
          Plant(
            name: 'Enoki',
            scientificName: 'Flammulina velutipes',
            imageUrl: 'assets/images/enoki.jpeg',
          ),
          Plant(
            name: 'Chanterelle',
            scientificName: 'Cantharellus cibarius',
            imageUrl: 'assets/images/chanterelle.jpeg',
          ),
          Plant(
            name: 'Morel',
            scientificName: 'Morchella esculenta',
            imageUrl: 'assets/images/morel.jpeg',
          ),
          Plant(
            name: 'King Oyster',
            scientificName: 'Pleurotus eryngii',
            imageUrl: 'assets/images/king_oyster.jpeg',
          ),
          Plant(
            name: 'Turkey Tail',
            scientificName: 'Trametes versicolor',
            imageUrl: 'assets/images/turkey_tail.jpeg',
          ),
          Plant(
            name: "Lion's Mane",
            scientificName: 'Hericium erinaceus',
            imageUrl: 'assets/images/lions_mane.jpeg',
          ),
        ];

      case 'toxic':
        return const [
          Plant(
            name: 'Oleander',
            scientificName: 'Nerium oleander',
            imageUrl: 'assets/images/oleander.jpeg',
          ),
          Plant(
            name: 'Foxglove',
            scientificName: 'Digitalis purpurea',
            imageUrl: 'assets/images/foxglove.jpeg',
          ),
          Plant(
            name: 'Castor Bean',
            scientificName: 'Ricinus communis',
            imageUrl: 'assets/images/castor_bean.jpeg',
          ),
          Plant(
            name: 'Lily of the Valley',
            scientificName: 'Convallaria majalis',
            imageUrl: 'assets/images/lily_of_the_valley.jpeg',
          ),
          Plant(
            name: 'Dumb Cane',
            scientificName: 'Dieffenbachia spp.',
            imageUrl: 'assets/images/dumb_cane.jpeg',
          ),
          Plant(
            name: 'Nightshade',
            scientificName: 'Atropa belladonna',
            imageUrl: 'assets/images/nightshade.jpeg',
          ),
          Plant(
            name: 'Hemlock',
            scientificName: 'Conium maculatum',
            imageUrl: 'assets/images/hemlock.jpeg',
          ),
          Plant(
            name: "Angel's Trumpet",
            scientificName: 'Brugmansia spp.',
            imageUrl: 'assets/images/angels_trumpet.jpeg',
          ),
          Plant(
            name: 'Yew',
            scientificName: 'Taxus baccata',
            imageUrl: 'assets/images/yew.jpeg',
          ),
          Plant(
            name: 'Autumn Crocus',
            scientificName: 'Colchicum autumnale',
            imageUrl: 'assets/images/autumn_crocus.jpeg',
          ),
        ];

      default:
        return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryId = ModalRoute.of(context)?.settings.arguments as String?;

    if (categoryId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Catégorie')),
        body: const Center(child: Text('Aucune catégorie sélectionnée.')),
      );
    }

    final plants = getPlantsByCategory(categoryId);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Catégorie : $categoryId',
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child:
            plants.isEmpty
                ? const Center(child: Text("Aucune plante trouvée."))
                : ListView.separated(
                  itemCount: plants.length,
                  separatorBuilder:
                      (context, index) => const Divider(
                        color: Color(0xFFE5E5E5),
                        thickness: 1,
                        height: 32,
                      ),
                  itemBuilder: (context, index) {
                    final plant = plants[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            plant.imageUrl,
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      plant.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                plant.scientificName,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                categoryId,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF00A67E),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
      ),
    );
  }
}
