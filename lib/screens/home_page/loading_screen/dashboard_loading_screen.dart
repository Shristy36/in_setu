import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';

class DashboardLoadingScreen extends StatelessWidget {
  const DashboardLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSliderPlaceholder(),
          const SizedBox(height: 20),
          _buildMaterialSectionPlaceholder(),
          const SizedBox(height: 20),
          _buildSiteTeamSectionPlaceholder(),
          const SizedBox(height: 20),
          _buildSitePlansSectionPlaceholder(context),
          const SizedBox(height: 20),
          _buildManPowerListPlaceholder(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildImageSliderPlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.colorLightGray,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildMaterialSectionPlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 24,
          color: AppColors.colorLightGray,
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 70,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: _buildMaterialCardPlaceholder(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMaterialCardPlaceholder() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 150,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: AppColors.colorGray,width: 1)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 12,
                        color: AppColors.colorLightGray,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 40,
                        height: 12,
                        color: AppColors.colorLightGray,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSiteTeamSectionPlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              height: 24,
              color: AppColors.colorLightGray,
            ),
            Container(
              width: 120,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.colorLightGray,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.colorLightGray,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 80,
                      height: 12,
                      color: AppColors.colorLightGray,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSitePlansSectionPlaceholder(BuildContext context) {
    // Get screen size and calculate responsive values
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : screenWidth < 900 ? 3 : 4;
    final placeholderHeight = screenWidth < 600 ? 170.0 : 200.0;
    final titleWidth = screenWidth < 600 ? 100.0 : 120.0;
    final titleHeight = screenWidth < 600 ? 24.0 : 28.0;
    final subtitleWidth = screenWidth < 600 ? 80.0 : 100.0;
    final subtitleHeight = screenWidth < 600 ? 12.0 : 14.0;
    final padding = screenWidth < 600 ? 12.0 : 16.0;
    final spacing = screenWidth < 600 ? 10.0 : 12.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: titleWidth,
          height: titleHeight,
          decoration: BoxDecoration(
            color: AppColors.colorLightGray,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: spacing),
        GridView.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: 0.75,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: spacing * 2),
          children: List.generate(crossAxisCount * 2, (index) { // Show 2 rows of placeholders
            return Card(
              color: AppColors.colorWhite,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: placeholderHeight,
                      decoration: BoxDecoration(
                        color: AppColors.colorLightGray,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    SizedBox(height: spacing / 2),
                    Container(
                      width: subtitleWidth,
                      height: subtitleHeight,
                      decoration: BoxDecoration(
                        color: AppColors.colorLightGray,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildManPowerListPlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 24,
          color: AppColors.colorLightGray,
        ),
        const SizedBox(height: 10),
        _buildProjectsListPlaceholder(),
      ],
    );
  }

  Widget _buildProjectsListPlaceholder() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 100),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          return _buildProjectCardPlaceholder();
        },
      ),
    );
  }

  Widget _buildProjectCardPlaceholder() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5, right: 8, top: 8),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Container(
                  width: 100,
                  height: 20,
                  color: AppColors.colorLightGray,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionPlaceholder('Staff', 2),
                const SizedBox(height: 2),
                _buildSectionPlaceholder('Manpower', 1),
                const SizedBox(height: 2),
                _buildSectionPlaceholder('Task', 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionPlaceholder(String title, int itemCount) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 16,
            color: AppColors.colorLightGray,
          ),
          const SizedBox(height: 2),
          ...List.generate(itemCount, (index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColors.colorLightGray,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 2),
                  Container(
                    width: 20,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 16,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}