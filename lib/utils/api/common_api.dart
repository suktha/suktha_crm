// Base Api url.........................................

// --- if you need to change the server first logout the current account
//      and change to whatever you want down there and hot reload

const String baseUrl = "https://api.test.brainibooks.com/core-erp/api"; //test
const String baseAuthUrl = "https://api.test.brainibooks.com/core-erp"; //auth

// const String baseUrl = "https://api.suktha.com/core-erp/api"; // production
// const String baseAuthUrl = "https://api.suktha.com/core-erp"; //auth          production

// const String baseUrl = "https://api.uat.brainibooks.com/core-erp/api"; //uat
// const String baseAuthUrl = "https://api.uat.brainibooks.com/core-erp"; //auth        uat

const String transactionNumberUrl = "/transaction-number";

// customer api.......................................
const String customerListUrl = "/customer";
const String searchPartyUrl = "/parties-by-name";

// Supplier api.......................................
const String supplierListUrl = "/supplier";

// material api.......................................
const String materialNameUrl = "/materials";
const String searchMaterialNameUrl = "/material/search-name";
const String jobworkMaterialUrl = "/jobwork-materials";

const String materialTyepUrl = "/material-type";

const String materialImageNameUrl = "/material/image";

const String materialImageUrl = "/files/material";

// party api.......................................
const String partyUrl = "/party";

const String partyTyepUrl = "/party-type";

// unit api.......................................
const String unitsUrl = "/uoms";

// tax list api.......................................
const String taxesUrl = "/taxes";

// financial year ...........................................
const String financialYearUrl = "/financial-year";

// global settings ...........................................
const String SettingsUrl = "/settings";
const String globalSettingUrl = "/global-setting";

// menu settings ...........................................
const String menuUrl = "/menus";

// Transaction Type ...........................................
const String transactionTypeUrl = "/transaction-type";

// auto generating Transaction Number...........................................
const String transationNumUrl = "/transaction-number";

// Terms and Condition...........................................
const String termsAndConditionUrl = "/terms-and-conditions";

//send mail ........................
const String sendEmailUrl = "/send-Email/";

const String paymentMethodUrl = "/payment-methods";

const String cardTypeUrl = "/card-type";

const String expenseUrl = "/expenses";

const String voucherUrl = "/voucher";

//advance receipt

const String createAdvanceRecUrl = "/create-adv-recpt";
const String deleteAdvanceRecUrl = "/adv-delete";
const String advanceRecUrl = "/Advance Receipt";
const String getAdvanceReceiptUrl = "/get-adv-recpt";

const String checkVoucherNumberUrl = "/check-voucherNumber";

//referal
const String getUserReferralUrl = "/referralUser";
const String getReferredListUrl = "/getReferralList";
const String generateReferralUrl = "/generateUrl";
const String sendInvitesUrl = "/sendInvites";

//lead management

const String leadGenerationUrl = "/Lead Generation";
const String sourceUrl = "/source";
const String conversionChanceUrl = "/conversionChance";
const String priorityUrl = "/priority";
const String followUpTimeUrl = "/followUpTime";
const String statusByIdUrl = "/statusById";
const String priorityChartUrl = "/getChartForPriority";
const String statusChartUrl = "/getChartForStatus";
const String sourceChartUrl = "/getChartForSource";
const String conversionChanceChartUrl = "/getChartForConversionChance";
const String maxLeadAmountChartUrl = "/getChartForMaxLeadAmount";
const String interestedProductChartUrl = "/getChartForInterestedProduct";
const String sharedDocumentHistoryUrl = "/getSharedDocumentHistory";
const String sendMailLeadUrl = "/send-Email-Lead";
