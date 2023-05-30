import 'package:dartz/dartz.dart';
import 'package:smart_internet_radio/domain/entities/channel.dart';
import 'package:smart_internet_radio/domain/repositories/channel_repo.dart';

import '../../../app/core/errors/failures.dart';
import '../../../app/core/usecases/use_case.dart';
import '../../../app/core/utils/enums.dart';

class GetCategoryUsecase implements UseCase< Map<Categories, List<Channel>> , NoParams> {
  GetCategoryUsecase({required ChannelRepo channelRepo})
      : _channelRepo = channelRepo;
  final ChannelRepo _channelRepo;

  @override
  Future<Either<Failure, Map<Categories, List<Channel>>>> call(params) async {
    return await _channelRepo.getCategories();
  }
}
