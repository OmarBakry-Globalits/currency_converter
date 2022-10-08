
import 'package:currency_converter/src/features/home/domain/entites/currency_historical_entity.dart';
import 'package:flutter/material.dart';

import 'currency_item.dart';

class HistoricalView extends StatelessWidget {
  final CurrencyHistoricalEntity historicalEntity;
  const HistoricalView({super.key, required this.historicalEntity});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (c, i) => CurrencyItemWidget(
              mapkey: historicalEntity.rates!.values.elementAt(i).keys.first,
              value: historicalEntity.rates!.values
                  .elementAt(i)
                  .values
                  .first
                  .toDouble(),
            ),
        separatorBuilder: (c, i) => const SizedBox(
              height: 14,
            ),
        itemCount: historicalEntity.rates!.length);
  }
}