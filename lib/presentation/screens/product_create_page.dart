import 'package:flutter/material.dart';
import 'package:shopping_mall_project/homepage/app_title.dart';
import 'package:shopping_mall_project/data/models/product_entity.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProductCreatePage extends StatefulWidget {
  @override
  State<ProductCreatePage> createState() => _ProductCreateState();
}

class _ProductCreateState extends State<ProductCreatePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return;

    setState(() {
      _selectedImage = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: ShopTitle(),
          leading: IconButton(
            icon: const Icon(Icons.chevron_left, size: 32),
            onPressed: () => Navigator.pop(context),
          ),
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 1),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: _selectedImage == null
                          ? const Center(
                              child: Text(
                                '이미지를 선택하세요',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 상품명 입력
                  Row(
                    children: [
                      const SizedBox(
                        width: 90,
                        child: Text(
                          '상품 등록',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // 상품 가격 입력
                  Row(
                    children: [
                      const SizedBox(
                        width: 90,
                        child: Text(
                          '상품 가격',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('원'),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 설명글 입력
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _descController,
                      maxLines: 9,
                      decoration: const InputDecoration(
                        hintText: '설명글을 작성하세요',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 등록 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        final name = _nameController.text.trim();
                        final priceText = _priceController.text.trim();
                        final desc = _descController.text.trim();

                        if (name.isEmpty || priceText.isEmpty) return;

                        final price = int.tryParse(priceText);
                        if (price == null) return;

                        final product = ProductEntity(
                          name: name,
                          price: price,
                          description: desc,
                          imagePath: _selectedImage?.path,
                          imageUrl: null,
                        );
                        Navigator.pop(context, product);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: const BorderSide(color: Colors.black, width: 1),
                      ),
                      child: const Text(
                        '등록하기',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import '../models/product.dart';

// class ProductCreatePage extends StatefulWidget {
//   const ProductCreatePage({super.key});

//   @override
//   State<ProductCreatePage> createState() => _ProductCreatePageState();
// }

// class _ProductCreatePageState extends State<ProductCreatePage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _descriptionController = TextEditingController();

//   String? _imagePath;
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _priceController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1024,
//         maxHeight: 1024,
//         imageQuality: 85,
//       );

//       if (image != null) {
//         setState(() {
//           _imagePath = image.path;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('이미지를 선택하는 중 오류가 발생했습니다: $e')));
//       }
//     }
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       final product = Product(
//         name: _nameController.text,
//         price: int.parse(_priceController.text),
//         imageUrl: _imagePath,
//         description: _descriptionController.text.isEmpty
//             ? null
//             : _descriptionController.text,
//       );

//       Navigator.pop(context, product);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       // 화면 터치 시 키보드 숨기기
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white, // 흰색 배경
//         appBar: AppBar(
//           title: const Text('상품 등록'),
//           elevation: 0,
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black87,
//         ),
//         body: Form(
//           key: _formKey,
//           child: ListView(
//             padding: const EdgeInsets.all(20),
//             keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//             children: [
//               // 이미지 선택
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Container(
//                   height: 200,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey[400]!, width: 2),
//                   ),
//                   child: _imagePath == null
//                       ? Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.add_photo_alternate,
//                               size: 60,
//                               color: Colors.grey[600],
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               '이미지를 선택하세요',
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         )
//                       : ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.file(
//                             File(_imagePath!),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // 상품명 입력
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(
//                   labelText: '상품명',
//                   hintText: '상품명을 입력하세요',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.shopping_bag),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return '상품명을 입력해주세요';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // 가격 입력
//               TextFormField(
//                 controller: _priceController,
//                 decoration: const InputDecoration(
//                   labelText: '가격',
//                   hintText: '가격을 입력하세요',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.attach_money),
//                   suffixText: '원',
//                 ),
//                 keyboardType: TextInputType.number,
//                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return '가격을 입력해주세요';
//                   }
//                   final price = int.tryParse(value);
//                   if (price == null || price < 0) {
//                     return '올바른 가격을 입력해주세요';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),

//               // 설명 입력
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: const InputDecoration(
//                   labelText: '상품 설명 (선택)',
//                   hintText: '상품 설명을 입력하세요',
//                   border: OutlineInputBorder(),
//                   alignLabelWithHint: true,
//                 ),
//                 maxLines: 5,
//                 maxLength: 500,
//               ),
//               const SizedBox(height: 24),

//               // 등록 버튼
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   '상품 등록',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               // 키보드가 나타날 때를 위한 추가 여백
//               const SizedBox(height: 100),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
