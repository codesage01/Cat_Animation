import 'package:flutter/material.dart';
import '../screens/Widgets/cat.dart';
import 'dart:math';

 class Home extends StatefulWidget{
  HomeState createState () => HomeState();


}
 class HomeState extends State<Home> with TickerProviderStateMixin {
   late Animation<double> CatAnimation;
   late AnimationController CatController;
   late Animation<double> BoxAnimation;
   late AnimationController BoxController;

   initState() {
     super.initState();
     BoxController = AnimationController(
       duration: Duration(milliseconds: 250),
       vsync: this,);
     BoxAnimation = Tween(begin: pi*0.6, end: pi*0.65).animate(
         CurvedAnimation(
           parent: BoxController,
           curve: Curves.easeInOut,
         )
     );
     BoxController.addStatusListener((status) {
       if (status == AnimationStatus.completed) {
         BoxController.reverse();
       } else if (status == AnimationStatus.dismissed) {
         BoxController.forward();
       }
     }
     );
     BoxController.forward();



     CatController = AnimationController(
       duration: Duration(milliseconds: 200),
       vsync: this,);

     CatAnimation = Tween(begin: -20.0, end: -120.0).animate(
         CurvedAnimation(
           parent: CatController,
           curve: Curves.easeInOut,
         )
     );
   }

   OnTap() {

     if (CatController.status == AnimationStatus.completed) {
       BoxController.forward();
       CatController.reverse();
     }
     else if (CatController.status == AnimationStatus.dismissed) {
       BoxController.stop();
       CatController.forward();
     }
   }


   Widget build(context) {
     return Scaffold(
         appBar: AppBar(
           title: Text('Animation'),


         ),
         body: GestureDetector(
           child: Center(
               child: Stack(
                   clipBehavior: Clip.none,

                   children: [
                     buildCatAnimation(),
                     buildBox(),
                     buildleftflap(),
                     buildlRightflap(),


                   ]
               )
           ),
           onTap: OnTap,
         )
     );
   }

   Widget buildCatAnimation() {
     return AnimatedBuilder(
       animation: CatAnimation,
       builder: (context, child) {
         return Positioned(


           top: CatAnimation.value,
           child: Cat(),
           right: 0.0,
           left: 0.0,
         );
       }

       ,


     );
   }

   Widget buildBox() {
     return Container(
       height: 250.0,
       width: 300.0,
       color: Colors.grey,
     );
   }

   Widget buildleftflap() {
     return Positioned(
         left: 3.0,
         child: AnimatedBuilder(

           animation: BoxAnimation,
             child: Container(
               height: 10.0,
               width: 150.0,
               color: Colors.grey,
             ),
           builder: (context, child) {
             return Transform.rotate(
               child:child,


               alignment: Alignment.topLeft,
               angle: BoxAnimation.value,

             );
           },
         )
     );
   }
   Widget buildlRightflap() {
     return Positioned(
         right: 3.0,
         child: AnimatedBuilder(

           animation: BoxAnimation,
           child: Container(
             height: 10.0,
             width: 150.0,
             color: Colors.grey,
           ),
           builder: (context, child) {
             return Transform.rotate(
               child:child,


               alignment: Alignment.topRight,
               angle: -BoxAnimation.value,

             );
           },
         )
     );
   }
 }