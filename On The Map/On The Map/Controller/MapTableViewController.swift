//
//  MapTableViewController.swift
//  On The Map
//
//  Created by Brian Andreasen on 4/25/20.
//  Copyright © 2020 Brian Andreasen. All rights reserved.
//

import UIKit

class MapTableViewController: UITableViewController {
    let cellIdentifier = "studentInformationCell"
    var students: [StudentInformation] = []
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    // MARK -- Currently not populating :(
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let student = self.students[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StudentInformationCell else {
              fatalError("An issue has occurred.")
          }
        
        cell.fullName.text = student.firstName + " " + student.lastName
        cell.mediaURL.text = student.mediaURL
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = UIApplication.shared
        if let url = URL(string: self.students[(indexPath as NSIndexPath).row].mediaURL) {
            app.open(url)
        }
    }
    
    // MARK -- Expose a method that will take a list of students to populate the UI.
    func getStudentInformationResults(studentResults: [StudentInformation]) {
        students = studentResults
    }
    
}
