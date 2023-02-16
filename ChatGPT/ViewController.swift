//
//  ViewController.swift
//  ChatGPT
//
//  Created by user on 2023/02/15.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var messagesTableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var messageSendButton: UIButton!
    
    let chatManager = ChatManager.shared
    
    let disposeBag = DisposeBag()
    
    var messages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.backgroundColor = .systemYellow
        
        messagesTableView.transform = CGAffineTransformMakeRotation(-.pi)
        
        messagesTableView.register(MessageCell.self, forCellReuseIdentifier: "MessageCell")
        
        chatManager.receivedMessage
            .map{ $0 }
            .subscribe{ [weak self] message in
                message.map {
                    let newMessage = $0.replacingOccurrences(of: "\n\n", with: "")
                    print(newMessage)
                    self?.messages.insert(newMessage, at: 0)
                    self?.messagesTableView.reloadData()
                }
            }.disposed(by: disposeBag)
    }
    
    @IBAction func messageButtonTapped(_ sender: Any) {
        guard let messageString  = messageTextField.text else { return }
        if messageString == "" { return }
        messages.insert(messageString, at: 0)
        chatManager.sendMessage(message: messageString)
        messagesTableView.reloadData()
    }
    
    func makeMessageBubble(message: String) {
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        cell.transform = CGAffineTransformMakeRotation(-.pi)
        
        cell.messageLabel.text = "\(messages[indexPath.row])"
        
        return cell
    }
}
