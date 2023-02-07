import 'package:amit_quiz/cubit/auth_cubit.dart';
import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:amit_quiz/config/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizDrawer extends StatelessWidget {
  const QuizDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 280,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange[100]),
              child: const BuildDrawerHeader(),
            ),
          ),
          const BuildDrawerListItem(
            leadingIcon: Icons.person,
            title: 'My Profile',
          ),
          const BuildDrawerListItemsDivider(),
          const BuildDrawerListItem(
            leadingIcon: Icons.person,
            title: 'Contact Us',
          ),
          const BuildDrawerListItemsDivider(),
          BuildDrawerListItem(
            leadingIcon: Icons.logout,
            title: 'Logout',
            onTap: () {
              context.read<AuthCubit>().signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.home,
                                    (Route<dynamic> route) => false);
            },
          ),
          const BuildDrawerListItemsDivider(),
        ],
      ),
    );
  }
}

class BuildDrawerHeader extends StatelessWidget {
  const BuildDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AuthSignedIn) {
          var image = state.user.image;
          return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.orange[100],
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  state.user.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ); 
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class BuildDrawerListItem extends StatelessWidget {
  final IconData leadingIcon;
  final String? title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? color;

  const BuildDrawerListItem({
    Key? key,
    required this.leadingIcon,
    this.title,
    this.trailing,
    this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? mainColor,
      ),
      title: Text(title ?? ''),
      trailing: trailing ??
          const Icon(
            Icons.arrow_right,
            color: mainColor,
          ),
      onTap: onTap,
    );
  }
}

class BuildDrawerListItemsDivider extends StatelessWidget {
  const BuildDrawerListItemsDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );
  }
}
