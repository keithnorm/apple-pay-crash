//
//  ViewController.swift
//  ApplePayTest
//
//  Created by Keith Norman on 3/18/16.
//  Copyright © 2016 Keith Norman. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let applePayButton = PKPaymentButton(paymentButtonType: .Buy, paymentButtonStyle: .Black)
        applePayButton.addTarget(self, action: "doApplePay", forControlEvents: .TouchUpInside)
        applePayButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(applePayButton)
        
        self.view.addConstraint(NSLayoutConstraint(item: applePayButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: applePayButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0))
    }
    
    func doApplePay() {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.com.foo.keithnorm"
        request.merchantCapabilities = PKMerchantCapability.Capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.supportedNetworks = [PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex]
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "summary 1", amount: 10.0)]
        request.requiredShippingAddressFields = PKAddressField.PostalAddress
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        applePayController.delegate = self
        presentViewController(applePayController, animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: ((PKPaymentAuthorizationStatus) -> Void)) {
    }

    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didSelectShippingContact contact: PKContact, completion: (PKPaymentAuthorizationStatus, [PKShippingMethod], [PKPaymentSummaryItem]) -> Void) {
        completion(.Success, [], [PKPaymentSummaryItem(label: "summary 1", amount: 10.0)])
    }
}


