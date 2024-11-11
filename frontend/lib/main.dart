import 'package:flutter/material.dart';
import 'package:frontend/api_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/models/cart_item.dart';
import 'package:frontend/pages/cart_page.dart';
import 'package:frontend/pages/drinks_page.dart';
import 'pages/profile_page.dart';
import '../data.dart';
import 'pages/favorites_page.dart';
import '../models/drink.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ПР10 ПКС',
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(44, 32, 17, 1.0),
          selectedItemColor: Color.fromRGBO(181, 139, 80, 1.0),
          unselectedItemColor: Color.fromRGBO(255, 238, 205, 1.0),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Drink>> _drinksFuture;

  @override
  void initState(){
    super.initState();
    _drinksFuture = ApiService().getDrinks(1);
  }

  int _selectedPage = 0;

  late Map<String, String> _profile = {
    'name': "Мрясова Анастасия",
    'profile_picture': 'https://github.com/loloneme/images/blob/main/182a9bb9f5b32babe6efc8c7bf4305be.jpg?raw=true',
    'email': '1fukkacumi2@mail.ru',
    'phone': '89991111337'
  };

  // late List<CartItem> _cart = [
  //   CartItem(9, 'Милкшейк',
  //       'https://github.com/loloneme/images/blob/main/milkshake.png?raw=true',
  //       true,
  //       2,
  //       260,
  //       '350'),
  //   CartItem(3, 'Бамбл',
  //       'https://github.com/loloneme/images/blob/main/bumble.png?raw=true',
  //       true,
  //       2,
  //       300,
  //       '350')
  // ];



  void _addNewDrink(Drink drink) async {
    try {
      final id = await ApiService().createDrink(drink);
      setState(() {
        _drinksFuture = ApiService().getDrinks(1);
      });
    } catch (e) {
      print('Ошибка: $e');
    }
  }

  void _updateProfile(newProfile){
    setState(() {
      _profile = newProfile;
    });
  }

  void _removeDrink(index) async {
    try {
      List<Drink> drinks = await _drinksFuture;

      final id = drinks[index].id;
      await ApiService().deleteDrink(id);

      setState(() {
        _drinksFuture = ApiService().getDrinks(1);
      });
    } catch (e) {
      print('Ошибка: $e');
    }
  }

  void _toggleFavorite(index) async {
    try {
      List<Drink> drinks = await _drinksFuture;

      await ApiService().toggleFavorite(drinks[index].id, 1);

      setState(() {
        _drinksFuture = ApiService().getDrinks(1);
      });
    } catch (e) {
      print('Ошибка: $e');
    }

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  // void _removeFromCart(int index){
  //   setState(() {
  //     _cart.removeAt(index);
  //   });
  // }
  //
  // void _decrementAmount(int index){
  //   if (_cart[index].amount <= 1){
  //     _removeFromCart(index);
  //   } else {
  //     setState(() {
  //       _cart[index].amount -= 1;
  //     });
  //   }
  // }
  //
  // void _incrementAmount(int index){
  //   setState(() {
  //     _cart[index].amount += 1;
  //   });
  // }
  //
  // void _addToCart(CartItem item){
  //   int index = _cart.indexWhere((el) => el.name == item.name && el.isCold == item.isCold && el.volume == item.volume);
  //   if (index == -1){
  //     setState(() {
  //       _cart.add(item);
  //     });
  //   } else {
  //     setState((){
  //       _cart[index].amount += item.amount;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Drink>>(
        future: _drinksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет доступных напитков'));
          } else {
            final drinks = snapshot.data!;

            List<Widget> pageOptions = <Widget>[
              DrinksPage(
                drinks: drinks,
                addNewDrink: _addNewDrink,
                toggleFavorite: _toggleFavorite,
                removeDrink: _removeDrink,
              ),
              FavoritesPage(
                drinks: drinks,
                addNewDrink: _addNewDrink,
                toggleFavorite: _toggleFavorite,
              ),
              const CartPage(),
              ProfilePage(
                profile: _profile,
                updateProfile: _updateProfile,
              )
            ];


            return pageOptions.elementAt(_selectedPage);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.coffee_rounded),
              label: "Напитки"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded),
              label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedPage,
        selectedItemColor: const Color.fromRGBO(181, 139, 80, 1.0),
        unselectedItemColor: const Color.fromRGBO(255, 238, 205, 1.0),
        backgroundColor: const Color.fromRGBO(44, 32, 17, 1.0),
        selectedLabelStyle:
            GoogleFonts.sourceSerif4(textStyle: const TextStyle()),
        unselectedLabelStyle:
            GoogleFonts.sourceSerif4(textStyle: const TextStyle()),
        onTap: _onItemTapped,
      ),
    );
  }
}
