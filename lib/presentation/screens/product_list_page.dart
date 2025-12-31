import 'package:flutter/material.dart';
import 'package:shopping_mall_project/data/models/product_entity.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required this.products,
    required this.onItemTap,
  });

  final List<ProductEntity> products;
  final void Function(ProductEntity product) onItemTap;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('상품을 등록해주세요'));
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
      itemCount: products.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 32, thickness: 1, color: Colors.black),
      itemBuilder: (context, index) {
        final p = products[index];
        return ProductListTile(product: p, onTap: () => onItemTap(p));
      },
    );
  }
}

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    super.key,
    required this.product,
    required this.onTap,
  });

  final ProductEntity product;
  final VoidCallback onTap;

  String formatPrice(int price) {
    final formatter = NumberFormat('#,###');
    return '${formatter.format(price)}원';
  }

  Widget _buildProductImage(ProductEntity product) {
    // 1) 로컬 이미지가 있으면 파일로 표시
    if (product.imagePath != null && product.imagePath!.isNotEmpty) {
      final file = File(product.imagePath!);
      return Image.file(file, fit: BoxFit.cover);
    }

    // 2) 네트워크 이미지가 있으면 네트워크로 표시
    if (product.imageUrl != null && product.imageUrl!.isNotEmpty) {
      return Image.network(product.imageUrl!, fit: BoxFit.cover);
    }

    // 3) 아무것도 없으면 placeholder
    return const Center(
      child: Text('이미지', style: TextStyle(color: Colors.black38)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 110,
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(28),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: _buildProductImage(product),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      product.description.isEmpty
                          ? '상품 설명글'
                          : product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.only(top: 110),
              child: Text(
                formatPrice(product.price),
                // '${product.price}원',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../models/product.dart';
// import '../widgets/product_card.dart';
// import 'product_detail_page.dart';
// import 'product_create_page.dart';

// class ProductListPage extends StatefulWidget {
//   const ProductListPage({super.key});

//   @override
//   State<ProductListPage> createState() => _ProductListPageState();
// }

// class _ProductListPageState extends State<ProductListPage> {
//   // 임시 상품 데이터 (실제로는 API나 데이터베이스에서 가져옴)
//   List<Product> products = [
//     const Product(
//       name: '아이폰 15 Pro 케이스',
//       price: 35000,
//       imageUrl: 'https://picsum.photos/300/300?random=1', //랜덤으로이미지띄움
//       description: '고급스러운 가죽 케이스',
//     ),
//     const Product(
//       name: '갤럭시 S24 케이스',
//       price: 25000,
//       imageUrl: 'https://picsum.photos/300/300?random=2',
//       description: '튼튼한 실리콘 케이스',
//     ),
//     const Product(
//       name: '맥북 프로 파우치',
//       price: 0,
//       imageUrl: 'https://picsum.photos/300/300?random=3',
//       description: '무료 증정 이벤트',
//     ),
//     const Product(
//       name: '에어팟 케이스',
//       price: 15000,
//       imageUrl: 'https://picsum.photos/300/300?random=4',
//       description: '귀여운 캐릭터 디자인',
//     ),
//     const Product(
//       name: '아이패드 커버',
//       price: 45000,
//       imageUrl: 'https://picsum.photos/300/300?random=5',
//       description: '스탠드 기능 포함',
//     ),
//   ];

//   void _navigateToDetail(Product product, int index) async {
//     final shouldDelete = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ProductDetailPage(product: product),
//       ),
//     );

//     // 상품 상세 페이지에서 삭제를 선택한 경우
//     if (shouldDelete == true) {
//       setState(() {
//         products.removeAt(index);
//       });
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('${product.name}이(가) 삭제되었습니다.'),
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       }
//     }
//   }

//   void _navigateToCreate() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const ProductCreatePage()),
//     );

//     // 상품 등록 페이지에서 돌아올 때 새 상품이 있으면 추가
//     if (result != null && result is Product) {
//       setState(() {
//         products.add(result);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // 흰색 배경
//       appBar: AppBar(
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(width: 8),
//             const Text(
//               'CaseShop',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//             ),
//           ],
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black87,
//       ),
//       body: SafeArea(
//         child: products.isEmpty
//             ? const Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.inbox, size: 80, color: Colors.grey),
//                     SizedBox(height: 16),
//                     Text(
//                       '상품이 없습니다.',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       '하단의 + 버튼을 눌러 상품을 등록해보세요.',
//                       style: TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               )
//             : ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   final product = products[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 12),
//                     child: ProductCard(
//                       product: product,
//                       onTap: () => _navigateToDetail(product, index),
//                     ),
//                   );
//                 },
//               ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _navigateToCreate,
//         tooltip: '상품 등록',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
