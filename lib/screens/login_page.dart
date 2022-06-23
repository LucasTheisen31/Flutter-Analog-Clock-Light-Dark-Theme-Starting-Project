import 'package:analog_clock/models/auth_service.dart';
import 'package:analog_clock/models/my_theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController(); //controler do email
  final _senha = TextEditingController(); //controler da senha

  bool _isLogin =
      true; //variavel para cerificar se a tela é de login ou de registro
  bool _loading = false; //variavel para exibir ou nao o circularProgressBar
  bool _passwordVisible = true;
  late String _titulo; //titulo da pagina
  late String _actionButton; //nome do botao de login ou regestrar
  late String _toggleButton; //texto do botao de alternancia entra as telas

  @override
  void initState() {
    setFormAction(
        true); //metodo para alternar entre page de login e de cadastro, inicia na pagina de login
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setFormAction(bool acao) {
    setState(() {
      _isLogin = acao;
      if (_isLogin) {
        _titulo = 'Bem Vindo'; //titulo da pagina
        _actionButton = 'Login'; //texto do botao de login || cadastro
        _toggleButton =
            'Ainda não tem conta? Cadastre-se agora.'; //texto do botao de alternar as telas
      } else {
        _titulo = 'Crie sua conta'; //titulo da pagina
        _actionButton = 'Cadastrar'; //texto do botao de login || cadastro
        _toggleButton =
            'Voltar ao Login.'; //texto do botao de alternar as telas
      }
    });
  }

  login() async {
    setState(() => _loading = true);
    try {
      await context.read<AuthService>().login(_email.text, _senha.text);
    } on AuthException catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.menssagem)));
    }
  }

  registrar() async {
    setState(() => _loading = true);
    try {
      await context.read<AuthService>().registrar(_email.text, _senha.text);
    } on AuthException catch (e) {
      //AuthException é a execao personalizada que foi criada
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.menssagem),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Consumer<MyThemeModel>(
              builder: (context, theme, child) => GestureDetector(
                onTap: () => theme.changeTheme(), //muda o tema
                child: SvgPicture.asset(
                  theme.isLightTheme
                      ? 'assets/icons/Sun.svg'
                      : 'assets/icons/Moon.svg',
                  height: 24,
                  width: 24,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).backgroundColor,
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          _titulo,
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/profilenull.jpg'),
                          radius: 130,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          //widget de entrada de texto
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          cursorColor: Theme.of(context).hintColor,
                          decoration: InputDecoration(
                            label: Text(
                              'Email',
                              style:
                                  TextStyle(color: Theme.of(context).hintColor),
                            ),
                            prefixIcon: Icon(Icons.perso,
                                color: Theme.of(context).hintColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).hintColor,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o email corretamente!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          //widget de entrada de texto
                          controller: _senha,
                          obscureText: _passwordVisible,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          cursorColor: Theme.of(context).hintColor,
                          decoration: InputDecoration(
                            label: Text(
                              'Senha',
                              style:
                                  TextStyle(color: Theme.of(context).hintColor),
                            ),
                            prefixIcon: Icon(
                              Icons.lock_rounded,
                              color: Theme.of(context).hintColor,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).hintColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).hintColor),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe a senha!';
                            } else if (value.length < 6) {
                              return 'Senha deve ter no minimo 6 caracteres';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: (_loading)
                                  ? [
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    ]
                                  : [
                                      Icon(Icons.check),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(_actionButton),
                                      ),
                                    ],
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_isLogin) {
                                  login(); //chama o metodo de login
                                } else {
                                  registrar(); //chama o metodo de registrar
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              elevation: 0,
                            ),
                            onPressed: () => setFormAction(!_isLogin),
                            child: Text(
                              _toggleButton,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text('Versao 1.0'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
