//
//  ValueCell.swift
//  tableMenu
//
//  Created by 山崎健太 on 2019/08/04.
//  Copyright © 2019 山崎健太. All rights reserved.
//

import UIKit


/// タップ通知
protocol tappedDelegate: class{
    func tapped(handler:()->Void)
}

class ValueCell: UITableViewCell {

    private weak var delegate: tappedDelegate?
    private var handler: (()->Void)?
    
    @IBOutlet weak var textlabel: UILabel!
    @IBAction func button(_ sender: Any) {
        delegate?.tapped(handler: handler ?? {print("タップされました")})
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension ValueCell{
    
    /// セルのセットアップ
    ///
    /// - Parameter text: テキスト
    func setup(text:String,
               delegate:tappedDelegate,
               handler: (() -> Void)? = nil ){
        textlabel.text = text
        self.delegate = delegate
        self.handler = handler
    }
}
