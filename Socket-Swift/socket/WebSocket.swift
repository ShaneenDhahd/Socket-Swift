//
//  WebSocket.swift
//  Socket-Swift
//
//  Created by Hadi Dhahd on 01/12/2021.
//

import Foundation
import UIKit

class WebSocket {
	
	var delegate: URLSessionWebSocketDelegate? = nil
	
	var webSocket: URLSessionWebSocketTask?
	let url = "wss://demo.piesocket.com/v3/channel_1?api_key=oCdCMcMPQpbvNjUIzqtvF1d2X2okWpDQj4AwARJuAgtjhzKxVEjQU6IdCjwm&notify_self"
	
	
	func initConnection(){
		let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: OperationQueue())
		webSocket = session.webSocketTask(with: URL(string: url)!)
		webSocket?.resume()
	}
	
	func sendMessage(msg: String) {
		webSocket?.send(.string(msg), completionHandler: { error in
			print("error \(error)")
		})
	}
	
	func receive(msg: @escaping (String) -> Void) {
		webSocket?.receive { [weak self] result in
			switch result {
				case .failure(let error):
					print("Error in receiving message: \(error)")
				case .success(let message):
					switch message {
						case .string(let text):
							print("Received string: \(text)")
							msg(text)
						case .data(let data):
							print("Received data: \(data)")
						@unknown default:
							break
					}
			}
			self?.receive(msg: { receivedMsg in
				msg(receivedMsg)
			})
		}
	}
	
}
