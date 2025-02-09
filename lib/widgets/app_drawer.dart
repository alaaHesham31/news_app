import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  Function onTap;
   AppDrawer({required this.onTap,super.key});


  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
   String selectedValue ='Dark';
   List<String> themes = ['Dark', 'Light'];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: Color(0xFF171717),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
              ),
            ),
            child: Center(
              child: Text(
                'News App',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF171717),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              widget.onTap();
            },
            child: ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              title: Text(
                'Go to Home',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
              subtitle: Text(
                "Click Here",
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(
              height: 2,
              color: Color(0xFFFFFFFF),
            ),
          ),
          ListTile(
            leading: Image(image: AssetImage('assets/images/roller-paint-brush.png',),),
            title: Text(
              'Go to Home',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ),
            const SizedBox(height: 8,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 24.0),
             child: Container(
               width: double.infinity,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(16),
                 border: Border.all(color: Color(0xFFFFFFFF), width: 2),
               ),
               child: DropdownButtonHideUnderline(
                   child: DropdownButton<String>(
                     value: selectedValue,
                     dropdownColor: Colors.black, // Dropdown list background color
                     icon: Icon(Icons.arrow_drop_down, color: Colors.white), // White arrow
                     style: TextStyle(color: Colors.white, fontSize: 16), // White text
                     items: themes.map((String item) {
                       return DropdownMenuItem<String>(
                         value: item,
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(item, style: TextStyle(color: Colors.white)),
                         ), // White text for items
                       );
                     }).toList(),
                     onChanged: (String? newValue) {
                       setState(() {
                         selectedValue = newValue!;
                       });
                     },
                   ),
             ),
             ),
           ),
          const SizedBox(height: 8,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(
              height: 2,
              color: Color(0xFFFFFFFF),
            ),
          ),
          ListTile(
            leading: Image(image: AssetImage('assets/images/language_icon.png',),),
            title: Text(
              'Go to Home',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFFFFFFFF), width: 2),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue,
                  dropdownColor: Colors.black, // Dropdown list background color
                  icon: Icon(Icons.arrow_drop_down, color: Colors.white), // White arrow
                  style: TextStyle(color: Colors.white, fontSize: 16), // White text
                  items: themes.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item, style: TextStyle(color: Colors.white)),
                      ), // White text for items
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 8,),


        ],
      ),
    );
  }
}
