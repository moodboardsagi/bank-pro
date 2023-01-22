import 'package:bank_pro/models/transaction_model.dart';
import 'package:bank_pro/services/transaction_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionEvent>((event, emit) async {
      if (event is TransactionGet) {
        try {
          emit(TransactionLoading());
          final transactions = await TransactionService().getTransactions();
          emit(TransactionSuccess(transactions));
        } catch (e) {
          emit(
            TransactionFailed(
              e.toString(),
            ),
          );
        }
      }
    });
  }
}
