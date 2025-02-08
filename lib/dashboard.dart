import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'Confirm Logout',
                    style: TextStyle(color: Color.fromRGBO(10, 78, 159, 1)),
                  ),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Yes',
                          style:
                              TextStyle(color: Color.fromRGBO(10, 78, 159, 1))),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        'No',
                        style: TextStyle(color: Color.fromRGBO(10, 78, 159, 1)),
                      ),
                    ),
                  ],
                ),
              ) ??
              false;
        },
        child: // Updated background color to white

            SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Hello!',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color:
                        Color.fromARGB(255, 55, 121, 201), // Updated text color
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'How can we assist you today?',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20.0),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    DashboardButton(
                      title: 'Hospitals Near You',
                      iconAsset: 'assets/hospital.png', // URL of the image
                      onTap: () {
                        // Navigate to doctor appointment screen
                      },
                    ),
                    DashboardButton(
                      title: 'Book Appointments',
                      iconAsset: 'assets/appointment.png', // URL of the image
                      onTap: () {
                        // Navigate to lab test booking screen
                      },
                    ),
                    DashboardButton(
                      title: 'Ambulance Booking',
                      iconAsset: 'assets/ambulance.png', // URL of the image
                      onTap: () {
                        // Navigate to upload prescriptions screen
                      },
                    ),
                    DashboardButton(
                      title: 'Upload Health History',
                      iconAsset: 'assets/history.png', // URL of the image
                      onTap: () {
                        // Navigate to chat application screen
                      },
                    ),
                    DashboardButton(
                      title: 'Pharmacies Near You',
                      iconAsset: 'assets/pharmacy.png',
                      onTap: () {},
                    ),
                    DashboardButton(
                        title: 'Quick First Aid Solutions',
                        iconAsset: 'assets/first-responder.png',
                        onTap: () {}),
                  ],
                ),

                // Text(
                //   'Recommended Lab Tests',
                //   style: TextStyle(
                //     fontSize: 18.0,
                //     fontWeight: FontWeight.bold,
                //     color: Color.fromARGB(255, 0, 32, 63), // Updated text color
                //   ),
                // ),
                // SizedBox(height: 10.0),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       GestureDetector(
                //         onTap: () {},
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //           child: Image.network(
                //             'https://cms-contents.pharmeasy.in/homepage_top_categories_images/4cb2baf3234-Fullbody.png?dim=256x0',
                //             width: 150,
                //             height: 150,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //           child: Image.network(
                //             'https://cms-contents.pharmeasy.in/homepage_top_categories_images/e1a18d8deac-Vitamins.png?dim=256x0',
                //             width: 150,
                //             height: 150,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //           child: Image.network(
                //             'https://cms-contents.pharmeasy.in/homepage_top_categories_images/1e927857c26-Diabetes.png?dim=256x0',
                //             width: 150,
                //             height: 150,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //           child: Image.network(
                //             'https://cms-contents.pharmeasy.in/homepage_top_categories_images/e1c60c444bf-Fever.png?dim=256x0',
                //             width: 150,
                //             height: 150,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //           child: Image.network(
                //             'https://cms-contents.pharmeasy.in/homepage_top_categories_images/7b238cdbb60-womencare.png?dim=256x0',
                //             width: 150,
                //             height: 150,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //           child: Image.network(
                //             'https://cms-contents.pharmeasy.in/homepage_top_categories_images/71fb3c06e71-Thyroid.png?dim=256x0',
                //             width: 150,
                //             height: 150,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //           child: Image.network(
                //             'https://cms-contents.pharmeasy.in/homepage_top_categories_images/6b775dd8478-covid.png?dim=256x0',
                //             width: 150,
                //             height: 150,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //           child: Image.network(
                //             'https://cms-contents.pharmeasy.in/homepage_top_categories_images/bca113a1b80-Bone.png?dim=256x0',
                //             width: 150,
                //             height: 150,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //           child: Image.network(
                //             'https://cms-contents.pharmeasy.in/homepage_top_categories_images/520acd31898-heart.png?dim=256x0',
                //             width: 150,
                //             height: 150,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //           child: Image.network(
                //             'https://cms-contents.pharmeasy.in/homepage_top_categories_images/9696ef00b0a-lifestyle.png?dim=256x0',
                //             width: 150,
                //             height: 150,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 20.0),
                // Text(
                //   'Read About Health: HealthShaala',
                //   style: TextStyle(
                //     fontSize: 18.0,
                //     fontWeight: FontWeight.bold,
                //     color: Color.fromARGB(255, 0, 32, 63), // Updated text color
                //   ),
                // ),
                // SizedBox(
                //   height: 250, // Adjust the height according to your design
                //   child: Column(
                //     children: [
                //       Expanded(
                //         child: PageView(
                //           scrollDirection: Axis.horizontal,
                //           children: [
                //             HealthArticleCard(
                //               'Importance of Sleep',
                //               'Getting a good night\'s sleep is crucial for overall health.',
                //               imageUrl:
                //                   'https://images.pexels.com/photos/3771069/pexels-photo-3771069.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                //             ),
                //             HealthArticleCard(
                //               'Benefits of a Healthy Diet',
                //               'Eating a balanced diet contributes to better well-being.',
                //               imageUrl:
                //                   'https://images.pexels.com/photos/1172019/pexels-photo-1172019.jpeg?auto=compress&cs=tinysrgb&w=600',
                //             ),
                //             HealthArticleCard(
                //               'Stress Management',
                //               'Learn effective ways to manage stress in your life.',
                //               imageUrl:
                //                   'https://images.pexels.com/photos/3755761/pexels-photo-3755761.jpeg?auto=compress&cs=tinysrgb&w=600',
                //             ),
                //             HealthArticleCard(
                //               'Exercise for a Healthy Life',
                //               'Regular exercise has numerous health benefits.',
                //               imageUrl:
                //                   'https://images.pexels.com/photos/1199590/pexels-photo-1199590.jpeg?auto=compress&cs=tinysrgb&w=600',
                //             ),
                //           ],
                //         ),
                //       ),
                //       ElevatedButton(
                //         onPressed: () {
                //           // Handle See More button press
                //         },
                //         style: ElevatedButton.styleFrom(
                //           foregroundColor: Color.fromRGBO(10, 78, 159, 1),
                //           backgroundColor: Colors.white,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(0),
                //             side: BorderSide(
                //                 color: Color.fromRGBO(10, 78, 159, 1)),
                //           ),
                //         ),
                //         child: SizedBox(
                //           width: double.infinity,
                //           child: Text(
                //             'See More',
                //             style: TextStyle(
                //               color: Color.fromRGBO(10, 78, 159, 1),
                //               fontWeight: FontWeight.bold,
                //             ),
                //             textAlign: TextAlign.center,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ));
  }
}

class DashboardButton extends StatelessWidget {
  final String title;
  final String iconAsset; // Change IconData to String
  final VoidCallback onTap;

  DashboardButton({
    required this.title,
    required this.iconAsset, // Change IconData to String
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Color.fromARGB(255, 55, 121, 201),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 55.0,
                width: 55.0,
                child: Image.asset(
                  iconAsset, // Use the iconUrl property
                  fit: BoxFit.contain, // Fit the image within the box
                  // Apply color if needed
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LabTestCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  LabTestCard({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40.0, // Decreased icon size
              color: Colors.white,
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0, // Decreased font size
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 14.0, // Decreased font size
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthArticleCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl; // Image URL

  HealthArticleCard(this.title, this.description, {required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8, // Adjust the width here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 120, // Decreased height of the image
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0, // Decreased font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.0, // Decreased font size
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
