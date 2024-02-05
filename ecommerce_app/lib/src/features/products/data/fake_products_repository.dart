import '../../../constants/test_products.dart';
import '../domain/product.dart';

class FakeProductsRepository {
  FakeProductsRepository._();
  static FakeProductsRepository instance = FakeProductsRepository._();
  final List<Product> _products = kTestProducts;
  List<Product> getProductList() {
    return _products;
  }

  Product? getProduct(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Product>> fetchProductList() {
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductList() {
    return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }
}
