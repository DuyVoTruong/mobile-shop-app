import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';

class SideBar extends StatelessWidget {

  static UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    controller.user.value!=null
        ?controller.getUserByEmail(controller.user.value!.email.toString())
        :null;
    return Obx(()=> Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          controller.user.value == null
              ? Text('')
              : UserAccountsDrawerHeader(
                  accountName: Text(controller!.userByEmail.toString()),
                  accountEmail: Text(controller.user.value!.email.toString()),
                  currentAccountPicture: ClipOval(
                    child: Image.network(
                      'https://media.istockphoto.com/id/1209654046/vector/user-avatar-profile-icon-black-vector-illustration.jpg?s=612x612&w=0&k=20&c=EOYXACjtZmZQ5IsZ0UUp1iNmZ9q2xl1BD1VvN6tZ2UI=',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://bizweb.dktcdn.net/100/330/208/files/1-fa87cc17-be4f-4401-aff8-3ca242455dce.jpg?v=1641740697172'),
                        fit: BoxFit.cover,
                      )),
                ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Account'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Verify'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setting'),
            onTap: () => null,
          ),
          Divider(),
          controller.user.value == null
              ? ListTile(
                  leading: Icon(Icons.login_outlined),
                  title: Text('Log in'),
                  onTap: () {
                    Get.toNamed(AppRoutes.login);
                  },
                )
              : ListTile(
                  leading: Icon(Icons.exit_to_app_outlined),
                  title: Text('Log out'),
                  onTap: () {
                    controller.logout();
                    //Get.toNamed(AppRoutes.login);
                  },
                ),
        ],
      ),
    ));
  }
}
