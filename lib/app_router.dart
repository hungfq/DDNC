import 'package:ddnc_new/repositories/account_repository.dart';
import 'package:ddnc_new/repositories/committee_repository.dart';
import 'package:ddnc_new/repositories/notification_repository.dart';
import 'package:ddnc_new/repositories/schedule_repository.dart';
import 'package:ddnc_new/repositories/topic_proposal_repository.dart';
import 'package:ddnc_new/repositories/topic_repository.dart';
import 'package:ddnc_new/repositories/user_repository.dart';
import 'package:ddnc_new/ui/homepage1.dart';
import 'package:ddnc_new/ui/pages/admin/committee/committee_detail/blocs/committee_detail_bloc.dart';
import 'package:ddnc_new/ui/pages/admin/committee/committee_detail/committee_detail_page.dart';
import 'package:ddnc_new/ui/pages/admin/committee/committee_list/blocs/committee_list_bloc.dart';
import 'package:ddnc_new/ui/pages/admin/committee/committee_list/committee_list_page.dart';
import 'package:ddnc_new/ui/pages/admin/stats/stats_page.dart';
import 'package:ddnc_new/ui/pages/dashboard/blocs/dashboard_bloc.dart';
import 'package:ddnc_new/ui/pages/dashboard/dashboard_page.dart';
import 'package:ddnc_new/ui/pages/lecturer/approve/approve_page.dart';
import 'package:ddnc_new/ui/pages/lecturer/approve/blocs/approve_bloc.dart';
import 'package:ddnc_new/ui/pages/lecturer/mark/blocs/mark_bloc.dart';
import 'package:ddnc_new/ui/pages/lecturer/mark/mark_page.dart';
import 'package:ddnc_new/ui/pages/lecturer/proposal/proposal_detail/blocs/proposal_detail_bloc.dart';
import 'package:ddnc_new/ui/pages/lecturer/proposal/proposal_detail/proposal_detail_page.dart';
import 'package:ddnc_new/ui/pages/lecturer/proposal/proposal_list/blocs/proposal_list_bloc.dart';
import 'package:ddnc_new/ui/pages/lecturer/proposal/proposal_list/proposal_list_page.dart';
import 'package:ddnc_new/ui/pages/lecturer/topic/topic_list/blocs/topic_list_bloc.dart';
import 'package:ddnc_new/ui/pages/lecturer/topic/topic_list/topic_list_page.dart';
import 'package:ddnc_new/ui/pages/master/blocs/master_bloc.dart';
import 'package:ddnc_new/ui/pages/master/master_page.dart';
import 'package:ddnc_new/ui/pages/admin/schedule/schedule_detail/blocs/schedule_detail_bloc.dart';
import 'package:ddnc_new/ui/pages/admin/schedule/schedule_detail/schedule_detail_page.dart';
import 'package:ddnc_new/ui/pages/admin/schedule/schedule_list/blocs/schedule_list_bloc.dart';
import 'package:ddnc_new/ui/pages/admin/schedule/schedule_list/schedule_list_page.dart';
import 'package:ddnc_new/ui/pages/notification/blocs/notification_bloc.dart';
import 'package:ddnc_new/ui/pages/notification/notification_page.dart';
import 'package:ddnc_new/ui/pages/sign_in/blocs/sign_in_bloc.dart';
import 'package:ddnc_new/ui/pages/sign_in/sign_in_page.dart';
import 'package:ddnc_new/ui/pages/admin/topic/topic_detail/blocs/topic_detail_bloc.dart';
import 'package:ddnc_new/ui/pages/admin/topic/topic_detail/topic_detail_page.dart';
import 'package:ddnc_new/ui/pages/admin/topic/topic_list/blocs/topic_list_bloc.dart';
import 'package:ddnc_new/ui/pages/admin/topic/topic_list/topic_list_page.dart';
import 'package:ddnc_new/ui/pages/admin/user/user_detail/blocs/user_detail_bloc.dart';
import 'package:ddnc_new/ui/pages/admin/user/user_detail/user_detail_page.dart';
import 'package:ddnc_new/ui/pages/admin/user/user_list/blocs/user_list_bloc.dart';
import 'package:ddnc_new/ui/pages/admin/user/user_list/user_list_page.dart';
import 'package:ddnc_new/ui/pages/student/proposal/proposal_detail/blocs/proposal_detail_bloc.dart';
import 'package:ddnc_new/ui/pages/student/proposal/proposal_detail/proposal_detail_page.dart';
import 'package:ddnc_new/ui/pages/student/proposal/proposal_list/blocs/proposal_list_bloc.dart';
import 'package:ddnc_new/ui/pages/student/proposal/proposal_list/proposal_list_page.dart';
import 'package:ddnc_new/ui/pages/student/register/register_detail/blocs/register_detail_bloc.dart';
import 'package:ddnc_new/ui/pages/student/register/register_detail/register_detail_page.dart';
import 'package:ddnc_new/ui/pages/student/register/register_list/blocs/register_list_bloc.dart';
import 'package:ddnc_new/ui/pages/student/register/register_list/register_list_page.dart';
import 'package:ddnc_new/ui/pages/student/register/register_result/blocs/register_result_bloc.dart';
import 'package:ddnc_new/ui/pages/student/register/register_result/register_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'commons/app_page.dart';
import 'ui/pages/admin/stats/blocs/stats_bloc.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //region systems
      case AppPages.masterPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MasterBloc(
              accountRepository: AccountRepository.of(context),
            ),
            child: const MasterPage(),
          ),
          settings: settings,
        );
      case AppPages.signInPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(
              accountRepository: AccountRepository.of(context),
            ),
            child: const LoginPage(),
          ),
          settings: settings,
        );
      case AppPages.homePage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<UserListBloc>(
            create: (context) => UserListBloc(
              userRepository: UserRepository.of(context),
            ),
            child: const HomePage(title: 'Admin Page'),
          ),
          settings: settings,
        );
      case AppPages.notificationPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<NotificationBloc>(
            create: (context) => NotificationBloc(
              notificationRepository: NotificationRepository.of(context),
            ),
            child: const NotificationPage(),
          ),
          settings: settings,
        );
      case AppPages.userListPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<UserListBloc>(
            create: (context) => UserListBloc(
              userRepository: UserRepository.of(context),
            ),
            child: const UserListPage(),
          ),
          settings: settings,
        );
      case AppPages.userDetailPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<UserDetailBloc>(
            create: (context) => UserDetailBloc(
              userRepository: UserRepository.of(context),
            ),
            child: UserDetailPage(),
          ),
          settings: settings,
        );
      case AppPages.topicListPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<TopicListBloc>(
            create: (context) => TopicListBloc(
              topicRepository: TopicRepository.of(context),
            ),
            child: const TopicListPage(),
          ),
          settings: settings,
        );
      case AppPages.topicDetailPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<TopicDetailBloc>(
            create: (context) => TopicDetailBloc(
              topicRepository: TopicRepository.of(context),
              // userRepository: UserRepository.of(context),
            ),
            child: const TopicDetailPage(),
          ),
          settings: settings,
        );
      case AppPages.topicProposalListPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<TopicProposalListBloc>(
            create: (context) => TopicProposalListBloc(
              topicRepository: TopicProposalRepository.of(context),
            ),
            child: const TopicProposalListPage(),
          ),
          settings: settings,
        );
      case AppPages.topicProposalDetailPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<TopicProposalDetailBloc>(
            create: (context) => TopicProposalDetailBloc(
              topicRepository: TopicProposalRepository.of(context),
            ),
            child: const TopicProposalDetailPage(),
          ),
          settings: settings,
        );
      case AppPages.proposalApproveListPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ApproveProposalListBloc>(
            create: (context) => ApproveProposalListBloc(
              topicRepository: TopicProposalRepository.of(context),
            ),
            child: const ApproveProposalListPage(),
          ),
          settings: settings,
        );
      case AppPages.proposalApproveDetailPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ApproveProposalDetailBloc>(
            create: (context) => ApproveProposalDetailBloc(
              topicRepository: TopicProposalRepository.of(context),
            ),
            child: const ApproveProposalDetailPage(),
          ),
          settings: settings,
        );
      case AppPages.lecturerTopicListPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LecturerTopicListBloc>(
            create: (context) => LecturerTopicListBloc(
              topicRepository: TopicRepository.of(context),
            ),
            child: const LecturerTopicListPage(),
          ),
          settings: settings,
        );
      case AppPages.registerListPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<RegisterListBloc>(
            create: (context) => RegisterListBloc(
              topicRepository: TopicRepository.of(context),
              scheduleRepository: ScheduleRepository.of(context),
            ),
            child: const RegisterListPage(),
          ),
          settings: settings,
        );
      case AppPages.registerDetailPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<RegisterDetailBloc>(
            create: (context) => RegisterDetailBloc(
              topicRepository: TopicRepository.of(context),
            ),
            child: const RegisterDetailPage(),
          ),
          settings: settings,
        );
      case AppPages.registerResultPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<RegisterResultBloc>(
            create: (context) => RegisterResultBloc(
              topicRepository: TopicRepository.of(context),
            ),
            child: const RegisterResultPage(),
          ),
          settings: settings,
        );
      case AppPages.scheduleListPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ScheduleListBloc>(
            create: (context) => ScheduleListBloc(
              scheduleRepository: ScheduleRepository.of(context),
            ),
            child: const ScheduleListPage(),
          ),
          settings: settings,
        );
      case AppPages.scheduleDetailPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ScheduleDetailBloc>(
            create: (context) => ScheduleDetailBloc(
              scheduleRepository: ScheduleRepository.of(context),
            ),
            child: const ScheduleDetailPage(),
          ),
          settings: settings,
        );
      case AppPages.committeeListPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CommitteeListBloc>(
            create: (context) => CommitteeListBloc(
              committeeRepository: CommitteeRepository.of(context),
            ),
            child: const CommitteeListPage(),
          ),
          settings: settings,
        );
      case AppPages.committeeDetailPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CommitteeDetailBloc>(
            create: (context) => CommitteeDetailBloc(
              committeeRepository: CommitteeRepository.of(context),
            ),
            child: const CommitteeDetailPage(),
          ),
          settings: settings,
        );
      case AppPages.lecturerTopicApprovePage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LecturerApproveBloc>(
            create: (context) => LecturerApproveBloc(
              topicRepository: TopicRepository.of(context),
            ),
            child: LecturerApprovePage(),
          ),
          settings: settings,
        );
      case AppPages.lecturerMarkPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LecturerMarkBloc>(
            create: (context) => LecturerMarkBloc(
              topicRepository: TopicRepository.of(context),
            ),
            child: LecturerMarkPage(),
          ),
          settings: settings,
        );
      case AppPages.statsPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<StatsBloc>(
            create: (context) => StatsBloc(
              userRepository: UserRepository.of(context),
            ),
            child: StatsPage(),
          ),
          settings: settings,
        );
      case AppPages.dashBoardPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(),
            child: const DashboardPage(),
          ),
          settings: settings,
        );
      //endregion
      default:
        return CupertinoPageRoute(
          builder: (_) => UndefinedView(
            routeName: settings.name,
          ),
          settings: settings,
        );
    }
  }
}

class UndefinedView extends StatelessWidget {
  final String? routeName;

  const UndefinedView({Key? key, this.routeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Route for ${routeName ?? 'no name'} is not defined'),
      ),
    );
  }
}
