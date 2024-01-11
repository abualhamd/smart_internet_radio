import 'package:dartz/dartz.dart';

import '../../../app/core/errors/failures.dart';
import '../../../app/core/usecases/use_case.dart';
import '../../../app/core/utils/enums.dart';
import '../../entities/channel.dart';
import '../../repositories/channel_repo.dart';

class GetCategoriesUsecase
    implements UseCase<Map<Categories, List<Channel>>, NoParams> {
  GetCategoriesUsecase({required ChannelRepo channelRepo})
      : _channelRepo = channelRepo;
  final ChannelRepo _channelRepo;

  @override
  Future<Either<Failure, Map<Categories, List<Channel>>>> call(params) async {
    return await _channelRepo.getCategories();
  }
}
