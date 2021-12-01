//
//  ViewController.swift
//  Socket-Swift
//
//  Created by Hadi Dhahd on 29/11/2021.
//

import UIKit

class ViewController: UIViewController {

	let auth = Authenticator()
	
	@IBOutlet var phone: UITextField!
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}

	@IBAction func sendCode(_ sender: Any) {
		guard let phone = phone.text else {
			return
		}
		
		Authenticator.shared.startAuth(phone: phone) { succeeded in
			print("is succeeded \(succeeded)")
			DispatchQueue.main.async { [self] in
				let smsCV = storyboard?.instantiateViewController(withIdentifier: "smsVC") as! VerificationViewController
				navigationController?.pushViewController(smsCV, animated: true)
			}
		}
	}
	
}

