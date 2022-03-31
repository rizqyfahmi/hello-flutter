import 'package:bloc/bloc.dart';
import 'package:hello_flutter/bloc/product_event.dart';
import 'package:hello_flutter/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<AddProduct>((event, emit) {
      if (state is ProductInitial) {
        return emit(ProductLoaded([event.product]));
      }

      emit(ProductLoaded([...(state as ProductLoaded).products, event.product]));
    });
    on<RemoveProduct>((event, emit) {
      if (state is ProductInitial) {
        return emit(state);
      }

      emit(
        ProductLoaded(
          (state as ProductLoaded).products.where((item) => item != event.product).toList()
        )
      );
    });
  }
}