import 'package:amburush/auth/signup_driver.dart';
import 'package:amburush/auth/signup_page.dart';
import 'package:flutter/material.dart';

class Usertype extends StatelessWidget {
  const Usertype({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        

        children: [
          Padding(padding: EdgeInsets.all(8.0)),
           SizedBox(height: 40),
                      Text('AmbuRush',
                      style: TextStyle(
                        fontFamily: 'interB',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color:  Color.fromRGBO(10, 78, 159, 1))),
                        SizedBox(height: 60,),
                        
                        SizedBox(
                          height: 200, child: Image.asset('assets/ambulance.png')),
                          SizedBox(height: 130,),
          Padding(padding: EdgeInsets.all(16),

          
            child: 
            Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  child: ElevatedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage())), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color.fromRGBO(10, 78, 159, 1),
                    
                    
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,10,0),
                    child: Container(
                      
                      
                      child: Center(
                        child: Text('SignUp as User',
                        
                        style: TextStyle(
                          fontFamily: 'intersB',
                          fontSize: 18,
                          color: Colors.white
                        ),),
                      ),
                    ),
                  )),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(8.0),
                    child: Text('or',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16
                    ),),),
                    Container(
                      width: 100,
                      child: Divider(
                        thickness: 1,
                      ),
                    )
                  
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  width: 350,
                  child: ElevatedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignorgPage())), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color.fromRGBO(10, 78, 159, 1),
                    
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                    )
                            
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,10,0),
                    child: Container(
                      // width: 180,
                      child: Center(
                        child: Text('SignUp as Driver',
                        style: TextStyle(
                          fontFamily: 'intersB',
                          fontSize: 16,
                          color: Colors.white
                        ),),
                      ),
                    ),
                  )),
                ),
          
              ],
            ),),
        ],
      )

    );
  }
}