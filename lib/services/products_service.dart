import 'package:firebase_auth/firebase_auth.dart';
import 'package:frigider_virtual/services/users_service.dart';

class ProductsService {

  late String userId;

  ProductsService() {
    getUserId();
  }

  Future getUserId() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return -1;
    }
    var userEmail = currentUser.email;
    if (userEmail == null) {
      return -1;
    }

    userId = await UsersService.getUserId(userEmail);
  }
}