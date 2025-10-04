import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/util/size.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kscoundPrimaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kwhite,

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal:  8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: kscoundPrimaryColor,
                  child: Column(
                    children: [
                      h40,
                      Row(
                        children: [
                          
                          //sw10,
                          Expanded(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: kwhite,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: kgrey, width: 0.5),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                   InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back, color: kblack)),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: "Search here...!",
                                          border: InputBorder.none,
                                          
                                          hintStyle: TextStyle(color: kblack,fontSize: 12),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      h20,
                    ],
                  ),
                ),
                 h5,    
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text("Popular Searches",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            ),
                h10,
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                    
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Washing machine repair',
                                    style: TextStyle(fontSize: 13,fontWeight: FontWeight.w100,color: HexColor("#353535")),
                                  ),
                                  Icon(Icons.close,color:  HexColor("#353535")),
                                ],
                              ),
                              Divider()
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
            
            
                     ],
            ),
          ),
        ),
      ),
    );
  }
}
