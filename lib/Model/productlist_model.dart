class Product {


  
   int slno;
   String materialname;
    String description;
   String partnumber;
   String hsncode;
   String unit;
   int quantity;
   String price;
   String amount;
   String remarks;
  
  

  Product(
      this.slno,
      this.materialname,
      this.description,
      this.partnumber,
      this.hsncode,
      this.unit,
      this.quantity,
      this.price,
      this.amount,
      this.remarks);

  get id => null;
}

// class ProductConfirm{

//   String amount;
//  final String tax;

//   ProductConfirm(this.amount,this.tax);

// }