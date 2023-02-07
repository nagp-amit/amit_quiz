// Extends Cubit and will emit states of type EditMyUserState
import 'dart:io';

import 'package:amit_quiz/model/app_user.dart';
import 'package:amit_quiz/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';

class EditMyUserCubit extends Cubit<EditMyUserState> {
  // Get the injected MyUserRepository
  final AuthRepositoryBase _authRepository = getIt();

  late AppUser _toEdit;

  EditMyUserCubit(this._toEdit) : super(const EditMyUserState());

  void setImage(File? imageFile) async {
    emit(state.copyWith(pickedImage: imageFile));
  }


  Future<void> saveMyUser(
    String name
  ) async {
    emit(state.copyWith(isLoading: true));

    final uid = _toEdit.id;
    _toEdit = AppUser(
        id: uid,
        name: name,
        email: '',
        image: _toEdit.image);

    await _authRepository.updateUser(name: name, image: state.pickedImage);
    emit(state.copyWith(isDone: true));
  }
}

class EditMyUserState extends Equatable {
  final File? pickedImage;
  final bool isLoading;

  // In the presentation layer, we will check the value of isDone.
  // When it is true, we will navigate to the previous page
  final bool isDone;

  const EditMyUserState({
    this.pickedImage,
    this.isLoading = false,
    this.isDone = false,
  });

  @override
  List<Object?> get props => [pickedImage?.path, isLoading, isDone];

  // Helper function that updates some properties of this object,
  // and returns a new updated instance of EditMyUserState
  EditMyUserState copyWith({
    File? pickedImage,
    bool? isLoading,
    bool? isDone,
  }) {
    return EditMyUserState(
      pickedImage: pickedImage ?? this.pickedImage,
      isLoading: isLoading ?? this.isLoading,
      isDone: isDone ?? this.isDone,
    );
  }
}
