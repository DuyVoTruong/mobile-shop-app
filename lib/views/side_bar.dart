import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';

class SideBar extends StatelessWidget {

  const SideBar({super.key});

  static UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          controller.userAuth.value == null
              ? const Text('')
              : UserAccountsDrawerHeader(
                  accountName: Text(controller.user.value?.ten.toString()??''),
                  accountEmail: Text(controller.userAuth.value!.email.toString()),
                  currentAccountPicture: ClipOval(
                    child: Image.network(
                      'https://media.istockphoto.com/id/1209654046/vector/user-avatar-profile-icon-black-vector-illustration.jpg?s=612x612&w=0&k=20&c=EOYXACjtZmZQ5IsZ0UUp1iNmZ9q2xl1BD1VvN6tZ2UI=',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://bizweb.dktcdn.net/100/330/208/files/1-fa87cc17-be4f-4401-aff8-3ca242455dce.jpg?v=1641740697172'),
                        fit: BoxFit.cover,
                      )),
                ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: (){
              Get.toNamed(AppRoutes.favorite);
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Account'),
            onTap: (){
              Get.toNamed(AppRoutes.updateAccount);
            },
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: const Text('Reset password'),
            onTap: (){
              Get.toNamed(AppRoutes.forgotPassword);
            },
          ),
          const Divider(),
          controller.userAuth.value == null
              ? ListTile(
                  leading: const Icon(Icons.login_outlined),
                  title: const Text('Log in'),
                  onTap: () {
                    Get.toNamed(AppRoutes.login);
                  },
                )
              : ListTile(
                  leading: const Icon(Icons.exit_to_app_outlined),
                  title: const Text('Log out'),
                  onTap: () {
                    controller.logout();
                    Get.toNamed(AppRoutes.login);
                  },
                ),
        ],
      ),
    ));
  }
}
