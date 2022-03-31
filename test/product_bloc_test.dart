import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_flutter/bloc/product_bloc.dart';
import 'package:hello_flutter/bloc/product_event.dart';
import 'package:hello_flutter/bloc/product_state.dart';
import 'package:hello_flutter/model/product.dart';

void main() {
  group("Product Bloc Tezt", () {

    test("Initial Value", () {
      final bloc = ProductBloc();
      expect(bloc.state, equals(ProductInitial()));
    });

    blocTest(
      "Add Product", 
      build: () => ProductBloc(),
      act: (Bloc bloc) => bloc.add(const AddProduct(Product("Apel", 2000))),
      expect: () => const [ProductLoaded([Product("Apel", 2000)])]
    );

    blocTest(
      "Add and Remove Product", 
      build: () => ProductBloc(),
      act: (Bloc bloc) => {
        bloc.add(const AddProduct(Product("Apel", 2000))),
        bloc.add(const AddProduct(Product("Durian", 5000))),
        bloc.add(const RemoveProduct(Product("Apel", 2000))),
        bloc.add(const RemoveProduct(Product("Durian", 5000))),
      },
      expect: () => const [
        ProductLoaded([Product("Apel", 2000)]),
        ProductLoaded([Product("Apel", 2000), Product("Durian", 5000)]),
        ProductLoaded([Product("Durian", 5000)]),
        ProductLoaded([])
      ]
    );

  });
}