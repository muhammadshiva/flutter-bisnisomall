part of 'fetch_product_toko_saya_bloc.dart';

class FetchProductTokoSayaState extends Equatable {
  const FetchProductTokoSayaState();
  
  @override
  List<Object> get props => [];
}

class FetchProductTokoSayaInitial extends FetchProductTokoSayaState {}

class FetchProductTokoSayaLoading extends FetchProductTokoSayaState {}

class FetchProductTokoSayaSuccess extends FetchProductTokoSayaState {
  FetchProductTokoSayaSuccess({this.tokoSayaProduct,this.currentPage,this.lastPage});

  final List<TokoSayaProducts> tokoSayaProduct;
  final int currentPage,lastPage;

  @override
  List<Object> get props => [tokoSayaProduct,currentPage,lastPage];
}

class FetchProductTokoSayaFailure extends FetchProductTokoSayaState {
  final ErrorType type;
  final String message;

  FetchProductTokoSayaFailure({this.type = ErrorType.general, this.message});

  FetchProductTokoSayaFailure.network(String message)
      : this(type: ErrorType.network, message: message);

  FetchProductTokoSayaFailure.general(String message)
      : this(type: ErrorType.general, message: message);

  @override
  List<Object> get props => [type, message];
}

