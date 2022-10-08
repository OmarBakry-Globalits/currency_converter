import 'package:currency_converter/src/features/home/presentation/bloc/currency_converter/currency_converter_cubit.dart';
import 'package:currency_converter/src/utils/consts.dart';
import 'package:currency_converter/src/utils/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/currency_converter/currency_converter_state.dart';
// import '../widget/home_header.dart';
// import '../widget/latest_historical_row_buttons.dart';

class ConverterPage extends StatelessWidget {
  const ConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CurrencyConverterCubit bloc =
        BlocProvider.of<CurrencyConverterCubit>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 60, bottom: 40),
        child: Column(
          children: [
          Image.asset('assets/imgs/converter_tool.png'),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<CurrencyConverterCubit, CurrencyConverterState>(
              bloc: bloc,
              buildWhen: (previous, current) => current is FromStateChanges,
              builder: (context, state) {
                return CustomDropDown(
                  value: bloc.from,
                  onChanged: (String? v) {
                    bloc.onChangeValue(true, value: v);
                  },
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            BlocBuilder<CurrencyConverterCubit, CurrencyConverterState>(
              bloc: bloc,
              buildWhen: (previous, current) => current is ToStateChanges,
              builder: (context, state) {
                return CustomDropDown(
                  value: bloc.to,
                  onChanged: (String? v) {
                    bloc.onChangeValue(false, value: v);
                  },
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: TextFormField(
                controller: bloc.amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Amount'),
                  hintText: 'ex:..100',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                bloc.getConvertedDataFunc(
                    amount: bloc.amountController.text,
                    from: bloc.from,
                    to: bloc.to);
              },
              child: Container(
                width: 120,
                height: 48,
                decoration: Constants.unselectedBoxDecoration,
                child: Center(
                    child: Text(
                  "Get Data",
                  textAlign: TextAlign.center,
                  style: Constants.selectedTextStyle(false),
                )),
              ),
            ),
            BlocConsumer<CurrencyConverterCubit, CurrencyConverterState>(
              listener: (context, state) {
                //print(state);
              },
              bloc: bloc,
              builder: (context, state) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    state is ErrorState
                        ? Center(
                            child: Text(state.message),
                          )
                        : state is LoadedState
                            ? Text(
                                "${state.currencyEntity.query?.amount} ${state.currencyEntity.query?.from} equals ${state.currencyEntity.result?.toStringAsFixed(2)} ${state.currencyEntity.query?.to}",
                                style: const TextStyle(
                                  color: Color(0xff212529),
                                  fontSize: 20,
                                  fontFamily: "Circular Std",
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : state is LoadingState
                                ? const CircularProgressIndicator()
                                : const SizedBox.shrink()
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
