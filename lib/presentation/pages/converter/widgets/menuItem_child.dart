import 'package:flutter/material.dart';
import 'package:flutter_currency/app/utils/flag_store.dart';
import 'package:flutter_currency/domain/entities/currency.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItemChild extends StatelessWidget {
  const MenuItemChild({
    Key? key,
    required this.converterData,
  }) : super(key: key);
  final ConverterData converterData;

  @override
  Widget build(BuildContext context) {
    final int currencyId = converterData.id;
    return ListTile(
      leading: SvgPicture.asset(
        FlagStore.imagePath(currencyId),
        width: 40,
        height: 20,
      ),
      title: Text(converterData.curAbbr),
    );
  }
}
