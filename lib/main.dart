import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const AmbulanceGalleryApp());
}

class AmbulanceGalleryApp extends StatelessWidget {
  const AmbulanceGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Gallery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF3F7FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2D78C4),
          brightness: Brightness.light,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _navigationTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/places/hunza_valley.jpg',
            fit: BoxFit.cover,
            semanticLabel: 'Hunza Valley mountains',
          ),
          const ColoredBox(color: Color(0xCC102A43)),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.photo_library_rounded,
                        color: Color(0xFF2D78C4),
                        size: 62,
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'My Gallery',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'A little collection of places and memories',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFFDCEBFA), fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AppPage(
      title: 'Home',
      selectedIndex: 0,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: SizedBox(
                    height: 190,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/images/places/hunza_valley.jpg',
                          fit: BoxFit.cover,
                          semanticLabel: 'Hunza Valley in Gilgit-Baltistan',
                        ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Color(0xCC102A43)],
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 18,
                          bottom: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'HUNZA VALLEY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Gilgit-Baltistan, Pakistan',
                                style: TextStyle(
                                  color: Color(0xFFE5F0FB),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Welcome to My Gallery',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF26332A),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Explore beautiful places and learn more about this app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF68736B), fontSize: 14),
                ),
                const SizedBox(height: 24),
                const Divider(indent: 8, endIndent: 8),
                const SizedBox(height: 8),
                _HomeNavigationCard(
                  icon: Icons.place_outlined,
                  title: 'Explore the list',
                  subtitle: 'Browse 12 beautiful places',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => const ListScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _HomeNavigationCard(
                  icon: Icons.info_outline_rounded,
                  title: 'About this gallery',
                  subtitle: 'See the photo collection',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => const AboutScreen(),
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

class _HomeNavigationCard extends StatelessWidget {
  const _HomeNavigationCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        leading: Icon(icon, color: const Color(0xFF2D78C4), size: 28),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_rounded),
        onTap: onTap,
      ),
    );
  }
}

class Place {
  const Place({
    required this.name,
    required this.region,
    required this.imageAsset,
  });

  final String name;
  final String region;
  final String imageAsset;
}

