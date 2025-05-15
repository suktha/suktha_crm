// import 'package:get/get.dart';
// import 'package:suktha/Controller/initial_controller.dart';
// import 'package:suktha/Model/transaction_type_model.dart';
// import 'package:suktha/View/Modules/Accounts/Account%20Items/Advance%20Receipt/View%20Advance%20Receipt/list_advance_receipt.dart';
// import 'package:suktha/View/Modules/Accounts/Account%20Items/Customer%20Receipts/view%20Customer%20Receipt/list_customer_receipts.dart';
// import 'package:suktha/View/Modules/Accounts/Account%20Items/Supplier%20Payment/view%20Supplier%20Payment/list_supplier_payment.dart';
// import 'package:suktha/View/Modules/Accounts/Account%20Items/Vouchers/Cash%20Vouchers/View%20Cash%20Vouchers/list_cash_voucher.dart';
// import 'package:suktha/View/Modules/Accounts/Account%20Items/Vouchers/Cheque%20Vouchers/View%20Cheque%20Vouchers/list_cheque_voucher.dart';
// import 'package:suktha/View/Modules/Transactions/Job%20Work/Job%20Work%20Items/Job%20Work%20Credit%20Note/view%20Jobwork%20Credit%20Note/list_jobwork_credit_note.dart';
// import 'package:suktha/View/Modules/Transactions/Job%20Work/Job%20Work%20Items/Job%20Work%20In%20DC/view%20jobwork%20In%20dc/jobwork_in_dc_list.dart';
// import 'package:suktha/View/Modules/Transactions/Job%20Work/Job%20Work%20Items/Job%20Work%20Invoice/view%20jobwork%20Invoice/list_jobwork_invoice.dart';
// import 'package:suktha/View/Modules/Transactions/Job%20Work/Job%20Work%20Items/Job%20Work%20Out%20DC/view%20jobwork%20out%20dc/list_jobwork_out_dc.dart';
// import 'package:suktha/View/Modules/Transactions/Job%20Work/Job%20Work%20Items/Job%20Work%20Proforma%20Invoice/view%20jobwork%20proforma%20Invoice/list_jobwork_proforma_invoice.dart';
// import 'package:suktha/View/Modules/Transactions/Job%20Work/Job%20Work%20Items/Job%20Work%20Purchase%20Order/view%20jobwork%20PO/list_jobwork_po.dart';
// import 'package:suktha/View/Modules/Transactions/Job%20Work/Job%20Work%20Items/Job%20Work%20Quotation/View%20Job%20Work%20Quotation/jobwork_quotation_list.dart';
// import 'package:suktha/View/Modules/Transactions/Purchase/PurchaseItems/Debit%20Note/view%20Debit%20Note/list_debit_note.dart';
// import 'package:suktha/View/Modules/Transactions/Purchase/PurchaseItems/GRN/view%20GRN/list_grn.dart';
// import 'package:suktha/View/Modules/Transactions/Purchase/PurchaseItems/Incoming%20DC/view%20dc/list_dc.dart';
// import 'package:suktha/View/Modules/Transactions/Purchase/PurchaseItems/Purchase%20Invoice/view%20Purchase%20Invoice/list_purchase_invoice.dart';
// import 'package:suktha/View/Modules/Transactions/Purchase/PurchaseItems/Supplier%20Po/view%20Supplier%20Po/list_supplier_po.dart';
// import 'package:suktha/View/Modules/Transactions/Sales/Sales%20Items/Credit%20Note/view%20Credit%20Note/list_credit_note.dart';
// import 'package:suktha/View/Modules/Transactions/Sales/Sales%20Items/Customer%20DC/view%20dc/list_dc.dart';
// import 'package:suktha/View/Modules/Transactions/Sales/Sales%20Items/Proforma%20Invoice/view%20proforma%20Invoice/list_proforma_invoice.dart';
// import 'package:suktha/View/Modules/Transactions/Sales/Sales%20Items/Purchase%20Order/view%20purchase%20order/list_purchase_order.dart';
// import 'package:suktha/View/Modules/Transactions/Sales/Sales%20Items/Quotation/View%20Quotation/Quotation_list.dart';
// import 'package:suktha/View/Modules/Transactions/Sales/Sales%20Items/Tax%20Invoice/view%20Tax%20Invoice/list_tax_invoice.dart';
// import 'package:suktha/View/Modules/Transactions/Subcontracting/Subcontracting%20Items/Subcontracting%20%20Purchase%20Order/view%20Subcontracting%20PO/list_subcontracting_po.dart';
// import 'package:suktha/View/Modules/Transactions/Subcontracting/Subcontracting%20Items/Subcontracting%20Debit%20Note/view%20Subcontracting%20Debit%20Note/list_subcontracting_debit_note.dart';
// import 'package:suktha/View/Modules/Transactions/Subcontracting/Subcontracting%20Items/Subcontracting%20In%20DC/view%20Subcontracting%20In%20dc/subcontracting_in_dc_list.dart';
// import 'package:suktha/View/Modules/Transactions/Subcontracting/Subcontracting%20Items/Subcontracting%20Invoice/view%20Subcontracting%20Invoice/list_subcontracting_invoice.dart';
// import 'package:suktha/View/Modules/Transactions/Subcontracting/Subcontracting%20Items/Subcontracting%20Out%20DC/view%20Subcontracting%20out%20dc/list_subcontracting_out_dc.dart';
// import 'package:suktha/View/Modules/Transactions/Subcontracting/Subcontracting%20Items/Subcontracting%20Proforma%20Invoice/view%20Subcontracting%20proforma%20Invoice/list_subcontracting_proforma_invoice.dart';
// import 'package:suktha/View/Modules/Transactions/Subcontracting/Subcontracting%20Items/Subcontracting%20Quotation/View%20Subcontracting%20Quotation/subcontracting_quotation_list.dart';
// import 'package:suktha/View/Modules/Transactions/transaction_controller.dart';
// import 'package:work_Force/Model/transaction_type_model.dart';
// import 'package:work_Force/controllers/initial_controller.dart';

