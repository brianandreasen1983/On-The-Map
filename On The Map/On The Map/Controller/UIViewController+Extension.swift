//
//  UIViewController+Extension.swift
//  On The Map
//
//  Created by Brian Andreasen on 10/11/20.
//  Copyright © 2020 Brian Andreasen. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        UdacityClient.logout {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}


