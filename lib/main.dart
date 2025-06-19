import 'dart:developer';
import 'dart:io' as io;
import 'package:sales_iq/keys.dart';
import 'package:sales_iq/support.dart';
import 'package:salesiq_mobilisten/launcher.dart';
import 'package:salesiq_mobilisten/salesiq_mobilisten.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "sales_iq",
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final quote = "The only way to do great work is to love what you do.";
  final author = "Steve Jobs";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 70,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            const Text(
              "Hi Rider 👋",
              style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              "Choose a service for your bike",
              style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.support_agent, color: Colors.teal),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return SupportScreen();
              },));
            }
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            // Service Categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _serviceCard("Oil", Icons.oil_barrel_outlined),
                _serviceCard("Repair", Icons.build_circle_outlined),
                _serviceCard("Wash", Icons.local_car_wash_outlined),
              ],
            ),

            const SizedBox(height: 32),

            // Garage List
            const Text(
              "Nearby Garages",
              style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => _garageCard(index),
              ),
            ),

            const SizedBox(height: 32),

            // Book Button

            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.calendar_today, color: Colors.black,),
                label: const Text("Book Appointment"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 14),
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            StreamBuilder(stream: ZohoSalesIQ.eventChannel, builder: (context, snapshot) {
              if(snapshot.hasData){
                print(snapshot.data);
                return Text(snapshot.data.toString(), style: TextStyle(color: Colors.white),);
              }
              return SizedBox.shrink();
            },)
          ],
        ),
      ),
    );
  }

  Widget _serviceCard(String label, IconData icon) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.teal),
          const SizedBox(height: 12),
          Text(
              label, style: const TextStyle(fontSize: 14, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _garageCard(int index) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16)),
              color: Colors.grey.shade800,
            ),
            child: const Center(child: Icon(
                Icons.home_repair_service, size: 40, color: Colors.teal)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Garage 1", style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 4),
                Text("Open until 8PM",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
