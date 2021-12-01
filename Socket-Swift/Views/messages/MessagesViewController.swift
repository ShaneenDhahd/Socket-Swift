//
//  MessagesViewController.swift
//  Socket-Swift
//
//  Created by Hadi Dhahd on 01/12/2021.
//

import UIKit


class MessagesViewController: UIViewController, URLSessionWebSocketDelegate {

	let webSocket = WebSocket()
	
	@IBOutlet var tableView: UITableView!
	@IBOutlet var message: UITextField!
	
	var msgs = [String]()
	
	override func viewDidLoad(){
        super.viewDidLoad()
		webSocket.delegate = self
		webSocket.initConnection()
		initTableView()
		webSocket.receive { msg in
			print("msg \(msg)")
			self.msgs.append(msg)
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
        // Do any additional setup after loading the view.
    }
	private func initTableView(){
		tableView.delegate = self
		tableView.dataSource = self
		// named by mistake
		let msgNib = UINib(nibName: "MessageCellTableViewCell", bundle: nil)
		
		tableView.register(msgNib, forCellReuseIdentifier: "msgCell")
	}
	
	
	@IBAction func send(_ sender: UIButton) {
		guard let message = message.text else {
			return
		}
		webSocket.sendMessage(msg: message)
	}

}
extension MessagesViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		msgs.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "msgCell", for: indexPath) as! MessageCellTableViewCell
		cell.setupMsg(msg: msgs[indexPath.item])
		return cell
	}
	
	
}
