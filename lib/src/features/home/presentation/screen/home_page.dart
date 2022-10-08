// import 'package:currency_converter/src/features/home/domain/entites/currency_entity.dart';
//import 'package:currency_converter/src/features/home/domain/entites/currency_historical_entity.dart';
import 'package:currency_converter/src/features/home/presentation/bloc/currency/currency_cubit.dart';
// import 'package:currency_converter/src/features/home/presentation/widget/currency_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currency/currency_state.dart';
import '../widget/historical_view.dart';
import '../widget/home_header.dart';
//import '../widget/home_item.dart';
import '../widget/latest_currency_view.dart';
import '../widget/latest_historical_row_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CurrencyCubit bloc = BlocProvider.of<CurrencyCubit>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            const HomeHeaderWidget(),
            const SizedBox(
              height: 25,
            ),
            LatestHistoricalRowButtons(
              bloc: bloc,
            ),
            const SizedBox(
              height: 25,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "Base currency rate to the others",
                  style: TextStyle(
                    color: Color(0xff212529),
                    fontSize: 20,
                    fontFamily: "Circular Std",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            BlocConsumer<CurrencyCubit, CurrencyState>(
              bloc: bloc,
              listener: (context, state) {
                debugPrint("State $state");
              },
              builder: (context, state) {
                return state is LoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is ErrorState
                        ? Center(
                            child: Text(state.message),
                          )
                        : state is LoadedCurrencyState
                            ? LatestCurrencyView(
                                currencyEntity: state.currencyEntity,
                              )
                            : state is LoadedHistoricalState
                                ? HistoricalView(
                                    historicalEntity: state.historicalEntity)
                                : const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
