import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';
import 'package:plants_buddy/features/community/domain/entities/community_post.dart';
import 'package:plants_buddy/features/community/domain/usecases/community_usecases.dart';

part 'add_community_post_event.dart';

part 'add_community_post_state.dart';

class AddCommunityPostBloc extends Bloc<AddCommunityPostEvent, AddCommunityPostState> {
  final AddCommunityPost _addCommunityPost;
  final UpdateCommunityPost _updateCommunityPost;

  AddCommunityPostBloc(CommunityPost? originalPost, this._addCommunityPost, this._updateCommunityPost)
      : super(originalPost == null ? AddCommunityPostState.create() : AddCommunityPostState.update(originalPost)) {
    on<AddCommunityPostPressed>(onCommunityAddPost);
    on<AddCommunityPostCategoryToggled>(onAddCommunityPostCategoryToggled);
    on<AddCommunityPostAttachImagePressed>(onAddCommunityPostAttachImagePressed);
    on<AddCommunityPostRemoveImagePressed>(onAddCommunityPostRemoveImagePressed);
    on<AddCommunityPostTitleChanged>(onAddCommunityPostTitleChanged);
    on<AddCommunityPostDescriptionChanged>(onAddCommunityPostDescriptionChanged);
    on<AddCommunityPostImageChanged>(onAddCommunityPostImageChanged);
  }

  Future<FutureOr<void>> onCommunityAddPost(AddCommunityPostPressed event, Emitter<AddCommunityPostState> emit) async {
    emit(state.copyWith(titleError: () => null, descriptionError: () => null, dialogShowing: true));

    try {
      if (state.originalPost == null) {
        await _addCommunityPost(
          title: state.title,
          description: state.description,
          category: state.category,
          imagePath: state.image,
        );
      } else {
        await _updateCommunityPost(
          postId: state.originalPost!.id,
          title: state.title,
          description: state.description,
          category: state.category,
          imagePath: state.image,
        );
      }

      emit(state.copyWith(dialogShowing: false));
    } on EmptyPostTitleException {
      emit(state.copyWith(titleError: () => 'Please fill this field', dialogShowing: false));
    } on EmptyPostDescriptionException {
      emit(state.copyWith(descriptionError: () => 'Please fill this field', dialogShowing: false));
    }
  }

  FutureOr<void> onAddCommunityPostCategoryToggled(
      AddCommunityPostCategoryToggled event, Emitter<AddCommunityPostState> emit) {
    emit(state.copyWith(category: () => state.category == event.category ? null : event.category));
  }

  Future<FutureOr<void>> onAddCommunityPostAttachImagePressed(
      AddCommunityPostAttachImagePressed event, Emitter<AddCommunityPostState> emit) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 40);

    emit(state.copyWith(image: () => File(image!.path).absolute.path));
  }

  FutureOr<void> onAddCommunityPostRemoveImagePressed(_, Emitter<AddCommunityPostState> emit) {
    emit(state.copyWith(image: () => null));
  }

  FutureOr<void> onAddCommunityPostTitleChanged(
      AddCommunityPostTitleChanged event, Emitter<AddCommunityPostState> emit) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> onAddCommunityPostDescriptionChanged(
      AddCommunityPostDescriptionChanged event, Emitter<AddCommunityPostState> emit) {
    emit(state.copyWith(description: event.description));
  }

  FutureOr<void> onAddCommunityPostImageChanged(
      AddCommunityPostImageChanged event, Emitter<AddCommunityPostState> emit) {
    emit(state.copyWith(image: () => event.image));
  }
}
