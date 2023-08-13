import 'package:flutter/material.dart';
//import '../layout/hom_layout.dart';
class Taskitem extends StatefulWidget {
      final Map model;
       Taskitem (this. model, {super.key} );

  @override
  State<Taskitem> createState() => _TaskitemState();
}

class _TaskitemState extends State<Taskitem> {
        bool valu=false;

  @override
  Widget build(BuildContext context) {
    
    return  Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [
          
          const CircleAvatar(
            radius: 40,
            child: Text("3.43"),
          ),
           const SizedBox(width: 20,),
           const Expanded(
             child: Column(
              mainAxisSize: MainAxisSize.min,
               children: [
                //${widget.model}['title']
                 Text("go to",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                  Text("23-4-5",style: TextStyle(color: Colors.grey),),
                
               ],
             ),
           ),
     Checkbox(
            value: valu, 
            onChanged: (value){
               setState(() {
                 valu=value!;

             });
             //updateData();
            }
            ),
      IconButton(
       onPressed: (){
       //updateData();
      
         
      }, 
      icon: const Icon(Icons.archive_outlined,
      color: Colors.redAccent,
      )
      ),
        ],
      
      ),
    );
  }
}