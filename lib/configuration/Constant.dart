class OrderinAppConstant {

//   static String baseURL = "https://orderin.tifnganjuk.com/api/apimobileorderin"; //hosting
  static String baseURL = "http://172.16.106.164:8000/api/apimobileorderin"; //hp
//   static String baseURL = "http://127.0.0.1:8000/api/apimobileorderin"; //local browser
  static String productgetURL = '${OrderinAppConstant.baseURL}/dataproduct';
  static String productgetfindURL = '${OrderinAppConstant.baseURL}/findproduct';
  static String uploadURL = '${OrderinAppConstant.baseURL}/uploadproduct';
  static String updateURL = '${OrderinAppConstant.baseURL}/product';
  static String delprodURL = '${OrderinAppConstant.baseURL}/delproduct';
  static String upimgURL = '${OrderinAppConstant.baseURL}/upload-img';
  static String getdataTransaction =
      '${OrderinAppConstant.baseURL}/transaction';
  static String updateTransaction =
      '${OrderinAppConstant.baseURL}/transactionupdate';
}
