import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heytheo/pages/home_page/home_page.dart';
import 'package:heytheo/pages/home_page/widgets/stock_card.dart';
import '../../../models/stock.dart';
import '../../../theme/app_colors.dart';

class PaginationGrid extends StatefulWidget {
  final List<Stock> stocks;
  const PaginationGrid({required this.stocks, super.key});

  @override
  State<PaginationGrid> createState() => _PaginationGridState();
}

class _PaginationGridState extends State<PaginationGrid> {
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    //calculate total pages
    final totalPages = (widget.stocks.length / HomePage.cardsPerPage).ceil();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        //determine number of columns based on screen width
        int crossAxisCount;
        if (width >= 1024) {
          crossAxisCount = 5;
        } else if (width >= 800) {
          crossAxisCount = 4;
        } else if (width >= 600) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 2;
        }
        //calculate visible stocks for current page
        final start = (_currentPage - 1) * HomePage.cardsPerPage;
        final end = (start + HomePage.cardsPerPage) > widget.stocks.length
            ? widget.stocks.length
            : (start + HomePage.cardsPerPage);
        final visible = widget.stocks.sublist(start, end);

        return Column(
          children: [
            SizedBox(height: 16.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GridView.builder(
                  itemCount: visible.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 1.55,
                  ),
                  itemBuilder: (_, index) =>
                      StockCard(stock: visible[index]), //stock card widget
                ),
              ),
            ),
            _PaginationControls(
              currentPage: _currentPage,
              totalPages: totalPages,
              onPrevious: _currentPage > 1
                  ? () => setState(() => _currentPage--)
                  : null,
              onNext: _currentPage < totalPages
                  ? () => setState(() => _currentPage++)
                  : null,
            ), //pagination controls widgets
          ],
        );
      },
    );
  }
}

class _PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const _PaginationControls({
    required this.currentPage,
    required this.totalPages,
    this.onPrevious,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textPrimary,
              ),
              onPressed: onPrevious,
              child: Text(
                'Previous',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.font,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.cardBorder,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'Page $currentPage of $totalPages',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
            ),
          ),
          SizedBox(width: 12.w),
          SizedBox(
            height: 40.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textPrimary,
              ),
              onPressed: onNext,
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.font,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
