//
//  MessageCell.swift
//  ChatGPT
//
//  Created by user on 2023/02/16.
//

import UIKit
import SnapKit

class MessageCell: UITableViewCell {
    
    let isBotMessage = false
    let messageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
    func setUI() {
        backgroundColor = .brown
        
        addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

}
