


import 'package:flutter/material.dart';

import '../../domain/entites/currency_entity.dart';
import 'currency_item.dart';

class LatestCurrencyView extends StatelessWidget {
  final CurrencyEntity currencyEntity;
  const LatestCurrencyView({super.key, required this.currencyEntity});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (c, i) => CurrencyItemWidget(
              useFixedString: true,
              mapkey: currencyEntity.rates!.keys.elementAt(i),
              value: currencyEntity.rates!.values.elementAt(i),
            ),
        separatorBuilder: (c, i) => const SizedBox(
              height: 14,
            ),
        itemCount: currencyEntity.rates!.length);
  }
}
