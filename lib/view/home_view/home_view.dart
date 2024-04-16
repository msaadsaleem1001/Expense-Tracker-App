import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_expense_tracker_app/res/app_assets/app_assets.dart';
import 'package:personal_expense_tracker_app/res/app_colors/app_colors.dart';
import 'package:personal_expense_tracker_app/res/app_text_styles/text_styles.dart';
import 'package:personal_expense_tracker_app/res/components/expense_tile.dart';
import 'package:personal_expense_tracker_app/res/components/re_useable_row.dart';
import 'package:personal_expense_tracker_app/res/routes/routes_names.dart';
import 'package:personal_expense_tracker_app/res/utils/dialog_box.dart';
import 'package:personal_expense_tracker_app/view_model/bloc/expense_bloc/expense_bloc.dart';
import 'package:personal_expense_tracker_app/view_model/bloc/expense_bloc/expense_state.dart';
import '../../res/components/graph/bar_graph.dart';
import '../../view_model/bloc/expense_bloc/expense_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Brightness mode = Theme.of(context).brightness;
    final width = MediaQuery.sizeOf(context).width * 1;
    // final height = MediaQuery.sizeOf(context).height * 1;
    context.read<ExpenseBloc>().add(const GetAllExpenses());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Expenses'),
        centerTitle: false,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesNames.settingsScreen);
                },
                child: const Icon(Icons.settings),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppUtils.dialogAddExpense(context);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child:
            BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
          if (state.overAllExpenseList.isNotEmpty) {
            return ListView(
              children: [
                const SizedBox(height: 20),
                AppReUseAbleRow(
                    title: 'Total Expenses',
                    amount: state.totalExpenses.toString()),
                const SizedBox(height: 20),
                AppReUseAbleRow(
                    title: 'Total Weekly Expenses',
                    amount: state.weeklySummary.toString()),
                const SizedBox(height: 20),
                ExpenseBarGraph(graphData: state.graphData),
                const SizedBox(height: 20),
                ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.overAllExpenseList.length,
                  itemBuilder: (context, index) {
                    return ExpenseTile(
                        onTap: () {
                          AppUtils.dialogShowExpense(
                              context, state.overAllExpenseList[index]);
                        },
                        onDelPressed: (context) {
                          context.read<ExpenseBloc>().add(DeleteExpenseEvent(
                              expenseId: state.overAllExpenseList[index].id!,
                              listIndex: index));
                        },
                        onEditPressed: (context) {
                          AppUtils.dialogUpdateExpense(
                              index, context, state.overAllExpenseList[index]);
                        },
                        title: state.overAllExpenseList[index].title,
                        amount: state.overAllExpenseList[index].amount,
                        description: state.overAllExpenseList[index].desc,
                        dateTime: state.overAllExpenseList[index].dateTime);
                  },
                  separatorBuilder: (context, sepIndex) {
                    return const SizedBox(height: 20);
                  },
                ),
                const SizedBox(height: 80),
              ],
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width,
                    height: 300,
                    child: SvgPicture.asset(AppAssets.empty),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No expense found',
                    style: AppTextStyles.subTitleStyle(
                      fontSize: 18,
                      color: mode == Brightness.dark
                          ? AppColors.appWhite.withOpacity(0.7)
                          : AppColors.appBlack.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
            );
          }
        }),
      ),
    );
  }
}
