import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage(
      {super.key, required this.profile, required this.updateProfile});

  final Function updateProfile;
  final Map<String, String> profile;

  @override
  State<ProfilePage> createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<ProfilePage> {
  bool _isEditMode = false;
  String _uploadedImage = '';

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _avatarUrlController;

  void _turnOnTheEditMode() {
    setState(() {
      _isEditMode = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _uploadedImage = widget.profile['profile_picture'] ?? '';
    _nameController = TextEditingController(text: widget.profile['name']);
    _emailController = TextEditingController(text: widget.profile['email']);
    _phoneController = TextEditingController(text: widget.profile['phone']);
    _avatarUrlController = TextEditingController(text: widget.profile['profile_picture']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _avatarUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text("Профиль",
                  style: GoogleFonts.sourceSerif4(
                      textStyle: const TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(255, 238, 205, 1.0),
                  )))),
          backgroundColor: const Color.fromRGBO(71, 58, 42, 1.0),
        ),
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                color: const Color.fromRGBO(71, 58, 42, 1.0),
                child: Center(
                  child: _isEditMode
                      ? Column(children: [
                          const SizedBox(height: 40),
                          Container(
                            width: 200,
                            height: 200,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(_uploadedImage != ''
                                      ? _uploadedImage
                                      : 'https://github.com/loloneme/images/blob/main/c0749b7cc401421662ae901ec8f9f660%20(1).jpg?raw=true'),
                                  fit: BoxFit.cover
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(44, 32, 17, 1.0),
                                    width: 3)),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: 260,
                            child: TextFormField(
                              controller: _avatarUrlController,
                              keyboardType: TextInputType.url,
                              style: GoogleFonts.sourceSerif4(
                                  textStyle: const TextStyle(
                                      fontSize: 18.0,
                                      color: Color.fromRGBO(255, 238, 205, 1.0))),
                              decoration: InputDecoration(
                                  counterText: '',
                                  isDense: true,
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 32, 17, 1.0),
                                          width: 2.0)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 32, 17, 1.0),
                                          width: 2.0)),
                                  contentPadding: const EdgeInsets.all(5),
                                  labelText: "URL аватарки",
                                  labelStyle: GoogleFonts.sourceSerif4(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18.0,
                                          color: Color.fromRGBO(
                                              217, 217, 217, 1.0)))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Введите URL";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _uploadedImage = value;
                                });
                              }
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 260,
                            child: TextFormField(
                              controller: _nameController,
                              maxLength: 50,
                              style: GoogleFonts.sourceSerif4(
                                  textStyle: const TextStyle(
                                      fontSize: 18.0,
                                      color: Color.fromRGBO(255, 238, 205, 1.0))),
                              decoration: InputDecoration(
                                  counterText: '',
                                  isDense: true,
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 32, 17, 1.0),
                                          width: 2.0)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 32, 17, 1.0),
                                          width: 2.0)),
                                  contentPadding: const EdgeInsets.all(5),
                                  labelText: "Фамилия и имя",
                                  labelStyle: GoogleFonts.sourceSerif4(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18.0,
                                          color: Color.fromRGBO(
                                              217, 217, 217, 1.0)))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Введите Ваши Фамилию и имя!";
                                }
                                return null;
                              }
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 260,
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.sourceSerif4(
                                  textStyle: const TextStyle(
                                      fontSize: 18.0,
                                      color: Color.fromRGBO(255, 238, 205, 1.0))),
                              decoration: InputDecoration(
                                  counterText: '',
                                  isDense: true,
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 32, 17, 1.0),
                                          width: 2.0)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 32, 17, 1.0),
                                          width: 2.0)),
                                  contentPadding: const EdgeInsets.all(5),
                                  labelText: "Адрес эл. почты",
                                  labelStyle: GoogleFonts.sourceSerif4(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18.0,
                                          color: Color.fromRGBO(
                                              217, 217, 217, 1.0)))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Введите адрес Вашей эл. почты";
                                }
                                return null;
                              }
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 260,
                            child: TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              style: GoogleFonts.sourceSerif4(
                                  textStyle: const TextStyle(
                                      fontSize: 18.0,
                                      color: Color.fromRGBO(255, 238, 205, 1.0))),
                              decoration: InputDecoration(
                                  counterText: '',
                                  isDense: true,
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 32, 17, 1.0),
                                          width: 2.0)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(44, 32, 17, 1.0),
                                          width: 2.0)),
                                  contentPadding: const EdgeInsets.all(5),
                                  labelText: "Номер телефона",
                                  labelStyle: GoogleFonts.sourceSerif4(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18.0,
                                          color: Color.fromRGBO(
                                              217, 217, 217, 1.0)))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Введите Ваш номер телефона";
                                }
                                return null;
                              }
                            ),
                          ),
                          const SizedBox(height: 60),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(44, 32, 17, 1.0),
                            ),
                            onPressed: () {
                              setState(() {
                                widget.profile['name'] = _nameController.text;
                                widget.profile['email'] = _emailController.text;
                                widget.profile['phone'] = _phoneController.text;
                                widget.profile['profile_picture'] = _avatarUrlController.text;
                                _isEditMode = false;
                              });
                              widget.updateProfile(widget.profile);
                            },
                            child: Text('Сохранить',
                                style: GoogleFonts.sourceSerif4(
                                    textStyle: const TextStyle(
                                        fontSize: 18.0,
                                        color: Color.fromRGBO(
                                            255, 238, 205, 1.0)))),
                          ),
                        ])
                      : Column(children: [
                          const SizedBox(height: 40),
                          Container(
                            width: 200,
                            height: 200,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(widget
                                            .profile['profile_picture'] ??
                                        'https://github.com/loloneme/images/blob/main/c0749b7cc401421662ae901ec8f9f660%20(1).jpg?raw=true'),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(44, 32, 17, 1.0),
                                    width: 3)),
                          ),
                          const SizedBox(height: 30),
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            Text(widget.profile['name']!,
                                style: GoogleFonts.sourceSerif4(
                                    textStyle: const TextStyle(
                                  fontSize: 28.0,
                                  color: Color.fromRGBO(255, 238, 205, 1.0),
                                ))),
                            SizedBox(
                              width: 20,
                              child: IconButton(
                                onPressed: _turnOnTheEditMode,
                                icon: const Icon(Icons.edit),
                                color: const Color.fromRGBO(255, 238, 205, 1.0),
                                iconSize: 20,
                              ),
                            )
                          ]),
                          const SizedBox(height: 15),
                          Text(widget.profile['email']!,
                              style: GoogleFonts.sourceSerif4(
                                  textStyle: const TextStyle(
                                fontSize: 20.0,
                                color: Color.fromRGBO(255, 238, 205, 1.0),
                              ))),
                          const SizedBox(height: 15),
                          Text(widget.profile['phone']!,
                              style: GoogleFonts.sourceSerif4(
                                  textStyle: const TextStyle(
                                fontSize: 20.0,
                                color: Color.fromRGBO(255, 238, 205, 1.0),
                              )))
                        ]),
                ))));
  }
}
