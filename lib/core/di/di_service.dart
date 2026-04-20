import 'package:get_it/get_it.dart';
import 'package:grocery2/features/payment_success/data/datasource/remote_datasource/payment_details_datasource.dart';
import 'package:grocery2/features/payment_success/data/repository/payment_details_repo.dart';
import 'package:grocery2/features/payment_success/presentation/logic/payment_details_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {

  /// DataSources
  sl.registerLazySingleton<BasePaymentDetailsDatasource>(
    () => PaymentDetailsDatasource(),
  );


  /// Repositories
  sl.registerLazySingleton<BasePaymentDetailsRepo>(()=> PaymentDetailsRepo(sl()));


  /// Cubits
  sl.registerFactory<PaymentDetailsCubit>( ()=> PaymentDetailsCubit(sl()) );
}
