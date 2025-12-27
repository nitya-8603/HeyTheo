import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heytheo/models/dummy_stocks.dart';
import 'package:heytheo/pages/home_page/widgets/pagination.dart';
import 'package:heytheo/pages/home_page/widgets/stock_card.dart';
import '../../models/stock.dart';
import '../../services/auth_service.dart';
import '../../theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const int cardsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    final List<Stock> stocks = dummyStocks;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            'Stock Market Dashboard',
            style: TextStyle(fontSize: 30.sp),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => AuthService().signOut(),
          ),
        ],
      ),
      body: PaginationGrid(
        stocks: stocks,
      ), //stocks managed with pagination (10 per page)
    );
  }
}
