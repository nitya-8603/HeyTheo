import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heytheo/models/stock.dart';
import 'package:heytheo/theme/app_colors.dart';

class StockCard extends StatelessWidget {
  final Stock stock;
  const StockCard({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final isGain = stock.change >= 0;
    final changeColor = isGain ? AppColors.gain : AppColors.loss;

    // clamp font sizes so they are responsive
    double f(double base) => (base.sp).clamp(10, 20);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.cardBorder, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10.r,
            offset: Offset(0, 6.h),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  stock.symbol,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: f(18),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  stock.company,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: f(12),
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          _row(
            'Price',
            '\$${stock.price.toStringAsFixed(2)}',
            f: f,
            valueStyle: TextStyle(
              fontSize: f(18),
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 6.h),
          _row(
            'Change',
            '${stock.change >= 0 ? '+' : ''}${stock.change.toStringAsFixed(2)} '
                '(${stock.changePercent.toStringAsFixed(2)}%)',
            f: f,
            valueColor: changeColor,
          ),
          SizedBox(height: 6.h),
          _row(
            'Volume',
            stock.volume.toString(),
            f: f,
            valueColor: AppColors.volume,
          ),
          SizedBox(height: 6.h),
          _row(
            'Market Cap',
            '\$${stock.marketCap.toStringAsFixed(1)}B',
            f: f,
            valueColor: AppColors.marketCap,
          ),
        ],
      ),
    );
  }

  //Helper method to create a row with label and value
  Widget _row(
    String label,
    String value, {
    required double Function(double) f,
    Color? valueColor,
    TextStyle? valueStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: f(11), color: AppColors.textSecondary),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style:
                valueStyle ??
                TextStyle(
                  fontSize: f(12),
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? AppColors.textPrimary,
                ),
          ),
        ),
      ],
    );
  }
}
