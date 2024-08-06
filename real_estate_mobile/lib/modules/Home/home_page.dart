// // lib/home/home_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import './cubit/home_cubit.dart';
// import '../News/news_detail_page.dart';
// import '../ServicePage/ServicePage.dart';
// import '../QrCode/qr_code_page.dart';
// import '../Contact/ContactPage.dart';
// import '../ServicesScreen/ServicesScreen.dart';
// import '../../shared/components/CustomAppBar.dart';
// import '../../shared/components/CustomBottomNavBar.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;

//   static List<Widget> _pages = <Widget>[
//     HomePageContent(),
//     ServicesScreen(),
//     QRCodePage(),
//     ContactProfilePage()
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: CustomBottomNavBar(
//         selectedIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class HomePageContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => HomeCubit()..loadHomeData(),
//       child: HomePageView(),
//     );
//   }
// }

// class HomePageView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'Home'),
//       body: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           if (state is HomeInitial) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is HomeLoaded) {
//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Carousel
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 200,
//                       child: PageView.builder(
//                         itemCount: state.carouselImages.length,
//                         itemBuilder: (context, index) {
//                           return Image.network(
//                             state.carouselImages[index],
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Icon(Icons.error);
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   // Compounds
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                     child: Text(
//                       'Compounds',
//                       style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Container(
//                     height: 130,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: state.compounds.length,
//                       itemBuilder: (context, index) {
//                         final compound = state.compounds[index];
//                         return Container(
//                           width: 120,
//                           margin: EdgeInsets.symmetric(horizontal: 8),
//                           child: Column(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Image.network(
//                                   compound['image']!,
//                                   width: 100,
//                                   height: 100,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return Icon(Icons.image);
//                                   },
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(compound['name']!, overflow: TextOverflow.ellipsis),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   // News
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                     child: Text(
//                       'Latest News',
//                       style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   ListView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: state.news.length,
//                     itemBuilder: (context, index) {
//                       final newsItem = state.news[index];
//                       return Card(
//                         margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         child: ListTile(
//                           contentPadding: EdgeInsets.all(8),
//                           leading: ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.network(
//                               newsItem['image']!,
//                               width: 100,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Icon(Icons.newspaper);
//                               },
//                             ),
//                           ),
//                           title: Text(newsItem['title']!, maxLines: 2, overflow: TextOverflow.ellipsis),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => NewsDetailPage(newsItem: newsItem),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(height: 20,)
//                 ],
//               ),
//             );
//           } else {
//             return const Center(child: Text('Something went wrong!'));
//           }
//         },
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import './cubit/home_cubit.dart';
// import '../News/news_detail_page.dart';
// import '../ServicePage/ServicePage.dart';
// import '../QrCode/qr_code_page.dart';
// import '../Contact/ContactPage.dart';
// import '../ServicesScreen/ServicesScreen.dart';
// import '../../shared/components/CustomAppBar.dart';
// import '../../shared/components/CustomBottomNavBar.dart';
// import '../../shared/appcubit/ThemeCubit.dart';


// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;

//   static List<Widget> _pages = <Widget>[
//     HomePageContent(),
//     ServicesScreen(),
//     QRCodePage(),
//     ContactProfilePage()
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: CustomBottomNavBar(
//         selectedIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class HomePageContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => HomeCubit()..loadHomeData(),
//       child: HomePageView(),
//     );
//   }
// }

// class HomePageView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Home',
//         onToggleTheme: () {
//           context.read<ThemeCubit>().toggleTheme(); // Use ThemeCubit to toggle theme
//         },
//       ),
//       body: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           if (state is HomeInitial) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is HomeLoaded) {
//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Carousel
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 200,
//                       child: PageView.builder(
//                         itemCount: state.carouselImages.length,
//                         itemBuilder: (context, index) {
//                           return Image.network(
//                             state.carouselImages[index],
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Icon(Icons.error);
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   // Compounds
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                     child: Text(
//                       'Projects',
//                       style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Container(
//                     height: 130,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: state.compounds.length,
//                       itemBuilder: (context, index) {
//                         final compound = state.compounds[index];
//                         return Container(
//                           width: 120,
//                           margin: EdgeInsets.symmetric(horizontal: 8),
//                           child: Column(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Image.network(
//                                   compound['image']!,
//                                   width: 100,
//                                   height: 100,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return Icon(Icons.image);
//                                   },
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(compound['name']!, overflow: TextOverflow.ellipsis),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   // News
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                     child: Text(
//                       'Latest News',
//                       style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   ListView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: state.news.length,
//                     itemBuilder: (context, index) {
//                       final newsItem = state.news[index];
//                       return Card(
//                         margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         child: ListTile(
//                           contentPadding: EdgeInsets.all(8),
//                           leading: ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.network(
//                               newsItem['image']!,
//                               width: 100,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Icon(Icons.newspaper);
//                               },
//                             ),
//                           ),
//                           title: Text(newsItem['title']!, maxLines: 2, overflow: TextOverflow.ellipsis),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => NewsDetailPage(newsItem: newsItem),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(height: 20,)
//                 ],
//               ),
//             );
//           } else {
//             return const Center(child: Text('Something went wrong!'));
//           }
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import './cubit/home_cubit.dart';
import '../News/news_detail_page.dart';
import '../ServicePage/ServicePage.dart';
import '../QrCode/qr_code_page.dart';
import '../Contact/ContactPage.dart';
import '../ServicesScreen/ServicesScreen.dart';
import '../../shared/components/CustomAppBar.dart';
import '../../shared/components/CustomBottomNavBar.dart';
import '../../shared/appcubit/ThemeCubit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;
  int _selectedNavIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ServicesScreen(),
    QRCodePage(),
    ContactProfilePage(),
  ];

  final List<Map<String, dynamic>> quickAccessItems = [
    {
      'label': 'Home',
      'icon': Icons.home,
      'page': HomePage(),
    },
    {
      'label': 'Services',
      'icon': Icons.build,
      'page': ServicesScreen(),
    },
    {
      'label': 'QR Generator',
      'icon': Icons.qr_code,
      'page': QRCodePage(),
    },
    {
      'label': 'Profile',
      'icon': Icons.person,
      'page': ContactProfilePage(),
    },
  ];

  void _onNavItemTapped(int index) {
  setState(() {
    _selectedNavIndex = index;
  });

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => _pages[index]),
  );
}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..loadHomeData(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Home',
          onToggleTheme: () {
            context.read<ThemeCubit>().toggleTheme();
          },
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial || state is HomeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Carousel
                    SizedBox(height: 15.0),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CarouselSlider.builder(
                          carouselController: _carouselController,
                          itemCount: state.carouselImages.length,
                          itemBuilder: (context, index, realIndex) {
                            bool isCenter = _currentIndex == index;
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: isCenter ? 250 : 200,
                                child: Image.network(
                                  state.carouselImages[index],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(child: Icon(Icons.error, color: Colors.red));
                                  },
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: 210,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.7,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                        ),
                        // Scroll Indicator
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: state.carouselImages.map((url) {
                                int index = state.carouselImages.indexOf(url);
                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  width: _currentIndex == index ? 12.0 : 8.0,
                                  height: 8.0,
                                  decoration: BoxDecoration(
                                    color: _currentIndex == index ? Colors.orange : Colors.grey,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Quick Access
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quick Access',
                            style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                          GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                              childAspectRatio: 2.5,
                            ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: quickAccessItems.length,
                            itemBuilder: (context, index) {
                              final item = quickAccessItems[index];
                              return QuickAccessItem(
                                label: item['label'] as String,
                                icon: item['icon'] as IconData,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => item['page'] as Widget),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    // Projects
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Text(
                        'Projects',
                        style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 130,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.compounds.length,
                        itemBuilder: (context, index) {
                          final compound = state.compounds[index];
                          return Container(
                            width: 120,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    compound['image']!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(child: Icon(Icons.image, color: Colors.grey));
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(compound['name']!, overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Latest News
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Text(
                        'Latest News',
                        style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.news.length,
                      itemBuilder: (context, index) {
                        final newsItem = state.news[index];
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                newsItem['image']!,
                                width: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(child: Icon(Icons.newspaper, color: Colors.grey));
                                },
                              ),
                            ),
                            title: Text(newsItem['title']!),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetailPage(newsItem: newsItem),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
       bottomNavigationBar: CustomBottomNavBar(
  selectedIndex: _selectedNavIndex, // Pass the selected index
  onTap: (index) {
    _onNavItemTapped(index); // Handle navigation when an item is tapped
  },
),

      ),
    );
  }
}

class QuickAccessItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const QuickAccessItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.orange),
            SizedBox(height: 10),
            Text(label, style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