const _places = [
  Place(
    name: 'Hunza Valley',
    region: 'Gilgit-Baltistan',
    imageAsset: 'assets/images/places/hunza_valley.jpg',
  ),
  Place(
    name: 'Swat Valley',
    region: 'Khyber Pakhtunkhwa',
    imageAsset: 'assets/images/places/swat_valley.jpg',
  ),
  Place(
    name: 'Skardu',
    region: 'Gilgit-Baltistan',
    imageAsset: 'assets/images/places/skardu.jpg',
  ),
  Place(
    name: 'Fairy Meadows',
    region: 'Gilgit-Baltistan',
    imageAsset: 'assets/images/places/fairy_meadows.jpg',
  ),
  Place(
    name: 'Murree',
    region: 'Punjab',
    imageAsset: 'assets/images/places/murree.jpg',
  ),
  Place(
    name: 'Naran',
    region: 'Khyber Pakhtunkhwa',
    imageAsset: 'assets/images/places/naran.jpg',
  ),
  Place(
    name: 'Shogran',
    region: 'Khyber Pakhtunkhwa',
    imageAsset: 'assets/images/places/shogran.jpg',
  ),
  Place(
    name: 'Neelum Valley',
    region: 'Azad Kashmir',
    imageAsset: 'assets/images/places/neelum_valley.jpg',
  ),
  Place(
    name: 'Passu Cones',
    region: 'Gilgit-Baltistan',
    imageAsset: 'assets/images/places/passu_cones.jpg',
  ),
  Place(
    name: 'Khunjerab Pass',
    region: 'Gilgit-Baltistan',
    imageAsset: 'assets/images/places/khunjerab_pass.jpg',
  ),
  Place(
    name: 'Kalam',
    region: 'Khyber Pakhtunkhwa',
    imageAsset: 'assets/images/places/kalam.jpg',
  ),
  Place(
    name: 'Ratti Gali Lake',
    region: 'Azad Kashmir',
    imageAsset: 'assets/images/places/ratti_gali_lake.jpg',
  ),
];

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AppPage(
      title: 'Places',
      selectedIndex: 1,
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        itemCount: _places.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final place = _places[index];
          return Card(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: SizedBox(
              height: 104,
              child: Row(
                children: [
                  SizedBox(
                    width: 112,
                    height: double.infinity,
                    child: Image.asset(
                      place.imageAsset,
                      fit: BoxFit.cover,
                      semanticLabel: place.name,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF1E2C42),
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            place.region,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF68736B),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: Text(
                      (index + 1).toString().padLeft(2, '0'),
                      style: const TextStyle(
                        color: Color(0xFF8995A7),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class GalleryPhoto {
  const GalleryPhoto({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
  });

  final String title;
  final String subtitle;
  final String imageAsset;
}

const _photos = [
  GalleryPhoto(
    title: 'Hunza Valley',
    subtitle: 'Gilgit-Baltistan',
    imageAsset: 'assets/images/places/hunza_valley.jpg',
  ),
  GalleryPhoto(
    title: 'Swat Valley',
    subtitle: 'Khyber Pakhtunkhwa',
    imageAsset: 'assets/images/places/swat_valley.jpg',
  ),
  GalleryPhoto(
    title: 'Skardu',
    subtitle: 'Gilgit-Baltistan',
    imageAsset: 'assets/images/places/skardu.jpg',
  ),
  GalleryPhoto(
    title: 'Fairy Meadows',
    subtitle: 'At the foot of Nanga Parbat',
    imageAsset: 'assets/images/places/fairy_meadows.jpg',
  ),
  GalleryPhoto(
    title: 'Murree',
    subtitle: 'Punjab',
    imageAsset: 'assets/images/places/murree.jpg',
  ),
  GalleryPhoto(
    title: 'Naran',
    subtitle: 'Khyber Pakhtunkhwa',
    imageAsset: 'assets/images/places/naran.jpg',
  ),
];

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AppPage(
      title: 'About',
      selectedIndex: 2,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About My Gallery',
                  style: TextStyle(
                    color: Color(0xFF17243A),
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'A collection of moments and peaceful places.',
                  style: TextStyle(color: Color(0xFF778397), fontSize: 13),
                ),
                SizedBox(height: 16),
                Text(
                  'Photo collection',
                  style: TextStyle(
                    color: Color(0xFF26332A),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisExtent: 220,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _photos.length,
              itemBuilder: (context, index) => _PhotoCard(
                photo: _photos[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  const _PhotoCard({required this.photo});

  final GalleryPhoto photo;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              photo.imageAsset,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 10, 11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  photo.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF1E2C42),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  photo.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF8995A7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppPage extends StatelessWidget {
  const _AppPage({
    required this.title,
    required this.selectedIndex,
    required this.body,
  });

  final String title;
  final int selectedIndex;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: canPop
            ? IconButton(
                tooltip: 'Back',
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => Navigator.pop(context),
              )
            : Builder(
                builder: (context) => IconButton(
                  tooltip: 'Open menu',
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
        title: Text(title),
        backgroundColor: const Color(0xFF102A43),
        foregroundColor: Colors.white,
        surfaceTintColor: const Color(0xFF102A43),
        actions: [
          if (canPop)
            Builder(
              builder: (context) => IconButton(
                tooltip: 'Open menu',
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
        ],
      ),
      drawer: _GalleryDrawer(
        selectedIndex: selectedIndex,
        onSelected: (index) {
          Navigator.pop(context);
          if (index == selectedIndex) return;
          final screen = switch (index) {
            0 => const HomeScreen(),
            1 => const ListScreen(),
            _ => const AboutScreen(),
          };
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (_) => screen),
          );
        },
      ),
      body: SafeArea(child: body),
    );
  }
}

class _GalleryDrawer extends StatelessWidget {
  const _GalleryDrawer({
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF102A43)),
            accountName: Text('M Yasir'),
            accountEmail: Text('63281@student.riphah.edu.pk'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.photo_library_rounded,
                color: Color(0xFF2D78C4),
                size: 30,
              ),
            ),
          ),
          _DrawerItem(
            icon: Icons.home_outlined,
            title: 'Home',
            selected: selectedIndex == 0,
            onTap: () => onSelected(0),
          ),
          _DrawerItem(
            icon: Icons.place_outlined,
            title: 'Places',
            selected: selectedIndex == 1,
            onTap: () => onSelected(1),
          ),
          _DrawerItem(
            icon: Icons.info_outline_rounded,
            title: 'About',
            selected: selectedIndex == 2,
            onTap: () => onSelected(2),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: selected,
      selectedColor: const Color(0xFF246BB2),
      onTap: onTap,
    );
  }
}
