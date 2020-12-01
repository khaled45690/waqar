
import 'package:shared_preferences/shared_preferences.dart';

class PaymentAccountVM {
    String AlAhly_TitleAr;
        String AlAhly_TitleEn;
        String AlAhly_BankNameAr;
        String AlAhly_BankNameEn;
        String AlAhly_IBAN;
        String AlAhly_ACCountNO;
        String AlRaghy_TitleAr;
        String AlRaghy_TitleEn;
        String AlRaghy_BankNameAr;
        String AlRaghy_BankNameEn;
        String AlRaghy_IBAN;
        String AlRaghy_ACCountNO;
        String Sampa_TitleAr;
        String Sampa_TitleEn;
        String Sampa_BankNameAr;
        String Sampa_BankNameEn;
        String Sampa_IBAN;
        String Sampa_ACCountNO;
        String AlEnma_TitleAr;
        String AlEnma_TitleEn;
        String AlEnma_BankNameAr;
        String AlEnma_BankNameEn;
        String AlEnma_IBAN;
        String AlEnma_ACCountNO;
        String Sap_TitleAr;
        String Sap_TitleEn;
        String Sap_BankNameAr;
        String Sap_BankNameEn;
        String Sap_IBAN;
        String Sap_ACCountNO;

    PaymentAccountVM({this.AlAhly_TitleAr,this.AlAhly_TitleEn, this.AlAhly_BankNameAr,this.AlAhly_BankNameEn,this.AlAhly_IBAN,
      this.AlAhly_ACCountNO,this.AlRaghy_TitleAr,this.AlRaghy_TitleEn, this.AlRaghy_BankNameAr,this.AlRaghy_BankNameEn,this.AlRaghy_IBAN,
      this.AlRaghy_ACCountNO,this.Sampa_TitleAr,this.Sampa_TitleEn, this.Sampa_BankNameAr,this.Sampa_BankNameEn,this.Sampa_IBAN,
      this.Sampa_ACCountNO,this.AlEnma_TitleAr,this.AlEnma_TitleEn, this.AlEnma_BankNameAr,this.AlEnma_BankNameEn,this.AlEnma_IBAN,
      this.AlEnma_ACCountNO,this.Sap_TitleAr,this.Sap_TitleEn, this.Sap_BankNameAr,this.Sap_BankNameEn,this.Sap_IBAN,
      this.Sap_ACCountNO,});

    factory PaymentAccountVM.fromJson(Map<String, dynamic> json) {
        return PaymentAccountVM(
            AlAhly_TitleAr: json['alAhly_TitleAr']==null?"":json['alAhly_TitleAr'], 
            AlAhly_TitleEn: json['alAhly_TitleEn']==null?"":json['alAhly_TitleEn'], 
            AlAhly_BankNameAr: json['alAhly_BankNameAr']==null?"":json['alAhly_BankNameAr'], 
            AlAhly_BankNameEn: json['alAhly_BankNameEn']==null?"":json['alAhly_BankNameEn'], 
            AlAhly_IBAN: json['alAhly_IBAN']==null?"":json['alAhly_IBAN'], 
            AlAhly_ACCountNO: json['alAhly_ACCountNO']==null?"":json['alAhly_ACCountNO'], 
            
            AlRaghy_TitleAr: json['alRaghy_TitleAr']==null?"":json['alRaghy_TitleAr'], 
            AlRaghy_TitleEn: json['alRaghy_TitleEn']==null?"":json['alRaghy_TitleEn'], 
            AlRaghy_BankNameAr: json['alRaghy_BankNameAr']==null?"":json['alRaghy_BankNameAr'], 
            AlRaghy_BankNameEn: json['alRaghy_BankNameEn']==null?"":json['alRaghy_BankNameEn'], 
            AlRaghy_IBAN: json['alRaghy_IBAN']==null?"":json['alRaghy_IBAN'], 
            AlRaghy_ACCountNO: json['alRaghy_ACCountNO']==null?"":json['alRaghy_ACCountNO'], 
            
            Sampa_TitleAr: json['sampa_TitleAr']==null?"":json['sampa_TitleAr'], 
            Sampa_TitleEn: json['sampa_TitleEn']==null?"":json['sampa_TitleEn'], 
            Sampa_BankNameAr: json['sampa_BankNameAr']==null?"":json['sampa_BankNameAr'], 
            Sampa_BankNameEn: json['sampa_BankNameEn']==null?"":json['sampa_BankNameEn'], 
            Sampa_IBAN: json['sampa_IBAN']==null?"":json['sampa_IBAN'], 
            Sampa_ACCountNO: json['sampa_ACCountNO']==null?"":json['sampa_ACCountNO'], 
            
            AlEnma_TitleAr: json['alEnma_TitleAr']==null?"": json['alEnma_TitleAr'], 
            AlEnma_TitleEn: json['alEnma_TitleEn']==null?"": json['alEnma_TitleEn'],  
            AlEnma_BankNameAr: json['alEnma_BankNameAr']==null?"": json['alEnma_BankNameAr'], 
            AlEnma_BankNameEn: json['alEnma_BankNameEn']==null?"": json['alEnma_BankNameEn'], 
            AlEnma_IBAN: json['alEnma_IBAN']==null?"": json['alEnma_IBAN'],  
            AlEnma_ACCountNO: json['alEnma_ACCountNO']==null?"": json['alEnma_ACCountNO'], 
            
            Sap_TitleAr: json['sap_TitleAr']==null?"": json['sap_TitleAr'], 
            Sap_TitleEn: json['sap_TitleEn']==null?"": json['sap_TitleEn'], 
            Sap_BankNameAr: json['sap_BankNameAr']==null?"": json['sap_BankNameAr'], 
            Sap_BankNameEn: json['sap_BankNameEn']==null?"": json['sap_BankNameEn'], 
            Sap_IBAN: json['sap_IBAN']==null?"": json['sap_IBAN'], 
            Sap_ACCountNO: json['sap_ACCountNO']==null?"": json['sap_ACCountNO'], 
            
        );
    }


   
}


