import 'package:currency_converter/src/core/error/failures.dart';
import 'package:currency_converter/src/features/home/domain/usecases/get_converted_data.dart';
import 'package:currency_converter/src/utils/consts.dart';
//import 'package:currency_converter/src/utils/consts.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entites/currency_converter_entity.dart';
import 'currency_converter_state.dart';

class CurrencyConverterCubit extends Cubit<CurrencyConverterState> {
  final GetConvertedData getConvertedData;
  CurrencyConverterCubit({required this.getConvertedData})
      : super(CurrencyConverterInitial());

  TextEditingController amountController = TextEditingController();
  String from = 'Select', to = 'Select';

  onChangeValue(bool from, {required String? value}) {
    emit(CurrencyConverterInitial());

    if (value != null && value.isNotEmpty) {
      if (from) {
        this.from = value;
        return emit(FromStateChanges());
      }
      to = value;
      return emit(ToStateChanges());
    }
  }

  static bool _generalNumberEmptyValidatorWithNoSpecialChar(String orgText) {
    String pattern = r"^[0-9]+$";
    RegExp regExp = RegExp(pattern);

    if (orgText.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(orgText)) {
      return false;
    } else if (num.parse(orgText) <= 0) {
      return false;
    }

    return true;
  }

Future<dynamic> getConvertedDataFunc(
      {required String to,
      required String from,
      required String amount}) async {
    bool amountValidation =
        _generalNumberEmptyValidatorWithNoSpecialChar(amount);
    if (from == 'Select' ||
        to == 'Select' ||
        amount.isEmpty ||
        !amountValidation ||
        from == to) {
      return Constants.errorMessage(description: 'Please validate your inputs');
    }
    emit(LoadingState());
    final Either<Failure, CurrencyConverterEntity> convertedData =
        await getConvertedData(amount: amount, to: to, from: from);
    return emit(_getFailureOrConvertedData(convertedData));
  }

  CurrencyConverterState _getFailureOrConvertedData(
      Either<Failure, CurrencyConverterEntity> either) {
    return either.fold(
      (failure) {
        return ErrorState(message: _showFailureMessages(failure));
      },
      (currencyEntity) {
        amountController.clear();
        return LoadedState(
          currencyEntity: currencyEntity,
        );
      },
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
