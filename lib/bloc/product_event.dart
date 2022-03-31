import 'package:equatable/equatable.dart';
import 'package:hello_flutter/model/product.dart';

abstract class ProductEvent extends Equatable {
  final Product product;
  
  const ProductEvent(this.product);
}

class AddProduct extends ProductEvent {

  const AddProduct(Product product) : super(product);

  @override
  List<Object?> get props => [product];
  
}

class RemoveProduct extends ProductEvent {

  const RemoveProduct(Product product) : super(product);

  @override
  List<Object?> get props => [product];
  
}

