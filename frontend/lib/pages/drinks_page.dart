import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/pages/info_page.dart';
import '../components/drink_item.dart';
import '../models/drink.dart';
import '../pages/new_drink_page.dart';

class DrinksPage extends StatelessWidget {
  const DrinksPage({super.key,
    required this.drinks,
    required this.addNewDrink,
    required this.toggleFavorite,
    required this.removeDrink,
  });

  final List<Drink> drinks;
  final Function addNewDrink;
  final Function toggleFavorite;
  final Function removeDrink;

  void _navigateToNewDrinkPage(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewDrinkPage()));

    if (result != null) {
      addNewDrink(result);
    }
  }

  void _navigateToInfoPage(BuildContext context, int index) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InfoPage(
              drinkID: drinks[index].id,
              isDeletable: true,
            )));

    if (result == true) {
      removeDrink(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Напитки",
                style: GoogleFonts.sourceSerif4(
                    textStyle: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(255, 238, 205, 1.0),
                )))),
        backgroundColor: const Color.fromRGBO(71, 58, 42, 1.0),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color.fromRGBO(71, 58, 42, 1.0),
        child: drinks.isNotEmpty
            ? GridView.count(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                children: List.generate(drinks.length, (index) {
                  return GestureDetector(
                    onTap: () => _navigateToInfoPage(context, index),
                    child: DrinkItem(drink: drinks[index], onFavoriteToggle: () => toggleFavorite(index),),
                  );
                }),
              )
            : Center(
                child: Text(
                  'Пока что здесь пусто...',
                  style: GoogleFonts.sourceSerif4(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(255, 238, 205, 1.0),
                      )),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToNewDrinkPage(context),
        backgroundColor: const Color.fromRGBO(44, 32, 17, 1.0),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Color.fromRGBO(233, 183, 123, 1)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
