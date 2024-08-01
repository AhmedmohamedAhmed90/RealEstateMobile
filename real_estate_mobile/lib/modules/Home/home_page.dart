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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
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
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomePageContent(),
    ServicesScreen(),
    QRCodePage(),
    ContactProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..loadHomeData(),
      child: HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        onToggleTheme: () {
          context.read<ThemeCubit>().toggleTheme(); // Use ThemeCubit to toggle theme
        },
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Carousel
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      child: PageView.builder(
                        itemCount: state.carouselImages.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            state.carouselImages[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  // Compounds
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Text(
                      'Compounds',
                      style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.compounds.length,
                      itemBuilder: (context, index) {
                        final compound = state.compounds[index];
                        return Container(
                          width: 120,
                          margin: EdgeInsets.symmetric(horizontal: 8),
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
                                    return Icon(Icons.image);
                                  },
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(compound['name']!, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // News
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Text(
                      'Latest News',
                      style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.news.length,
                    itemBuilder: (context, index) {
                      final newsItem = state.news[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              newsItem['image']!,
                              width: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.newspaper);
                              },
                            ),
                          ),
                          title: Text(newsItem['title']!, maxLines: 2, overflow: TextOverflow.ellipsis),
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
                  SizedBox(height: 20,)
                ],
              ),
            );
          } else {
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }
}
