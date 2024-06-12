import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  int _currentIndex = 0;
  //static ProductController controller = Get.put(ProductController());

  static List poster = [
    {'image': 'https://cdn.tgdd.vn/hoi-dap/1432090/top-10-dien-thoai-sieu-khuyen-mai-dang-mong-cho-tai-the(1).jpg'},
    {'image': 'https://cdn.tgdd.vn/hoi-dap/1432090/top-10-dien-thoai-sieu-khuyen-mai-dang-mong-cho-tai-the(2).jpg'},
    {'image': 'https://cdn.tgdd.vn/hoi-dap/1432090/top-10-dien-thoai-sieu-khuyen-mai-dang-mong-cho-tai-the(3).jpg'},
    {'image': 'https://cdn.tgdd.vn/hoi-dap/1432090/top-10-dien-thoai-sieu-khuyen-mai-dang-mong-cho-tai-the%20(9).jpg'},
    {'image': 'https://cdn.tgdd.vn/hoi-dap/1432090/top-10-dien-thoai-sieu-khuyen-mai-dang-mong-cho-tai-the(27).jpg'}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: 150,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 2.0,
                initialPage: 2,
                //scrollDirection: Axis.vertical,
                onPageChanged: (index, reason) {
                  setState(
                        () {
                      _currentIndex = index;
                    },
                  );
                },
              ),
              items: poster
                  .map(
                    (item) => Padding(
                  padding: const EdgeInsets.all(0),
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    elevation: 0,
                    shadowColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(3.0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                            item['image'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: poster.map((urlOfItem) {
                int index = poster.indexOf(urlOfItem);
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? const Color.fromRGBO(0, 0, 0, 0.8)
                        : const Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                );
              }).toList(),
            )
          ],
      ),
    );
  }
}
