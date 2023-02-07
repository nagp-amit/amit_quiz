import 'dart:io';
import 'package:amit_quiz/config/colors.dart';
import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/model/app_user.dart';
import 'package:amit_quiz/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../cubit/cubits.dart';

class ProfileScreen extends StatelessWidget {
   const ProfileScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return const ProfileScreen();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AuthSignedIn) {
          return ProfileBody(appUser: state.user);
        }
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}

class ProfileBody extends StatelessWidget {
  final AppUser appUser;
  const ProfileBody({super.key, required this.appUser});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditMyUserCubit(appUser),
      child:Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          backgroundColor: mainColor.shade800,
        ),
        body: BlocConsumer<EditMyUserCubit, EditMyUserState>(
          listener: (context, state) {
            if (state.isDone) {
              context.read<AuthCubit>().reloadUser();
              Navigator.of(context).pop();
            }
          },
          builder: (_, state) {
            return Stack(
              children: [
                _MyUserSection(
                  user: appUser,
                  pickedImage: state.pickedImage,
                  isSaving: state.isLoading,
                ),
                if (state.isLoading)
                  Container(
                    color: Colors.black12,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
      ));
  }
}

class _MyUserSection extends StatefulWidget {
  final AppUser? user;
  final File? pickedImage;
  final bool isSaving;

  const _MyUserSection({this.user, this.pickedImage, this.isSaving = false});

  @override
  _MyUserSectionState createState() => _MyUserSectionState();
}

class _MyUserSectionState extends State<_MyUserSection> {
  final _nameController = TextEditingController();

  final picker = ImagePicker();

  @override
  void initState() {
    _nameController.text = widget.user?.name ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                final editCubit = context.read<EditMyUserCubit>();
                final pickedImage =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  editCubit.setImage(File(pickedImage.path));
                }
              },
              child: Center(
                child: ClipOval(
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: CustomImage(
                      imageFile: widget.pickedImage,
                      imageUrl: widget.user?.image,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              key: const Key('Name'),
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8),

            // When isSaving is true we disable the button
            ElevatedButton(
              onPressed: widget.isSaving
                  ? null
                  : () {
                      context.read<EditMyUserCubit>().saveMyUser(
                            _nameController.text
                          );
                    },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
