//
//  UITableViewCell+Extension.swift
//  tableMenu
//
//  Created by 山崎健太 on 2019/08/04.
//  Copyright © 2019 山崎健太. All rights reserved.
//

import UIKit

extension UITableViewCell{
    static var nib: UINib{
        return UINib(nibName: String(describing: `self`), bundle: nil)
    }
    
    static var name: String{
        return String(describing: `self`)
    }
}
