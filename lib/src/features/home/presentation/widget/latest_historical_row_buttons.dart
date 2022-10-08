import 'package:currency_converter/src/features/home/presentation/bloc/currency/currency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/consts.dart';
import '../bloc/currency/currency_state.dart';

class LatestHistoricalRowButtons extends StatelessWidget {
   final CurrencyCubit bloc;
  const LatestHistoricalRowButtons({super.key,required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrencyCubit, CurrencyState>(
      listener: (context, state) {
        debugPrint("stateFromRow $state");
      },
      bloc: bloc,
      buildWhen: (previous, current) =>
          current is CurrencyInitial ||
          current is LatestSelected ||
          current is HistoricalSelected,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                bloc.changeSelection(LatestSelected());
              },
              child: Container(
                width: 154,
                height: 48,
                decoration: state is LatestSelected
                    ? Constants.selectedDecoration
                    :  Constants.unselectedBoxDecoration,
                child: Center(
                    child: Text(
                  "Latest",
                  textAlign: TextAlign.center,
                  style: state is LatestSelected
                      ?  Constants.selectedTextStyle(true)
                      :  Constants.selectedTextStyle(false),
                )),
              ),
            ),
            GestureDetector(
              onTap: () {
                bloc.changeSelection(HistoricalSelected());
              },
              child: Container(
                width: 163,
                height: 48,
                decoration: state is HistoricalSelected
                    ? Constants.selectedDecoration
                    : Constants.unselectedBoxDecoration,
                child: Center(
                    child: Text(
                  "Historical",
                  textAlign: TextAlign.center,
                  style: state is HistoricalSelected
                      ? Constants.selectedTextStyle(true)
                      : Constants.selectedTextStyle(false),
                )),
              ),
            )
          ],
        );
      },
    );
  }
}