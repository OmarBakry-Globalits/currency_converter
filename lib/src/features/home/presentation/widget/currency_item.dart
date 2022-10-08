import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_converter/src/utils/extensions.dart';
import 'package:flutter/material.dart';

class CurrencyItemWidget extends StatelessWidget {
  final String mapkey;
  final double value;
  final bool useFixedString;
  const CurrencyItemWidget(
      {super.key,
      required this.mapkey,
      required this.value,
      this.useFixedString = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      //  width: 343,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x13000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
        color: Colors.white,
      ),
      //  padding: const EdgeInsets.all(16),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: 'https://flagcdn.com/32x24/${mapkey.flagCopy()}.png',
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error_outline),
        ),
        title: Text(
          mapkey,
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Color.fromRGBO(33, 37, 41, 1),
              fontFamily: 'Circular Std',
              fontSize: 16,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
        subtitle: Text(
          mapkey.toLowerCase(),
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Color.fromRGBO(108, 117, 125, 1),
              fontFamily: 'Circular Std',
              fontSize: 12,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
        trailing: Text(
          useFixedString ? value.toStringAsFixed(3) : value.toString(),
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Color.fromRGBO(33, 37, 41, 1),
              fontFamily: 'Circular Std',
              fontSize: 16,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
      ),
      // child: Row(
      //   //mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      // CachedNetworkImage(
      //   imageUrl: 'https://flagcdn.com/32x24/${mapkey.flagCopy()}.png',
      //   placeholder: (context, url) =>
      //       const CircularProgressIndicator(),
      //   errorWidget: (context, url, error) =>
      //       const Icon(Icons.error_outline),
      // ),
      //         const SizedBox(
      //           width: 15,
      //         ),
      //         Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      // Text(
      //   mapkey,
      //   textAlign: TextAlign.right,
      //   style: const TextStyle(
      //       color: Color.fromRGBO(33, 37, 41, 1),
      //       fontFamily: 'Circular Std',
      //       fontSize: 16,
      //       fontWeight: FontWeight.normal,
      //       height: 1),
      // ),
      // Text(
      //   mapkey.toLowerCase(),
      //   textAlign: TextAlign.left,
      //   style: const TextStyle(
      //       color: Color.fromRGBO(108, 117, 125, 1),
      //       fontFamily: 'Circular Std',
      //       fontSize: 12,
      //       fontWeight: FontWeight.normal,
      //       height: 1),
      // )
      //           ],
      //         ),
      //       ],
      //     ),
      //     const Spacer(),
      //     const Text(
      //       'USD',
      //       textAlign: TextAlign.left,
      //       style: TextStyle(
      //           color: Color.fromRGBO(33, 37, 41, 1),
      //           fontFamily: 'Circular Std',
      //           fontSize: 16,
      //           fontWeight: FontWeight.normal,
      //           height: 1),
      //     ),
      //     const Spacer(),
      // Text(
      //   value.toStringAsFixed(3),
      //   textAlign: TextAlign.left,
      //   style: const TextStyle(
      //       color: Color.fromRGBO(33, 37, 41, 1),
      //       fontFamily: 'Circular Std',
      //       fontSize: 16,
      //       fontWeight: FontWeight.normal,
      //       height: 1),
      // ),
      //   ],
      // ),
    );
  }
}
