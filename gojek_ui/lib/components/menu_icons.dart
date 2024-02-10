import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gojek_ui/datas/icons.dart';
import 'package:gojek_ui/theme.dart';

class MenuIcons extends StatelessWidget {
  const MenuIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 27, right: 27, top: 32),
      child: SizedBox(
        height: 157,
        child: GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          children: [
            ...menuIcons.map((icons) => Container(
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: icons.icon == 'goclub'
                              ? Colors.white
                              : icons.color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/${icons.icon}.svg',
                          width: 24,
                          color: icons.icon == 'goclub'
                              ? icons.color
                              : icons.icon == 'other'
                                  ? dark2
                                  : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Text(
                        icons.title,
                        style: regular12_5.copyWith(color: dark1),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
