import 'dart:io';
import 'dart:async';
import 'package:analog_clock/models/auth_service.dart';
import 'package:analog_clock/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';

class home_screen_drawer extends StatefulWidget {
  const home_screen_drawer({
    Key? key,
  }) : super(key: key);

  @override
  State<home_screen_drawer> createState() => _home_screen_drawerState();
}

class _home_screen_drawerState extends State<home_screen_drawer> with AutomaticKeepAliveClientMixin {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryIconTheme.color!,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  /*AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            // posiçao da sombra
                            color: kShadowColor.withOpacity(0.14),
                            //cor da sombra
                            blurRadius: 70, //raio da sombra
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage('assets/images/perfil.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),*/
                  GestureDetector(
                    onTap: () {
                      buildShowModalBottomSheet(context);
                    },
                    child: CircleAvatar(
                      radius: 130,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : AssetImage('assets/images/profilenull.jpg')
                              as ImageProvider,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle),
                      SizedBox(width: 5,),
                      Text('Lucas Theisen'),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone_android),
                      SizedBox(width: 5,),
                      Text('(45) 988281176'),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email),
                      SizedBox(width: 5,),
                      Text('lucasevandro11@hotmail.com'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text("Sair"),
                  subtitle: Text("Deslogar"),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                  ),
                  onTap: (){
                     context.read<AuthService>()..sair();
                  },
                ),
              ],
            ),
          ),
          Container(
            height: getProportionateScreenHeight(50),
            child: Text(
              "Versao 1.0",
            ),
          ),
        ],
      ),
    );
  }

  buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        //ModalBottomSheet é o menu que sobe de baixo para cima
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                //Um widget que exibe seus filhos em várias execuções horizontais ou verticais.
                children: [
                  new ListTile(
                      leading: new Icon(
                        Icons.photo_library,
                        color: Colors.blue,
                      ),
                      title: new Text('Galeria'),
                      onTap: () {
                        pegarImageGaleria();
                        Navigator.of(context).pop(); //fecha o ModalBottomSheet
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: Colors.blue,
                    ),
                    title: new Text('Camera'),
                    onTap: () {
                      pegarImageCamera();
                      Navigator.of(context).pop(); //fecha o ModalBottomSheet
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void pegarImageCamera() async {
    File? _imagePicker =
        await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = _imagePicker;
    });
  }

  Future<void> pegarImageGaleria() async {
    File? _imagePicker =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = _imagePicker;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
