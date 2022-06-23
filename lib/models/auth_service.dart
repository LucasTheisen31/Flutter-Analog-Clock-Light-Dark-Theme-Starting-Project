
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthException implements Exception{
  //atributos
  String menssagem;

  AuthException(this.menssagem);//construtor

}

class AuthService extends ChangeNotifier{
  //atributos
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService(){
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null)? null : user;//se o usuario retornado pelo firebase for nulo, usuario recebe nulo, senao recebe o eusuario retornado pelo firebase
      isLoading = false;
      notifyListeners();//Chame esse método sempre que o objeto for alterado, para notificar qualquer cliente que o objeto pode ter sido alterado
    });
  }

  _getUser() {
    usuario = _auth.currentUser;//pega usuario logado atualmente
    notifyListeners();//notifica os listeners, notifica as paginas e serviços que estiverem utilizando o serviço de autenticação
  }

  registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      }
      else if (e.code == 'invalid-email') {
        throw AuthException('Email invalido!');
      } else{
        throw AuthException(e.code);
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }else if (e.code == 'invalid-email'){
        throw AuthException('Email invalido!');
      }else{
        throw AuthException(e.code);
      }

    }
  }

  sair() async{
    _auth.signOut();
    _getUser();//atualiza o usuario com um usuario nulo
  }

}