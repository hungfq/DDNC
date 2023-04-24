import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Teacher {
  final String name;
  final String topic;

  Teacher(this.name, this.topic);
}

class TopicData {
  final String topic;
  final int count;

  TopicData(this.topic, this.count);
}

class Student {
  final String name;
  final String gender;

  Student(this.name, this.gender);
}

class GenderData {
  final String gender;
  final int count;

  GenderData(this.gender, this.count);
}

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> with BasePageState {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<TopicData> data = _getTopicData();
    List<GenderData> dataGender = _getGenderData();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // appBar: PrimarySliverAppBar(
        //   title: "Stats Page",
        //   pinned: true,
        //   floating: false,
        //   actions: const [
        //     PrimaryBtnMenu(),
        //   ],
        //   backgroundColor: theme.primaryColor,
        //   onBackgroundColor: theme.colorScheme.onPrimary,
        //   bottom: TabBar(
        //     tabs: [
        //       Tab(text: 'Not Approved'),
        //       Tab(text: 'Approved'),
        //     ],
        //   ),
        // ),
        appBar: AppBar(
          actions: [
            PrimaryBtnMenu(),
          ],
          foregroundColor: theme.colorScheme.onPrimary,
          title: Text('Statistics'),
          bottom: TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(text: 'Advisor'),
              Tab(text: 'Gender'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SfCartesianChart(
              title: ChartTitle(text: 'Advisor Topic Count'),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries<TopicData, String>>[
                BarSeries<TopicData, String>(
                  dataSource: data,
                  xValueMapper: (TopicData data, _) => data.topic,
                  yValueMapper: (TopicData data, _) => data.count,
                  name: 'Advisor Count',
                )
              ],
            ),
            SfCircularChart(
              legend: Legend(isVisible: true),
              series: <CircularSeries>[
                PieSeries<GenderData, String>(
                  dataSource: dataGender,
                  xValueMapper: (GenderData data, _) => data.gender,
                  yValueMapper: (GenderData data, _) => data.count,
                  name: 'Gender',
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                      labelIntersectAction: LabelIntersectAction.none,
                      // format: '{point.y}%'),
                      textStyle: TextStyle(fontSize: 12)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<TopicData> _getTopicData() {
    Map<String, int> data = {};

    List<TopicData> topicData = [
      TopicData('Giao vien 1', 7),
      TopicData('Giao vien 2', 3),
      TopicData('Giao vien 3', 5),
      TopicData('Giao vien 4', 7),
      TopicData('Giao vien 5', 30),
      TopicData('Giao vien 6', 7),
    ];

    return topicData;
  }

  List<GenderData> _getGenderData() {
    int totalCount = 120 + 30;
    return [
      GenderData('Male', (120 * 100) ~/ totalCount),
      GenderData('Female', (30 * 100) ~/ totalCount),
    ];
  }
}
