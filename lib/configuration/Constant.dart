class OrderinAppConstant {
  // static String baseURL = "https://orderin.tifnganjuk.com/api/apimobileorderin";
  static String baseURL = "http://172.16.103.43:8000/api/apimobileorderin";
  // static String baseURL = "http://0.0.0.0:8000/api/apimobileorderin";
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
