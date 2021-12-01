//
//  VerificationViewController.swift
//  Socket-Swift
//
//  Created by Hadi Dhahd on 01/12/2021.
//

import UIKit

class VerificationViewController: UIViewController {

	@IBOutlet var smsCode: UITextField!
	let auth = Authenticator()
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func verify(_ sender: Any) {
		guard let code = smsCode.text else {
			print("code is nil")
			return
		}
		print("verifying... \(code)")
		Authenticator.shared.verify(code: code) { succeeded in
			if succeeded {
				print("is succeeded \(succeeded)")
				DispatchQueue.main.async { [self] in
					let socketVC = storyboard?.instantiateViewController(withIdentifier: "socket") as! MessagesViewController
					present(socketVC, animated: true, completion: nil)
				}
			}
		}
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
