import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/colors.dart';
import 'package:hexatour/core/utils/Helpers.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../controllers/servive_payment_controller.dart';
import '../home/home_page.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final Razorpay _razorpay = Razorpay();

  final paymentController = Get.find<PaymentController>();

  @override
  void initState() {
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    print(
        "id proviede ${(paymentController.addPaymentResponse['data']['id']).runtimeType}");
    var options = {
      'key': 'rzp_test_NWZvPJnX2RVbt3',
      'amount': 900,
      'name': 'Sakshi',
      'description': 'Payment',
      'order_id': paymentController.addPaymentResponse['data']['id'],
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      print("inside try");
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error : $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("inside handle payment success");
    await paymentController.verifyPayment(
        feature_type: "service",
        razorpay_payment_id: response.paymentId,
        payment_type: 'success',
        razorpay_order_id: response.orderId,
        amount: '3444',
        payment_method: "netbanking");
    print(response.paymentId);
    print('paymentid');
    await Helpers.showSnackbar(
        text: "payment Successful",
        color: ColorConst.greenColor,
        context: context);
    Get.to(Homepage());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("inside handle payment error");

    Fluttertoast.showToast(
        msg: "ERROR: " +
            response.code.toString() +
            " - " +
            response.message.toString(),
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName.toString(),
        timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Cart',
            style: TextStyle(fontSize: 20.0, color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none,
                color: Color.fromARGB(255, 89, 210, 103)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(children: [
        SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Row(
              children: <Widget>[
                SizedBox(height: 15.0),
                Hero(
                    tag: 'assets/images/contact.png',
                    child: Image.asset('assets/images/man.png',
                        height: 90.0, width: 90.0, fit: BoxFit.contain)),
                SizedBox(width: 20.0),
                Column(
                  children: <Widget>[
                    Text('\$3.99',
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 17, 16, 16))),
                    SizedBox(height: 10.0),
                    // Text('brownie cookies',
                    //     style: TextStyle(
                    //         color: Color(0xFF575E67), fontSize: 24.0)),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.0),
        InkWell(
            onTap: () {
              openCheckout();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Container(
                  width: MediaQuery.of(context).size.width - 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color.fromARGB(255, 110, 224, 131)),
                  child: Center(
                      child: Text('Checkout',
                          style: TextStyle(
                              fontFamily: 'nunito',
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)))),
            ))
      ]),
    );
  }
}
