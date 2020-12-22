//
//  TabbedBarViewController.swift
//  On The Map
//
//  Created by Brian Andreasen on 5/27/20.
//  Copyright © 2020 Brian Andreasen. All rights reserved.
//

import UIKit

class TabbedBarViewController: UITabBarController {
    var students: [StudentInformation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _: () = ParseClient.getStudentLocationInformation() { studentResults, error in
            for studentResult in studentResults {
                self.students.append(studentResult)
            }
            
            let firstTab = self.viewControllers?[0] as! MapViewController
            firstTab.getStudentInformationResults(studentResults: self.students)
            
            let secondTab = self.viewControllers?[1] as! MapTableViewController
            secondTab.getStudentInformationResults(studentResults: self.students)
        }
    }
}
