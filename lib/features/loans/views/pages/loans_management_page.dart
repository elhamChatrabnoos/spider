import 'package:flutter/material.dart';
import 'package:sockettest/features/loans/models/loans_response.dart';
import 'package:sockettest/features/loans/views/widgets/loan_item.dart';

class LoansManagementPage extends StatelessWidget {
  const LoansManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Loans Management')),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          return LoanItem(loanItem: LoanModel());
        },
      ),
    );
  }
}
