import '../resources/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();

  static SharedPreferences _pref;

  static Future getInstance() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future setUser(User user) async {
    await _pref.setString('pref_user', user.toRawJson());
  }

  static Future updatedUser(UserDatum user) async {
    final newUser = getUser().copyWith(
      user: getUser().user.copyWith(
            name: user.name,
            gender: user.gender,
            avatar: user.avatar,
          ),
    );
    await _pref.setString('pref_user', newUser.toRawJson());
  }

  static User getUser() {
    final user = _pref.getString('pref_user');
    if (user == null) {
      return null;
    }
    return User.fromRawJson(user);
  }

  static bool isVerifyEmail() {
    if (getUser() == null) return false;
    return getUser().user.emailVerifiedAt != null;
  }

  static Future setToken(String token) async {
    final newUser = getUser()..copyWith(accessToken: token);
    await setUser(newUser);
  }

  static String getToken() {
    return getUser().accessToken;
  }

  /// cart
  static Future addCart(Cart cart) async {
    final currentCarts = getCarts();

    if (currentCarts.isNotEmpty) {
      final findCart = currentCarts.firstWhere(
          (element) => element.product.id == cart.product.id,
          orElse: () => null);
      findCart != null ? findCart.quantity += 1 : currentCarts.add(cart);
    } else {
      currentCarts.add(cart);
    }

    await _pref.setStringList(
      'pref_carts',
      currentCarts.map((e) => e.toRawJson()).toList(),
    );
  }

  static List<Cart> getCarts() {
    final carts = <Cart>[];
    final cartsPref = _pref.getStringList('pref_carts');
    if (cartsPref != null) {
      for (final item in cartsPref) {
        carts.add(Cart.fromRawJson(item));
      }
    }
    return carts;
  }

  static Future decreaseCart(Cart cart) async {
    final currentCarts = getCarts();
    final findCart = currentCarts
        .firstWhere((element) => element.product.id == cart.product.id);

    if (findCart.quantity > 1) {
      findCart.quantity -= 1;
    }

    await _pref.setStringList(
      'pref_carts',
      currentCarts.map((e) => e.toRawJson()).toList(),
    );
  }

  static Future increaseCart(Cart cart) async {
    final currentCarts = getCarts();
    currentCarts
        .firstWhere((element) => element.product.id == cart.product.id)
        .quantity += 1;

    await _pref.setStringList(
      'pref_carts',
      currentCarts.map((e) => e.toRawJson()).toList(),
    );
  }

  static Future removeCart(Cart cart) async {
    final currentCarts = getCarts()
      ..removeWhere((element) => element.product.id == cart.product.id);

    await _pref.setStringList(
      'pref_carts',
      currentCarts.map((e) => e.toRawJson()).toList(),
    );
  }

  static Future removeCarts() async {
    await _pref.remove('pref_carts');
  }

  static Future clear() async {
    await _pref.clear();
  }
}
