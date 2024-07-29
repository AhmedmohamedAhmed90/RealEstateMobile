import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import './cubit/home_cubit.dart';
import '../News/news_detail_page.dart'; // Assuming you have this page for news details
import '../ServicePage/ServicePage.dart';
import '../QrCode/qr_code_page.dart';
import '../Contact/ContactPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomePageContent(),
    ServicePage(),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build, color: Colors.green),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code, color: Colors.red),
            label: 'QR Generator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.purple),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          return Column(
            children: [
              // Carousel
              Container(
                height: 200, // Adjust the height here
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
              // Compounds
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: state.compounds.map((compound) {
                  return Container(
                    width: 100,
                    child: Column(
                      children: [
                        Image.network(
                          compound['image']!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error);
                          },
                        ),
                        Text(compound['name']!),
                      ],
                    ),
                  );
                }).toList(),
              ),
              // News
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: state.news.length,
                  itemBuilder: (context, index) {
                    final newsItem = state.news[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8),
                        leading: Image.network(
                          newsItem['image']!,
                          width: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error);
                          },
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
              ),
            ],
          );
        } else {
          return const Center(child: Text('Something went wrong!'));
        }
      },
    );
  }
}

