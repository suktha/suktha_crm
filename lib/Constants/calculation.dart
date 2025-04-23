class CalculationsCustom {
  discountAmount(double amount, double discountPercent) {
    double value = (amount * discountPercent / 100);
    return value;
  }

  discountPercent(double amount, double discountAmount) {
    double value = (discountAmount / amount * 100);
    return value;
  }

  taxableAmount(double amount, double discountAmount) {
    double value = amount - discountAmount;
    return value;
  }

  splitTax(double taxableAmount, double totaltax) {
    double value = taxableAmount * (totaltax / 100) / 2;
    return value;
  }

  inclusiveTax(double price, double tax) {
    double value = price / (100.00 + tax) * 100;
    return value;
  }

  tcsAmount(double taxableAmount, double tcsPercentage) {
    double value = (taxableAmount * tcsPercentage) / 100;
    return value;
  }

  tcsAmountToPercentage(double tcsAmount, double taxableAmount) {
    double value = (tcsAmount * 100) / taxableAmount;
    return value;
  }

  finalAmountTcs(double tcsAmount, double taxableAmount) {
    double value = (tcsAmount + taxableAmount);
    return value;
  }

  roundOffTotal(double grandTotalSum, double roundedTotalAmt) {
    print(grandTotalSum);
    print(roundedTotalAmt);
    double difference = grandTotalSum - roundedTotalAmt;
    print("diffffrence----${difference}");
    String roundedAmtString = difference >= 0 ? '-0.${(100 * difference).round()}' : '0.${(100 * -difference).round()}';
    return roundedAmtString;
  }
}
