import 'package:flutter/material.dart';

class PositionedButton extends StatelessWidget {
  final bool isRight ;
  final VoidCallback onTap;

  PositionedButton({super.key, required this.isRight, required this.onTap   });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: isRight ? 10 : null,
      left: isRight? null : 10,
      bottom: 10,
      child: Stack(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              width: 180,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFF171717).withOpacity(.5),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if(!isRight)
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF171717),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFFFFFFFF),
                    size: 32,
                  ),
                ),
              SizedBox(width: 10,),
              Text(
                'View All',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter'),
                textAlign: TextAlign.center,

              ),
              SizedBox(width: 22,),
              if(isRight)
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF171717),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFFFFFFFF),
                    size: 32,
                  ),
                ),
            ],
          ),

        ],
      ),
    );
  }
}

