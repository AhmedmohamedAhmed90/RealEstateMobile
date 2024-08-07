
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
import 'carousel_with_Indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedNavIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    ServicesScreen(),
    QRCodePage(),
    ContactProfilePage(),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..loadHomeData(),
      child: Scaffold(
        body: _pages[_selectedNavIndex],

      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final CarouselController _carouselController = CarouselController();

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial || state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Carousel
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselWithIndicator(carouselImages: state.carouselImages),
                ),
                // Quick Access
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Access',
                        style: Theme.of(context).textTheme.bodyLarge, // Use theme text style
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 2.5,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: quickAccessItems.length,
                        itemBuilder: (context, index) {
                          final item = quickAccessItems[index];
                          return QuickAccessItem(
                            label: item['label'] as String,
                            icon: item['icon'] as IconData,
                            onTap: () {
                              Navigator.pushReplacement(
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
                    style: Theme.of(context).textTheme.headlineMedium, // Use theme text style
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
                                  return const Center(child: Icon(Icons.image, color: Colors.grey));
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
                    style: Theme.of(context).textTheme.titleLarge, // Use theme text style
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.news.length,
                  itemBuilder: (context, index) {
                    final newsItem = state.news[index];
                    return Card(
                      color: Theme.of(context).cardColor, // Use theme card color
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
                              return const Center(child: Icon(Icons.newspaper, color: Colors.grey));
                            },
                          ),
                        ),
                        title: Text(newsItem['title']!, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).secondaryHeaderColor)),
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
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).cardColor, // Use theme color
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Theme.of(context).secondaryHeaderColor), // Use theme color
            const SizedBox(height: 10),
            Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).secondaryHeaderColor) ), // Use theme text style
          ],
        ),
      ),
    );
  }
}
