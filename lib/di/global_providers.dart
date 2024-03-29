import 'package:ddnc_new/repositories/committee_repository.dart';
import 'package:ddnc_new/repositories/notification_repository.dart';
import 'package:ddnc_new/repositories/schedule_repository.dart';
import 'package:ddnc_new/repositories/topic_proposal_repository.dart';
import 'package:ddnc_new/repositories/topic_repository.dart';
import 'package:ddnc_new/repositories/user_repository.dart';
import 'package:ddnc_new/ui/data/account.dart';
import 'package:ddnc_new/ui/data/app_configs.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../api/api_client.dart';
import '../api/api_service.dart';
import '../repositories/account_repository.dart';

List<SingleChildWidget> globalProviders = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: ApiClient()),
  ChangeNotifierProvider(create: (_) => AppConfigs()),
  ChangeNotifierProvider(create: (_) => AccountInfo()),
];

List<SingleChildWidget> dependentServices = [
  // Network
  ProxyProvider<ApiClient, ApiService>(
    create: (context) => ApiService.create(client: ApiClient.of(context)),
    update: (context, apiClient, apiService) =>
        apiService ?? ApiService.create(client: apiClient),
    dispose: (context, apiService) => apiService.client.dispose(),
  ),
  // Repositories
  ProxyProvider3<ApiService, AccountInfo, AppConfigs, AccountRepository>(
    create: (context) => AccountRepository(
      apiService: ApiService.of(context),
      account: AccountInfo.of(context),
      appConfigs: AppConfigs.of(context),
    ),
    update: (_, apiService, account, appConfigs, accountRepository) =>
        accountRepository ??
        AccountRepository(
          apiService: apiService,
          account: account,
          appConfigs: appConfigs,
        ),
  ),
  ProxyProvider2<ApiService, AccountInfo, UserRepository>(
    create: (context) => UserRepository(
      apiService: ApiService.of(context),
      accountInfo: AccountInfo.of(context),
    ),
    update: (_, apiService, accountInfo, userRepository) =>
        userRepository ??
        UserRepository(
          apiService: apiService,
          accountInfo: accountInfo,
        ),
  ),
  ProxyProvider2<ApiService, AccountInfo, TopicRepository>(
    create: (context) => TopicRepository(
      apiService: ApiService.of(context),
      accountInfo: AccountInfo.of(context),
    ),
    update: (_, apiService, accountInfo, topicRepository) =>
        topicRepository ??
        TopicRepository(
          apiService: apiService,
          accountInfo: accountInfo,
        ),
  ),
  ProxyProvider2<ApiService, AccountInfo, TopicProposalRepository>(
    create: (context) => TopicProposalRepository(
      apiService: ApiService.of(context),
      accountInfo: AccountInfo.of(context),
    ),
    update: (_, apiService, accountInfo, topicRepository) =>
        topicRepository ??
        TopicProposalRepository(
          apiService: apiService,
          accountInfo: accountInfo,
        ),
  ),
  ProxyProvider2<ApiService, AccountInfo, ScheduleRepository>(
    create: (context) => ScheduleRepository(
      apiService: ApiService.of(context),
      accountInfo: AccountInfo.of(context),
    ),
    update: (_, apiService, accountInfo, scheduleRepository) =>
        scheduleRepository ??
        ScheduleRepository(
          apiService: apiService,
          accountInfo: accountInfo,
        ),
  ),
  ProxyProvider2<ApiService, AccountInfo, CommitteeRepository>(
    create: (context) => CommitteeRepository(
      apiService: ApiService.of(context),
      accountInfo: AccountInfo.of(context),
    ),
    update: (_, apiService, accountInfo, scheduleRepository) =>
        scheduleRepository ??
        CommitteeRepository(
          apiService: apiService,
          accountInfo: accountInfo,
        ),
  ),
  ProxyProvider2<ApiService, AccountInfo, NotificationRepository>(
    create: (context) => NotificationRepository(
      apiService: ApiService.of(context),
      accountInfo: AccountInfo.of(context),
    ),
    update: (_, apiService, accountInfo, scheduleRepository) =>
        scheduleRepository ??
        NotificationRepository(
          apiService: apiService,
          accountInfo: accountInfo,
        ),
  ),
  // ProxyProvider2<ApiService, AccountInfo, UserRepository>(
  //   create: (context) => UserRepository(
  //     apiService: ApiService.of(context),
  //     accountInfo: AccountInfo.of(context),
  //   ),
  //   update: (_, apiService, accountInfo, userRepository) =>
  //       userRepository ??
  //       UserRepository(
  //         apiService: apiService,
  //         accountInfo: accountInfo,
  //       ),
  // ),
];
