import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'material_stock_event.dart';
part 'material_stock_state.dart';

class MaterialStockBloc extends Bloc<MaterialStockEvent, MaterialStockState> {
  MaterialStockBloc() : super(MaterialStockInitial()) {
    on<MaterialStockEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
