import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AdminDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;
  final List<UserModel> _users = [];
  final List<CarModel> _cars = [];

  @override
  void initState() {
    super.initState();
    _loadSampleData();
  }

  void _loadSampleData() {
    // Sample users
    _users.addAll([
      UserModel(
        id: 1,
        firstName: "John",
        lastName: "Doe",
        uaeID: "784-1980-1234567-1",
        email: "john.doe@example.com",
        phone: "+971501234567",
        password: "hashed_password",
        roles: [Role(id: 1, roleName: "User")],
        cars: [],
        orders: [],
        emirate_id_passport: ["https://picsum.photos/300/400"],
        driving_licence: ["https://picsum.photos/300/400"],
        residence_proof: ["https://picsum.photos/300/400"],
        pointsBalance: 150.0,
      ),
      UserModel(
        id: 2,
        firstName: "Sarah",
        lastName: "Smith",
        uaeID: "784-1985-7654321-1",
        email: "sarah.smith@example.com",
        phone: "+971501234568",
        password: "hashed_password",
        roles: [Role(id: 1, roleName: "User")],
        cars: [],
        orders: [],
        emirate_id_passport: null,
        driving_licence: ["https://picsum.photos/300/400"],
        residence_proof: ["https://picsum.photos/300/400"],
        pointsBalance: 75.0,
      ),
      UserModel(
        id: 3,
        firstName: "Ahmed",
        lastName: "Al",
        uaeID: "784-1990-1122334-1",
        email: "ahmed.al@example.com",
        phone: "+971501234569",
        password: "hashed_password",
        roles: [Role(id: 1, roleName: "User")],
        cars: [],
        orders: [],
        emirate_id_passport: ["https://picsum.photos/300/400"],
        driving_licence: null,
        residence_proof: null,
        pointsBalance: 200.0,
      ),
    ]);

    // Sample cars
    _cars.addAll([
      CarModel(
        id: 1,
        brand: "Toyota",
        model: "Camry",
        color: "White",
        matriculation: "DXB-123",
        year: 2022,
        seatsNumber: 5,
        price: 150.0,
        type: "Sedan",
        status: "pending",
        address: Address(
          street: "Sheikh Zayed Road",
          city: "Dubai",
          state: "Dubai",
          zip: "12345",
          country: "UAE",
          lang: 55.2708,
          lat: 25.2048,
        ),
        carReviews: [],
        images: ["https://picsum.photos/400/200"],
        availabilities: [],
        owner: OwnerModel(
          id: 1,
          firstName: "John",
          lastName: "Doe",
          email: "john.doe@example.com",
        ),
        car_registration: ["https://picsum.photos/300/400"],
        car_insurance: ["https://picsum.photos/300/400"],
      ),
      CarModel(
        id: 2,
        brand: "BMW",
        model: "X5",
        color: "Black",
        matriculation: "AUH-456",
        year: 2023,
        seatsNumber: 7,
        price: 250.0,
        type: "SUV",
        status: "verified",
        address: Address(
          street: "Corniche Road",
          city: "Abu Dhabi",
          state: "Abu Dhabi",
          zip: "54321",
          country: "UAE",
          lang: 54.3667,
          lat: 24.4667,
        ),
        carReviews: [],
        images: ["https://picsum.photos/400/200"],
        availabilities: [],
        owner: OwnerModel(
          id: 2,
          firstName: "Sarah",
          lastName: "Smith",
          email: "sarah.smith@example.com",
        ),
        car_registration: ["https://picsum.photos/300/400"],
        car_insurance: ["https://picsum.photos/300/400"],
      ),
      CarModel(
        id: 3,
        brand: "Mercedes",
        model: "C-Class",
        color: "Silver",
        matriculation: "SHJ-789",
        year: 2023,
        seatsNumber: 5,
        price: 200.0,
        type: "Sedan",
        status: "pending",
        address: Address(
          street: "King Faisal Street",
          city: "Sharjah",
          state: "Sharjah",
          zip: "67890",
          country: "UAE",
          lang: 55.3915,
          lat: 25.3575,
        ),
        carReviews: [],
        images: ["https://picsum.photos/400/200"],
        availabilities: [],
        owner: OwnerModel(
          id: 3,
          firstName: "Ahmed",
          lastName: "Al",
          email: "ahmed.al@example.com",
        ),
        car_registration: null,
        car_insurance: ["https://picsum.photos/300/400"],
      ),
    ]);
  }

  List<UserModel> get verifiedUsers => _users.where((user) {
    return user.emirate_id_passport != null && 
           user.emirate_id_passport!.isNotEmpty &&
           user.driving_licence != null && 
           user.driving_licence!.isNotEmpty &&
           user.residence_proof != null && 
           user.residence_proof!.isNotEmpty;
  }).toList();

  List<UserModel> get unverifiedUsers => _users.where((user) {
    return user.emirate_id_passport == null || 
           user.emirate_id_passport!.isEmpty ||
           user.driving_licence == null || 
           user.driving_licence!.isEmpty ||
           user.residence_proof == null || 
           user.residence_proof!.isEmpty;
  }).toList();

  List<CarModel> get verifiedCars => _cars.where((car) => car.status == "verified").toList();
  List<CarModel> get unverifiedCars => _cars.where((car) => car.status == "pending").toList();

  void _verifyUser(int userId) {
    setState(() {
      final user = _users.firstWhere((u) => u.id == userId);
      user.emirate_id_passport ??= [];
      user.driving_licence ??= [];
      user.residence_proof ??= [];
      if (user.emirate_id_passport!.isEmpty) user.emirate_id_passport!.add("verified");
      if (user.driving_licence!.isEmpty) user.driving_licence!.add("verified");
      if (user.residence_proof!.isEmpty) user.residence_proof!.add("verified");
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User $userId verified successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _verifyCar(int carId) {
    setState(() {
      final car = _cars.firstWhere((c) => c.id == carId);
      car.status = "verified";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Car $carId verified successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _declineUser(int userId) {
    setState(() {
      final user = _users.firstWhere((u) => u.id == userId);
      user.emirate_id_passport = null;
      user.driving_licence = null;
      user.residence_proof = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User $userId declined'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _declineCar(int carId) {
    setState(() {
      final car = _cars.firstWhere((c) => c.id == carId);
      car.status = "declined";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Car $carId declined'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Row(
        children: [
          if (!isMobile)
            NavigationRail(
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard),
                  label: Text('Overview'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.people),
                  label: Text('Users'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.directions_car),
                  label: Text('Cars'),
                ),
              ],
            ),
          Expanded(
            child: _buildContent(isMobile),
          ),
        ],
      ),
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Overview',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.directions_car),
                  label: 'Cars',
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildContent(bool isMobile) {
    switch (_currentIndex) {
      case 0:
        return _buildOverview(isMobile);
      case 1:
        return _buildUsersSection(isMobile);
      case 2:
        return _buildCarsSection(isMobile);
      default:
        return _buildOverview(isMobile);
    }
  }

  Widget _buildOverview(bool isMobile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Statistics Cards
          GridView.count(
            crossAxisCount: isMobile ? 2 : 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _StatCard(
                title: 'Total Users',
                value: _users.length.toString(),
                icon: Icons.people,
                color: Colors.blue,
              ),
              _StatCard(
                title: 'Verified Users',
                value: verifiedUsers.length.toString(),
                icon: Icons.verified_user,
                color: Colors.green,
              ),
              _StatCard(
                title: 'Unverified Users',
                value: unverifiedUsers.length.toString(),
                icon: Icons.person_outline,
                color: Colors.orange,
              ),
              _StatCard(
                title: 'Total Cars',
                value: _cars.length.toString(),
                icon: Icons.directions_car,
                color: Colors.purple,
              ),
              _StatCard(
                title: 'Verified Cars',
                value: verifiedCars.length.toString(),
                icon: Icons.verified,
                color: Colors.green,
              ),
              _StatCard(
                title: 'Unverified Cars',
                value: unverifiedCars.length.toString(),
                icon: Icons.car_rental,
                color: Colors.orange,
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Quick Actions
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ActionChip(
                avatar: const Icon(Icons.person_add, color: Colors.white),
                label: const Text('Add User', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.blue,
                onPressed: () {},
              ),
              ActionChip(
                avatar: const Icon(Icons.car_rental, color: Colors.white),
                label: const Text('Add Car', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.orange,
                onPressed: () {},
              ),
              ActionChip(
                avatar: const Icon(Icons.settings, color: Colors.white),
                label: const Text('Settings', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.grey,
                onPressed: () {},
              ),
              ActionChip(
                avatar: const Icon(Icons.report, color: Colors.white),
                label: const Text('Reports', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.purple,
                onPressed: () {},
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Recent Activity
          const Text(
            'Recent Activity',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _ActivityItem(
                    icon: Icons.person,
                    title: 'New user registration',
                    subtitle: 'Ahmed Al registered 2 hours ago',
                    status: 'Pending',
                    statusColor: Colors.orange,
                  ),
                  const Divider(),
                  _ActivityItem(
                    icon: Icons.directions_car,
                    title: 'Car verification completed',
                    subtitle: 'BMW X5 was verified 1 hour ago',
                    status: 'Verified',
                    statusColor: Colors.green,
                  ),
                  const Divider(),
                  _ActivityItem(
                    icon: Icons.warning,
                    title: 'Document verification needed',
                    subtitle: 'Mercedes C-Class missing registration',
                    status: 'Action Required',
                    statusColor: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersSection(bool isMobile) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Material(
            color: Colors.white,
            child: TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'Unverified Users'),
                Tab(text: 'Verified Users'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildUserList(unverifiedUsers, false, isMobile),
                _buildUserList(verifiedUsers, true, isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList(List<UserModel> users, bool isVerified, bool isMobile) {
    if (users.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No users found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: Text(
                        '${user.firstName?[0]}${user.lastName?[0]}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.firstName} ${user.lastName}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(user.email ?? 'No email'),
                          Text(user.phone ?? 'No phone'),
                        ],
                      ),
                    ),
                    if (!isVerified)
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check_circle, color: Colors.green),
                            onPressed: () => _verifyUser(user.id!),
                            tooltip: 'Verify User',
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () => _declineUser(user.id!),
                            tooltip: 'Decline User',
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    _DocumentChip(
                      title: 'ID/Passport',
                      hasDocument: user.emirate_id_passport != null && user.emirate_id_passport!.isNotEmpty,
                    ),
                    _DocumentChip(
                      title: 'Driving License',
                      hasDocument: user.driving_licence != null && user.driving_licence!.isNotEmpty,
                    ),
                    _DocumentChip(
                      title: 'Residence Proof',
                      hasDocument: user.residence_proof != null && user.residence_proof!.isNotEmpty,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (!isMobile && !isVerified)
                  _buildDocumentViewer(user),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDocumentViewer(UserModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Uploaded Documents:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            if (user.emirate_id_passport != null && user.emirate_id_passport!.isNotEmpty)
              _DocumentButton(
                title: 'ID/Passport',
                urls: user.emirate_id_passport!,
              ),
            if (user.driving_licence != null && user.driving_licence!.isNotEmpty)
              _DocumentButton(
                title: 'Driving License',
                urls: user.driving_licence!,
              ),
            if (user.residence_proof != null && user.residence_proof!.isNotEmpty)
              _DocumentButton(
                title: 'Residence Proof',
                urls: user.residence_proof!,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildCarsSection(bool isMobile) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Material(
            color: Colors.white,
            child: TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'Unverified Cars'),
                Tab(text: 'Verified Cars'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildCarList(unverifiedCars, false, isMobile),
                _buildCarList(verifiedCars, true, isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarList(List<CarModel> cars, bool isVerified, bool isMobile) {
    if (cars.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_car_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No cars found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) {
        final car = cars[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(car.images?.first ?? 'https://picsum.photos/80/60'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${car.brand} ${car.model}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('${car.year} • ${car.color}'),
                          Text('AED ${car.price}/day'),
                          Text('Owner: ${car.owner?.firstName} ${car.owner?.lastName}'),
                        ],
                      ),
                    ),
                    if (!isVerified)
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check_circle, color: Colors.green),
                            onPressed: () => _verifyCar(car.id!),
                            tooltip: 'Verify Car',
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () => _declineCar(car.id!),
                            tooltip: 'Decline Car',
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      label: Text(car.status ?? 'Unknown', style: const TextStyle(color: Colors.white)),
                      backgroundColor: car.status == 'verified' ? Colors.green : Colors.orange,
                    ),
                    Chip(
                      label: Text(car.type ?? 'Unknown', style: const TextStyle(color: Colors.white)),
                      backgroundColor: Colors.blue,
                    ),
                    Chip(
                      label: Text('${car.seatsNumber} seats', style: const TextStyle(color: Colors.white)),
                      backgroundColor: Colors.purple,
                    ),
                    Chip(
                      label: Text(car.matriculation ?? 'No plate', style: const TextStyle(color: Colors.white)),
                      backgroundColor: Colors.teal,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (!isMobile && !isVerified)
                  _buildCarDocuments(car),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCarDocuments(CarModel car) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Car Documents:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            if (car.car_registration != null && car.car_registration!.isNotEmpty)
              _DocumentButton(
                title: 'Registration',
                urls: car.car_registration!,
              ),
            if (car.car_insurance != null && car.car_insurance!.isNotEmpty)
              _DocumentButton(
                title: 'Insurance',
                urls: car.car_insurance!,
              ),
            if ((car.car_registration == null || car.car_registration!.isEmpty) && 
                (car.car_insurance == null || car.car_insurance!.isEmpty))
              const Text(
                'No documents uploaded',
                style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
              ),
          ],
        ),
      ],
    );
  }
}

// Helper Widgets
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final Color statusColor;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: statusColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}

class _DocumentChip extends StatelessWidget {
  final String title;
  final bool hasDocument;

  const _DocumentChip({
    required this.title,
    required this.hasDocument,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(title, style: TextStyle(color: Colors.white)),
      backgroundColor: hasDocument ? Colors.green : Colors.red,
      avatar: Icon(
        hasDocument ? Icons.check : Icons.close,
        color: Colors.white,
        size: 16,
      ),
    );
  }
}

class _DocumentButton extends StatelessWidget {
  final String title;
  final List<String> urls;

  const _DocumentButton({
    required this.title,
    required this.urls,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: urls.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Image.network(
                      urls[index],
                      fit: BoxFit.cover,
                      height: 200,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[200],
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('Failed to load image'),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      icon: const Icon(Icons.visibility, size: 16),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[50],
        foregroundColor: Colors.blue,
      ),
    );
  }
}

// Data Models
class UserModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? uaeID;
  final String? email;
  final String? phone;
  final String? password;
  final String? image;
  final String? bankDetails;
  final List<Role?>? roles;
  final List<CarModel?>? cars;
  final List<OrderModel?>? orders;
  final List<String>? emirate_id_passport;
  final List<String>? driving_licence;
  final List<String>? residence_proof;
  final double? pointsBalance;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.uaeID,
    required this.email,
    required this.phone,
    required this.password,
    this.image,
    this.bankDetails,
    required this.roles,
    required this.cars,
    required this.orders,
    this.emirate_id_passport,
    this.driving_licence,
    this.residence_proof,
    this.pointsBalance,
  });
}

class Role {
  final int id;
  final String roleName;

  Role({
    required this.id,
    required this.roleName,
  });
}

class CarModel {
  final int? id;
  final String? brand;
  final String? model;
  final String? color;
  final String? matriculation;
  final int? year;
  final int? seatsNumber;
  final double? price;
  final List<String>? car_registration;
  final List<String>? car_insurance;
  final String? type;
  final String? status;
  final Address? address;
  final OwnerModel? owner;
  final List<AvailabilitieModel>? availabilities;
  final List<CarReviewsModel>? carReviews;
  final List<String>? images;
  final List<OrderModel?>? orders;

  CarModel({
    this.id,
    required this.brand,
    required this.model,
    required this.color,
    required this.matriculation,
    required this.year,
    required this.seatsNumber,
    required this.price,
    required this.type,
    required this.status,
    required this.address,
    required this.carReviews,
    required this.images,
    required this.availabilities,
    required this.owner,
    required this.car_registration,
    required this.car_insurance,
    this.orders,
  });
}

class Address {
  final int? id;
  final String? street;
  final String? city;
  final String? state;
  final String? zip;
  final String? country;
  final double? lang;
  final double? lat;

  Address({
    this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
    required this.lang,
    required this.lat,
  });
}

class OwnerModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  OwnerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}

class CarReviewsModel {
  final int? id;
  final int? rating;
  final String? comment;
  final String? reviewDate;
  final int? carId;
  final ReviewerModel? reviewer;
  final int? orderId;

  CarReviewsModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.reviewDate,
    required this.carId,
    required this.reviewer,
    required this.orderId,
  });
}

class ReviewerModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  ReviewerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}

class AvailabilitieModel {
  final int? id;
  final DateTime? startDate;
  final DateTime? endDate;

  AvailabilitieModel({
    required this.id,
    required this.startDate,
    required this.endDate,
  });
}

class OrderModel {
  // Order model properties would go here
}