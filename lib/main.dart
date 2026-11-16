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
      home: const GalleryHomePage(),
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
    title: 'Your Photo',
    subtitle: 'Photo you shared',
    imageAsset: 'assets/images/BLPW6079.PNG',
  ),
  GalleryPhoto(
    title: 'Mountain Photo',
    subtitle: 'Your second photo',
    imageAsset: 'assets/images/gallery-photo-02.png',
  ),
  GalleryPhoto(
    title: 'Forest Trail',
    subtitle: 'A quiet walk among the trees',
    imageAsset: 'assets/images/forest-trail.jpg',
  ),
  GalleryPhoto(
    title: 'Mountain Lake',
    subtitle: 'Clear water beneath the peaks',
    imageAsset: 'assets/images/mountain-lake.jpg',
  ),
  GalleryPhoto(
    title: 'Green Forest',
    subtitle: 'A peaceful woodland path',
    imageAsset: 'assets/images/green-forest.jpg',
  ),
  GalleryPhoto(
    title: 'Mountain Peaks',
    subtitle: 'High peaks beneath the clouds',
    imageAsset: 'assets/images/mountain-peaks.jpg',
  ),
];

class _GalleryImage extends StatelessWidget {
  const _GalleryImage({required this.photo});

  final GalleryPhoto photo;

  @override
  Widget build(BuildContext context) =>
      Image.asset(photo.imageAsset, fit: BoxFit.cover);
}

class GalleryHomePage extends StatefulWidget {
  const GalleryHomePage({super.key});

  @override
  State<GalleryHomePage> createState() => _GalleryHomePageState();
}

class _GalleryHomePageState extends State<GalleryHomePage> {
  int _selectedIndex = 0;
  bool _albumIsOpen = false;
  TimeOfDay _alarmTime = const TimeOfDay(hour: 10, minute: 0);
  String _alarmLabel = "Alarm at 10 o'clock";

  String get _appBarTitle {
    if (_selectedIndex == 0) return 'Home';
    if (_selectedIndex == 1) return 'Photos';
    return _albumIsOpen ? 'My Album' : 'Albums';
  }

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
      _albumIsOpen = false;
    });
  }

  Future<void> _chooseAlarmTime() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _alarmTime,
    );
    if (selectedTime == null || !mounted) return;

    setState(() {
      _alarmTime = selectedTime;
      _alarmLabel = 'Alarm at ${selectedTime.format(context)}';
    });
  }

  void _showPhoto(BuildContext context, int index) {
    final photo = _photos[index];
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCE3EB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: _GalleryImage(photo: photo),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                photo.title,
                style: const TextStyle(
                  color: Color(0xFF17243A),
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                photo.subtitle,
                style: const TextStyle(color: Color(0xFF748196), fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeContent() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.photo_library,
                color: Color(0xFF2D78C4),
                size: 60,
              ),
              const SizedBox(height: 18),
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
                'View your photos and albums here.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF68736B), fontSize: 14),
              ),
              const SizedBox(height: 24),
              const Divider(indent: 8, endIndent: 8),
              const SizedBox(height: 8),
              Card(
                color: Colors.white,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.add_alarm,
                    color: Color(0xFF102A43),
                  ),
                  title: const Text(
                    'Alarm',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(_alarmLabel),
                  trailing: const Icon(
                    Icons.access_alarm,
                    color: Color(0xFF2D78C4),
                  ),
                  onTap: _chooseAlarmTime,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _photosContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PageHeading(title: 'Photos', subtitle: 'All 6 of your photos.'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: _PhotoGrid(onPhotoTap: _showPhoto),
          ),
        ),
      ],
    );
  }

  Widget _albumsContent() {
    if (_albumIsOpen) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () => setState(() => _albumIsOpen = false),
            icon: const Icon(Icons.arrow_back_rounded),
            label: const Text('All albums'),
          ),
          const _PageHeading(title: 'My Album', subtitle: '6 photos'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: _PhotoGrid(onPhotoTap: _showPhoto),
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PageHeading(
            title: 'Albums',
            subtitle: 'Your photos, collected in one album.',
          ),
          _AlbumCard(onTap: () => setState(() => _albumIsOpen = true)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final page = switch (_selectedIndex) {
      0 => _homeContent(),
      1 => _photosContent(),
      _ => _albumsContent(),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        backgroundColor: const Color(0xFF102A43),
        foregroundColor: Colors.white,
        surfaceTintColor: const Color(0xFF102A43),
      ),
      drawer: _GalleryDrawer(
        selectedIndex: _selectedIndex,
        onSelected: (index) {
          Navigator.pop(context);
          _selectTab(index);
        },
      ),
      body: SafeArea(child: page),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _selectTab,
        backgroundColor: const Color(0xFFDCEBFA),
        selectedItemColor: const Color(0xFF246BB2),
        unselectedItemColor: const Color(0xFF718AA3),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_outlined),
            activeIcon: Icon(Icons.photo),
            label: 'Photos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album_outlined),
            activeIcon: Icon(Icons.photo_album),
            label: 'Albums',
          ),
        ],
      ),
    );
  }
}

class _GalleryDrawer extends StatelessWidget {
  const _GalleryDrawer({required this.selectedIndex, required this.onSelected});

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
            icon: Icons.photo_outlined,
            title: 'Photos',
            selected: selectedIndex == 1,
            onTap: () => onSelected(1),
          ),
          _DrawerItem(
            icon: Icons.photo_album_outlined,
            title: 'Albums',
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

class _PageHeading extends StatelessWidget {
  const _PageHeading({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF17243A),
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(color: Color(0xFF778397), fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _PhotoGrid extends StatelessWidget {
  const _PhotoGrid({required this.onPhotoTap});

  final void Function(BuildContext, int) onPhotoTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900
            ? 3
            : constraints.maxWidth >= 560
            ? 2
            : 1;
        return GridView.builder(
          itemCount: _photos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            mainAxisExtent: 260,
          ),
          itemBuilder: (context, index) => _PhotoCard(
            photo: _photos[index],
            number: index + 1,
            onTap: () => onPhotoTap(context, index),
          ),
        );
      },
    );
  }
}

class _AlbumCard extends StatelessWidget {
  const _AlbumCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  for (final photo in _photos.take(2))
                    Expanded(child: _GalleryImage(photo: photo)),
                ],
              ),
            ),
            const ListTile(
              title: Text(
                'My Album',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text('6 photos'),
              trailing: Icon(Icons.arrow_forward_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  const _PhotoCard({
    required this.photo,
    required this.number,
    required this.onTap,
  });

  final GalleryPhoto photo;
  final int number;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _GalleryImage(photo: photo),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.94),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        number.toString().padLeft(2, '0'),
                        style: const TextStyle(
                          color: Color(0xFF23354E),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
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
      ),
    );
  }
}
