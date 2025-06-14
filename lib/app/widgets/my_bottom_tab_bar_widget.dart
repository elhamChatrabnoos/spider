import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyBottomTabBarWidget extends StatelessWidget {
  const MyBottomTabBarWidget(
      {super.key, required this.currentIndex, required this.ontapNavItem});

  final int currentIndex;
  final Function(int) ontapNavItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(1, 1),
            spreadRadius: 2,
            color:
                Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.2),
          )
        ],
      ),
      child: Row(children: [
        const SizedBox(width: 24),
        Expanded(
          child: TabBarItemWidget(
            isSelected: currentIndex == 0,
            iconData: Icons.home,
            onTap: ontapNavItem(0),
            title: 'home',
          ),
        ),
        Expanded(
          child: TabBarItemWidget(
            isSelected: currentIndex == 1,
            onTap: ontapNavItem(1),
            title: '',
            iconData: Icons.account_balance_wallet,
            // assetName: AppAssets.compassIcon,
          ),
        ),
        Expanded(
          child: TabBarItemWidget(
            isSelected: currentIndex == 2,
            onTap: ontapNavItem(2),
            iconData: Icons.account_tree_rounded,
            title: '',
            // assetName: AppAssets.shoppingIcon,
          ),
        ),
        Expanded(
          child: TabBarItemWidget(
            isSelected: currentIndex == 3,
            onTap: ontapNavItem(3),
            iconData: Icons.person,
            title: '',
            // assetName: AppAssets.chatIcon,
          ),
        ),
        const SizedBox(width: 24),
      ]),
    );
  }
}

class TabBarItemWidget extends StatelessWidget {
  const TabBarItemWidget({
    super.key,
    required this.title,
    required this.isSelected,
    this.iconData,
    this.assetName,
    required this.onTap,
  });

  final String title;
  final IconData? iconData;
  final String? assetName;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 44,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(22),
            ),
            child: assetName != null
                ? Center(
                    child: SvgPicture.asset(
                      assetName!,
                      colorFilter: ColorFilter.mode(
                        isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : Icon(
                    iconData,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : const Color(0xFFBDBDBD),
                  ),
          ),
          isSelected
              ? Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    width: 15,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
