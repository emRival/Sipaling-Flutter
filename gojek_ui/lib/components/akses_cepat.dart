import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gojek_ui/theme.dart';

class AksesCepat extends StatelessWidget {
  const AksesCepat({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Akses Cepat",
            style: bold18.copyWith(color: dark1),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffE8E8E8),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(children: [
              ...['Pintu masuk motor, MNC Land', 'Pintu keluar motor, MNC Land']
                  .map(
                (text) => Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: green1,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/goride.svg',
                          width: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          text,
                          style: regular14.copyWith(color: dark1),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/left.svg',
                        color: dark1,
                        height: 24,
                      )
                    ],
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
