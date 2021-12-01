//
//  Authinticator.swift
//  Socket-Swift
//
//  Created by Hadi Dhahd on 01/12/2021.
//

import Foundation
import FirebaseAuth

class Authenticator {
	static let shared = Authenticator()
	private let auth = Auth.auth()
	private var verificationId: String?
	
	public func startAuth(phone: String, completion: @escaping (Bool) -> Void) {
		PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil, multiFactorSession: nil) { [weak self] verificationID, error in
			guard let verificationId = verificationID, error == nil else {
				completion(false)
				return
			}
			print("verificatoin id \(verificationId)")
			self?.verificationId = verificationId
			completion(true)
			
		}
	}
	public func verify(code: String, completion: @escaping (Bool) -> Void) {
		guard let verificationId = verificationId else {
			print("guard else verificationId \(verificationId)")

			return
		}
		

		let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: code)
		print("crededntial \(credential)")

		auth.signIn(with: credential) { results, error in
			guard results != nil, error == nil else {
				print("guard else \(error)")
				completion(false)
				return
			}
			print("sms code \(code), \(results?.user)")
 			completion(true)
		}
	}
	
}
