import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/di/provider.dart';
import '../../data/datasources/community_remote_datasource.dart';
import '../../data/datasources/community_remote_datasource_impl.dart';
import '../../data/repository_impl/community_repository_impl.dart';
import '../../domain/repositories/community_repository.dart';
import '../../domain/usecases/create_post_usecase.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../domain/usecases/create_comment_usecase.dart';
import '../../domain/usecases/like_post_usecase.dart';

// DataSource Provider
final communityRemoteDataSourceProvider =
    Provider<CommunityRemoteDataSource>((ref) {
  return CommunityRemoteDataSourceImpl(
    client: ref.read(httpClientProvider),
    source: ref.read(authLocalDataSourceProvider),
    baseUrl: BASE_URL,
  );
});

// Repository Provider
final communityRepositoryProvider = Provider<CommunityRepository>((ref) {
  final remoteDataSource = ref.watch(communityRemoteDataSourceProvider);
  return CommunityRepositoryImpl(remoteDataSource: remoteDataSource);
});

// UseCase Providers
final createPostUseCaseProvider = Provider<CreatePostUseCase>((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return CreatePostUseCase(repository: repository);
});

final getPostsUseCaseProvider = Provider<GetPostsUseCase>((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return GetPostsUseCase(repository: repository);
});

final createCommentUseCaseProvider = Provider<CreateCommentUseCase>((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return CreateCommentUseCase(repository: repository);
});

final likePostUseCaseProvider = Provider<LikePostUseCase>((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return LikePostUseCase(repository: repository);
});
