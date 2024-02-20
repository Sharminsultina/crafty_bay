class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              searchTextField,
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  height: 210,
                  child: GetBuilder<HomeBannerController>(
                      builder: (homeBannerController) {
                        return Visibility(
                          visible: homeBannerController.inProgress == false,
                          replacement: const CenterCircularProgressIndicator(),
                          child: BannerCarousel(
                            bannerList:
                            homeBannerController.bannerListModel.bannerList ??
                                [],
                          ),
                        );
                      })),
              const SizedBox(
                height: 16,
              ),
              SectionTitle(
                title: "All Categories",
                onTapSeeAll: () {
                  Get.find<MainBottomNavController>().changeIndex(1);
                },
              ),
              categoryList,
              GetBuilder<BrandListController>(builder: (brandListController) {
                return SectionTitle(
                  title: "All Brands",
                  onTapSeeAll: () {
                    Get.to(
                      const BrandScreen(),
                    );
                  },
                );
              }),
              brandList,
              const SizedBox(
                height: 16,
              ),
              SectionTitle(
                title: "Popular",
                onTapSeeAll: () {
                  Get.to(
                    const ProductListScreen(),
                  );
                },
              ),
              GetBuilder<PopularProductController>(
                  builder: (popularProductController) {
                    return Visibility(
                      visible: popularProductController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: productList(
                        popularProductController.productListModel.productList ?? [],
                      ),
                    );
                  }),
              const SizedBox(
                height: 8,
              ),
              SectionTitle(
                title: "Special",
                onTapSeeAll: () {
                  Get.to(
                    const ProductListScreen(),
                  );
                },
              ),
              GetBuilder<SpecialProductController>(
                  builder: (specialProductController) {
                    return Visibility(
                      visible: specialProductController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: productList(
                        specialProductController.productListModel.productList ?? [],
                      ),
                    );
                  }),
              const SizedBox(
                height: 8,
              ),
              SectionTitle(
                title: "New",
                onTapSeeAll: () {
                  Get.to(
                    const ProductListScreen(),
                  );
                },
              ),
              GetBuilder<NewProductController>(builder: (newProductController) {
                return Visibility(
                  visible: newProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                    newProductController.productListModel.productList ?? [],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get categoryList {
    return SizedBox(
      height: 130,
      child: GetBuilder<CategoryController>(builder: (categoryController) {
        return Visibility(
          visible: categoryController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: ListView.separated(
            itemCount:
            categoryController.categoryListModel.categoryList?.length ?? 0,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoryItem(
                category:
                categoryController.categoryListModel.categoryList![index],
              );
            },
            separatorBuilder: (
                _,
                __,
                ) {
              return const SizedBox(
                width: 8,
              );
            },
          ),
        );
      }),
    );
  }

  SizedBox get brandList {
    return SizedBox(
      height: 130,
      child: GetBuilder<BrandListController>(builder: (brandListController) {
        return Visibility(
          visible: brandListController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: ListView.separated(
            itemCount: brandListController.branListModel.data?.length ?? 0,
            //brandListController.listProductByBrandModel.data?.length ?? 0,

            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return BrandItem(
                brandModel: brandListController.branListModel.data![index],
              );
            },
            separatorBuilder: (
                _,
                __,
                ) {
              return const SizedBox(
                width: 8,
              );
            },
          ),
        );
      }),
    );
  }

  SizedBox productList(List<ProductModel> productList) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        itemCount: productList.length,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductCardItem(
            product: productList[index],
          );
        },
        separatorBuilder: (
            _,
            __,
            ) {
          return const SizedBox(
            height: 8,
          );
        },
      ),
    );
  }

  SizedBox brandListItems(List<BrandModel> brandList) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        itemCount: brandList.length,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // return BrandCardItem(
          //     brand: brandList[index],
          //   //product: brandList[index],
          // );
          return BrandItem(brandModel: brandList.toList().first);
        },
        separatorBuilder: (
            _,
            __,
            ) {
          return const SizedBox(
            height: 8,
          );
        },
      ),
    );
  }
}

TextFormField get searchTextField {
  return TextFormField(
    decoration: InputDecoration(
      hintText: "Search",
      fillColor: Colors.grey.shade200,
      filled: true,
      prefixIcon: const Icon(
        Icons.search,
        color: Colors.grey,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

AppBar get appBar {
  return AppBar(
    title: Image.asset(AssetsPath.logoNav),
    actions: [
      CircleIconsButton(
        onTap: () {
          Get.to(() => const PolicyScreen());
        },
        iconData: Icons.policy,
      ),
      const SizedBox(
        width: 8,
      ),
      CircleIconsButton(
        onTap: () {},
        iconData: Icons.call,
      ),
      const SizedBox(
        width: 8,
      ),
      CircleIconsButton(
        onTap: () async {
          await AuthController.clearAuthData();
          Get.offAll(() => const VerifyEmailScreen());
        },
        iconData: Icons.logout_outlined,
      ),
      const SizedBox(
        width: 8,
      ),
      Padding(
        padding: const EdgeInsets.only(right: 8),
        child: CircleIconsButton(
          onTap: () {},
          iconData: Icons.notifications_active_outlined,
        ),
      ),
    ],
  );
}