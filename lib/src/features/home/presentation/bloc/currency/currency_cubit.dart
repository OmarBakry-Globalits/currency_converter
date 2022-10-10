import 'package:currency_converter/src/core/error/exceptions.dart';
import 'package:currency_converter/src/features/home/domain/entites/currency_historical_entity.dart';
import 'package:currency_converter/src/features/home/domain/usecases/get_historical_data.dart';
import 'package:currency_converter/src/features/home/domain/usecases/get_latest_data.dart';
//import 'package:currency_converter/src/utils/consts.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entites/currency_entity.dart';
import 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final GetLatestDataUseCase getLatestData;
  final GetHistoricalData getHistoricalData;
  CurrencyCubit({required this.getLatestData, required this.getHistoricalData})
      : super(CurrencyInitial()) {
    _initFunction();
  }

  bool historyCalled = false;

  _initFunction() async {
    emit(LoadingState());
    final Either<Failure, CurrencyEntity> data = await getLatestData();
    emit(LatestSelected());
    emit(_getFailureOrData(data));
  }

  Future getHistoricalDataFunc({bool? useCachedData}) async {
    emit(LoadingState());
    final Either<Failure, CurrencyHistoricalEntity> data =
        await getHistoricalData(useCachedData: useCachedData);
    return emit(_getFailureOrHistoricalData(data));
  }

  void changeSelection(CurrencyState state) async {
    emit(CurrencyInitial());
    if (state is HistoricalSelected) {
      if (historyCalled) {
        emit(HistoricalSelected());
        await getHistoricalDataFunc(useCachedData: true);
      } else {
        emit(HistoricalSelected());
        await getHistoricalDataFunc();
      }
      return;
    }
    emit(LatestSelected());
    final Either<Failure, CurrencyEntity> data =
        await getLatestData(useCachedData: true);
    emit(_getFailureOrData(data));
  }

  CurrencyState _getFailureOrHistoricalData(
      Either<Failure, CurrencyHistoricalEntity> either) {
    return either.fold(
      (failure) {
        historyCalled = false;
        return ErrorState(message: _showFailureMessages(failure));
      },
      (historicalData) {
        historyCalled = true;
        return LoadedHistoricalState(
          historicalEntity: historicalData,
        );
      },
    );
  }

  CurrencyState _getFailureOrData(Either<Failure, CurrencyEntity> either) {
    return either.fold(
      (failure) => ErrorState(message: _showFailureMessages(failure)),
      (currencyEntity) => LoadedCurrencyState(
        currencyEntity: currencyEntity,
      ),
    );
  }

  String _showFailureMessages(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ServerException().message;
      case EmptyCacheFailure:
        return EmptyCacheException().message;
      case OfflineFailure:
        return OfflineException().message;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