// class TransactionNavigationService {
//   static final TransactionNavigationService _instance = TransactionNavigationService._internal();

//   factory TransactionNavigationService() {
//     return _instance;
//   }

//   TransactionNavigationService._internal();

//   void navigateToTransactionScreen(int typeId, String transactionNumber) {
//     final navigationMap = {
//       "Customer Invoice": (String num) => Get.to(TaxInvoiceScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Supplier PO": (String num) => Get.to(SupplierPoScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Customer Receipts": (String num) => Get.to(CustomerReceiptsScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Supplier Payments": (String num) => Get.to(SupplierPaymentScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Purchase Invoice": (String num) => Get.to(PurchaseInvoiceScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Incoming DC": (String num) => Get.to(IncomingDcScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Customer DC": (String num) => Get.to(DcScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "GRN": (String num) => Get.to(GrnScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Credit Note": (String num) => Get.to(CreditNoteScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Debit Note": (String num) => Get.to(DebitNoteScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Customer PO": (String num) => Get.to(PurchaseOrderSalesScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Customer Quotation": (String num) => Get.to(QuotationScreen(isFromHomeScreen: true, quotationNumber: num)),
//       "Jobwork In DC": (String num) => Get.to(JobWorkInDcScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Jobwork Out DC": (String num) => Get.to(JobWorkOutDcScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Jobwork Invoice": (String num) => Get.to(JobworkInvoiceScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Subcontracting Out DC": (String num) => Get.to(SubcontractingOutDcScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Subcontracting In DC": (String num) => Get.to(SubcontractingInDcScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Subcontracting Invoice": (String num) => Get.to(SubcontractingInvoiceScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Proforma Invoice": (String num) => Get.to(ProfromaInvoiceScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Jobwork PO": (String num) => Get.to(JobworkPurchaseOrderScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Subcontracting PO": (String num) => Get.to(SubcontractingPurchaseOrderScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Cash Voucher": (String num) => Get.to(CashVoucherScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Cheque Voucher": (String num) => Get.to(ChequeVoucherScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Petty Cash": (String num) => Get.to(DcScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Customer Code": (String num) => Get.to(DcScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Supplier Code": (String num) => Get.to(DcScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Jobwork Credit Note": (String num) => Get.to(JobWorkCreditNoteScreen(isFromHomeScreen: true, creditTransactionNumber: num)),
//       "Subcontract Debit Note": (String num) => Get.to(SubcontractDebitNoteScreen(isFromHomeScreen: true, debitTransactionNumber: num)),
//       "Jobwork Quotation": (String num) => Get.to(JobWorkQuotationScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Subcontracting Quotation": (String num) => Get.to(SubcontractingQuotationScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Jobwork Proforma Invoice": (String num) => Get.to(JobworkProformaInvoiceScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Subcontracting Proforma Invoice": (String num) => Get.to(SubcontractingProformaInvoiceScreen(isFromHomeScreen: true, transactionNumber: num)),
//       "Advance Receipt": (String num) => Get.to(AdvanceReceiptScreen(isFromHomeScreen: true, transactionNumber: num)),
//     };

//     // Fetch the transaction type from API or local controller
//     TransactionTypeModel? transaction = _getTransactionType(typeId);

//     print("transaction name: ${typeId}");

//     if (transaction != null) {
//       String typeName = transaction.name!;
//       if (navigationMap.containsKey(typeName)) {
//         navigationMap[typeName]!(transactionNumber);
//       } else {
//         print("❌ Unknown Transaction Type: $typeName");
//       }
//     }
//   }

//   TransactionTypeModel? _getTransactionType(int typeId) {
//     return Get.find<InitialController>().transactionTypeList.firstWhereOrNull(
//           (item) => item.id == typeId,
//         );
//   }
// }
