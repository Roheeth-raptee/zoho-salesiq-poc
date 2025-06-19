import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:salesiq_mobilisten/launcher.dart';
import 'package:salesiq_mobilisten/salesiq_mobilisten.dart';

import 'keys.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  void initState() {
    super.initState();

    if (Platform.isIOS || Platform.isAndroid) {
      ZohoSalesIQ.init(ZohoKeys.App_key, ZohoKeys.Access_key).then((_) {
        ZohoSalesIQ.launcher.enableDragToDismiss(true);
      }).catchError((error) {
        log('SalesIQ Init Error: $error');
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ZohoSalesIQ.launcher.show(VisibilityMode.whenActiveChat);
  }

  @override
  void dispose() {
    ZohoSalesIQ.launcher.show(VisibilityMode.never);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final issues = [
      {
        'title': 'Battery / Charge',
        'desc': 'Bike battery life and essential maintenance.',
      },
      {
        'title': 'Bike / Motor',
        'desc': 'Address common bike functionality & performance issues.',
      },
      {
        'title': 'App',
        'desc': 'Resolve app functionality and performance concerns efficiently.',
      },
      {
        'title': 'Display',
        'desc': 'Display functionality & performance issues.',
      },
      {
        'title': 'Key fob',
        'desc': 'Key fob functionality & performance issues.',
      },
      {
        'title': 'Others',
        'desc': 'Please specify your bike\'s concerns or issues to help us assist you effectively.',
      },
    ];

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        // ZohoSalesIQ.launcher.show(VisibilityMode.never);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hi, How can we assist you today?',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 32),
              const Text(
                'Choose an Issue',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemCount: issues.length,
                  itemBuilder: (context, index) {
                    final issue = issues[index];
                    return InkWell(
                      onTap: () {
                        ZohoSalesIQ.openNewChat();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              issue['title']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: Text(
                                issue['desc']!,
                                style: const TextStyle(fontSize: 13, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