class CreatePaymentVM {
    String userId;
        String phone1;
        String phone2;
        String email;
        String customerName;
        String accountTransfer;
        String accountTransferTo;
        String nameWhoTransfer;
        String bankName;
        String Orderfile;

    CreatePaymentVM({this.userId,this.phone1, this.phone2,this.email,this.customerName,
      this.accountTransfer,this.accountTransferTo,this.nameWhoTransfer,this.bankName , this.Orderfile});

    factory CreatePaymentVM.fromJson(Map<String, dynamic> json) {
        return CreatePaymentVM(
            // userId: json['userId'], 
            // AlAhly_TitleEn: json['AlAhly_TitleEn'], 
            // AlAhly_BankNameAr: json['AlAhly_BankNameAr'], 
            // AlAhly_BankNameEn: json['AlAhly_BankNameEn'], 
            // AlAhly_IBAN: json['AlAhly_IBAN'], 
            // AlAhly_ACCountNO: json['AlAhly_ACCountNO'], 
            
            // AlRaghy_TitleAr: json['AlRaghy_TitleAr'], 
            // AlRaghy_TitleEn: json['AlRaghy_TitleEn'], 
            // AlRaghy_BankNameAr: json['AlRaghy_BankNameAr'], 
            // AlRaghy_BankNameEn: json['AlRaghy_BankNameEn'], 
            // AlRaghy_IBAN: json['AlRaghy_IBAN'], 
            // AlRaghy_ACCountNO: json['AlRaghy_ACCountNO'], 
            
            // Sampa_TitleAr: json['Sampa_TitleAr'], 
            // Sampa_TitleEn: json['Sampa_TitleEn'], 
            // Sampa_BankNameAr: json['Sampa_BankNameAr'], 
            // Sampa_BankNameEn: json['Sampa_BankNameEn'], 
            // Sampa_IBAN: json['Sampa_IBAN'], 
            // Sampa_ACCountNO: json['Sampa_ACCountNO'], 
            
            // AlEnma_TitleAr: json['AlEnma_TitleAr'], 
            // AlEnma_TitleEn: json['AlEnma_TitleEn'], 
            // AlEnma_BankNameAr: json['AlEnma_BankNameAr'], 
            // AlEnma_BankNameEn: json['AlEnma_BankNameEn'], 
            // AlEnma_IBAN: json['AlEnma_IBAN'], 
            // AlEnma_ACCountNO: json['AlEnma_ACCountNO'], 
            
            // Sap_TitleAr: json['Sap_TitleAr'], 
            // Sap_TitleEn: json['Sap_TitleEn'], 
            // Sap_BankNameAr: json['Sap_BankNameAr'], 
            // Sap_BankNameEn: json['Sap_BankNameEn'], 
            // Sap_IBAN: json['Sap_IBAN'], 
            // Sap_ACCountNO: json['Sap_ACCountNO'], 
            
        );
    }


   
}


