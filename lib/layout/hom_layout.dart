import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/modules/archived_task/archived_taskScreen.dart';
import 'package:sqflite/sqflite.dart';
import '../const/const.dart';
import '../modules/don_task/don_taskScreen.dart';
import '../modules/new_task/new_taskScreen.dart';

class HomLayout extends StatefulWidget {
  

  const HomLayout({super.key});

  @override
  State<HomLayout> createState() => _HomLayoutState();
}
 
class _HomLayoutState extends State<HomLayout> {
  int currentIndex=0;
   List<Widget> screens=[
        NewTaskScreen(),
        DoneTaskScreen(),
        ArchivedTaskScreen(),

   ];
   List<String> titles=[
    'New Tasks',
    'Done Tasks',
    'Archived Tasks'
   ];
        late Database database;
         var scaffoldKey=GlobalKey<ScaffoldState>();
          var formKey=GlobalKey<FormState>();
     
          bool bottomSheetShow=false;
          IconData fadicon=Icons.edit;
          var titleController=TextEditingController();
          var timeController=TextEditingController();
          var dateController=TextEditingController();
  @override
  void initState() {
     // TODO: implement initState
     super.initState();
     creatDataBas();
   }
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        appBar: AppBar(
          title: Text(titles[currentIndex])
          //Text("Todo App"),
        ),
        body: tasks.length==0?Center(child: CircularProgressIndicator()):
        screens[currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed:(){
            if(bottomSheetShow){
             
                      Navigator.pop(context);
                       bottomSheetShow=false;
                      setState(() {
                fadicon=Icons.edit;
              });
                    
                    
             
            }
            else{
             scaffoldKey.currentState!.showBottomSheet((context) {
              
               return Form(
              key: formKey,
              child: Container(
                //color: const Color.fromARGB(125, 255, 255, 255),
                //color: Colors.grey[300],
                margin: EdgeInsets.all(20),
               //padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller:titleController ,
                      keyboardType: TextInputType.text,
                      validator: ( value) {
                        if(value!.isEmpty ){
              
                     return "title not be empty";
                      }
                      return null;
                      },
                      
                      decoration: InputDecoration(labelText: "Task Title",
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                       ),
                      prefixIcon:Icon(Icons.title) ),
                     
                    ),
             
                    SizedBox(height: 10,),
                     TextFormField(
                      controller:timeController,
             
                      keyboardType: TextInputType.datetime,
                      validator: ( value) {
                        if(value!.isEmpty ){
              
                     return "time not be empty";
                      }
                      return null;
                      },
                      
                      decoration: InputDecoration(labelText: "Task time",
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                       ),
                      prefixIcon:Icon(Icons.watch_later) ),
                      onTap: () {
                        showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) => 
                        timeController.text=value!.format(context).toString(),
                        
                        
                        );
                      },
                     
                    ),
                     SizedBox(height: 10,),
                     TextFormField(
                      controller:dateController,
             
                      keyboardType: TextInputType.datetime,
                      validator: ( value) {
                        if(value!.isEmpty ){
              
                     return "time not be empty";
                      }
                      return null;
                      },
                      
                      decoration: InputDecoration(labelText: "Task date",
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                       ),
                      prefixIcon:Icon(Icons.watch_later) ),
                      onTap: () {
                        showDatePicker(context: context, 
                        initialDate:DateTime.now(), 
                        firstDate:DateTime.now(), 
                        lastDate: DateTime.parse('2025-05-03')).then((value) =>
                      dateController.text=DateFormat.yMMMd().format(value!)
                        );
                      },
                     
                    ),
                     Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,
                    vertical: 10),
                    child: MaterialButton(
                     minWidth: double.infinity,
                  color: const Color.fromARGB(255, 76, 144, 175),
                      height: 50,
                      shape: const RoundedRectangleBorder(
                        borderRadius:BorderRadius.all(Radius.circular(12)) ),
                      child: const Text("sav",
                      style: TextStyle(color:Colors.white ,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      ) ,
                      ),
                      
                      
                      onPressed: (){
                         if(formKey.currentState!.validate()){
                    InsertToDataBas(
                        title: titleController.value,
                      date: dateController,
                       time: timeController,


                    );
                         }
                      }
                    
                    
                    ),
                  ),
                  ],
                ),
              ),
                         
                         );
             },elevation: 150,
            );
           bottomSheetShow=true;
           setState(() {
                fadicon=Icons.add;
              });
           
            
            }
           
          },
         child: Icon(fadicon),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index){
            setState(() {
              currentIndex=index;
            });
            },
            items: const [
            BottomNavigationBarItem(
              icon:Icon(Icons.menu),
              label: "Tasks",
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.check_circle_outline),
              label: "Done",
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.archive_outlined),
              label: "Archived",
            ),


          ],),

    );
  }
  
  void creatDataBas()async{
  database= await  openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version){
    print('create database');
        database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY ,title TEXT,date TEXT,time TEXT,status TEXT)').then((value) => 
        print('creare table')
        ).catchError((error){

          print('error when create table ${error.toString()}');
        });

      },
      onOpen: (database){
        getDate(database).then((value) {
          tasks=value;
          //print(tasks[0]);
         print(tasks[0]['title']);
          //print(tasks[0]['time']);

        },);
                print('database open');

      }
    );

  }
   InsertToDataBas({required  title,required  time,required  date} )async {
  await database.transaction((txn)async
    {
     return txn.rawInsert('INSERT INTO tasks(title,date,time,status)VALUES("$title","$date","$time","new")').then((value) => 
      print("$value success")
      ).catchError((erorr){
     print('error when insert table${erorr.toString()}');
     
       }
        );
    
    },
    );
  }
  Future<List<Map>> getDate(database)async
  {
    return database.rawQuery('SELECT *FROM tasks');

  
  }
//  Future<int> updateData(
//   {required String status,
//   required int id,
//   }
//  )async
//  {

//   return  await database.rawUpdate(
          
//     'UPDATE tasks SET status = ? WHERE id = ?',
//     ['updated $status', id,]);

//  }
}
 