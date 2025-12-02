import 'package:flutter/material.dart';
import '../../services/pokeapi_service.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final PokeApiService api = PokeApiService();

  List pokemons = [];
  dynamic searchedPokemon;
  bool isLoading = false;

  int offset = 0;
  int limit = 10;
  int? openIndex;
  String searchTerm = "";

  @override
  void initState() {
    super.initState();
    loadPokemons();
  }

  // --- Load paginated list
  void loadPokemons() async {
    setState(() => isLoading = true);

    pokemons = await api.getPokemonListPaginated(offset, limit);

    setState(() => isLoading = false);
  }

  // --- Search Pokémon
  void searchPokemon() async {
    if (searchTerm.trim().isEmpty) {
      setState(() => searchedPokemon = null);
      loadPokemons();
      return;
    }

    setState(() => isLoading = true);

    searchedPokemon = await api.getPokemonByName(searchTerm);

    setState(() => isLoading = false);
  }

  // --- Accordion toggle
  void toggleAccordion(int index) {
    setState(() {
      openIndex = (openIndex == index) ? null : index;
    });
  }

  // --- Pagination
  void nextPage() {
    offset += limit;
    loadPokemons();
    openIndex = null;
  }

  void prevPage() {
    if (offset > 0) {
      offset -= limit;
      loadPokemons();
      openIndex = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokédex")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // --- Search bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Buscar Pokémon por nombre o ID",
                    ),
                    onChanged: (v) => searchTerm = v,
                    onSubmitted: (_) => searchPokemon(),
                  ),
                ),
                ElevatedButton(
                  onPressed: searchPokemon,
                  child: const Text("Buscar"),
                )
              ],
            ),

            if (isLoading) const CircularProgressIndicator(),

            const SizedBox(height: 10),

            // --- Search result card
            if (searchedPokemon != null && !isLoading)
              Expanded(
                child: ListView(
                  children: [
                    _pokemonCard(searchedPokemon, 0),
                  ],
                ),
              ),

            // --- Grid Pokémon list
            if (searchedPokemon == null && !isLoading)
              Expanded(
                child: GridView.builder(
                  itemCount: pokemons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .9,
                  ),
                  itemBuilder: (context, i) {
                    return _pokemonCard(pokemons[i], i);
                  },
                ),
              ),

            // --- Pagination Buttons
            if (searchedPokemon == null && !isLoading)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: offset == 0 ? null : prevPage,
                    child: const Text("Anterior"),
                  ),
                  ElevatedButton(
                    onPressed: nextPage,
                    child: const Text("Siguiente"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // --- Pokémon Card with Accordion
  Widget _pokemonCard(dynamic p, int index) {
    return InkWell(
      onTap: () => toggleAccordion(index),
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Image.network(
              p["sprites"]["front_default"],
              width: 100,
              height: 100,
            ),
            Text(
              "${p["name"]}".toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            // Accordion
            if (openIndex == index)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Altura: ${p["height"]}"),
                    Text("Peso: ${p["weight"]}"),
                    Text("Tipo: ${p["types"][0]["type"]["name"]}"),
                    Text("Experiencia: ${p["base_experience"]}"),
                    Text("ID: ${p["id"]}"),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
