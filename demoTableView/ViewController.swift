//
//  ViewController.swift
//  demoTableView
//
//  Created by Chu Thanh Dat on 8/25/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let contactCellId = "ContactTableViewCell"
    
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableContact: UITableView!
    
    @IBOutlet weak var loadingData: UIActivityIndicatorView!
    
    @IBOutlet weak var lblCallFailedData: UILabel!
    
    var  contacts: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableContact.register(UINib.init(nibName: contactCellId, bundle: nil), forCellReuseIdentifier: contactCellId)
        
        //Initdata
        callAPI()
        lblCallFailedData.isHidden = true
        loadingData.isHidden = true
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableContact.addSubview(refreshControl) // not
        
    }
    

    @objc func refresh(_ sender: AnyObject) {
        callAPI()
        print("scroll to bottom")
        refreshControl.endRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCellId, for: indexPath) as! ContactTableViewCell
        let contact = contacts[indexPath.row]
        cell.name.text = contact.userName
        cell.location.text = contact.location
        cell.age.text = String(contact.age)
        cell.sex.text = contact.gender
        
        
        let url = URL(string: contact.image)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.imgAvatar.image = UIImage(data: data!)
            }
        }
        return cell
    }
    
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
            callAPI()
            print("scroll to top")
        }
    }
    
    func callAPI() {
         self.loadingData.isHidden = false
        if  let url = URL(string: "http://demo0737597.mockable.io/master_data") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decorder = JSONDecoder()
                    do{
                        let parsedJSON = try decorder.decode(DataList.self, from: data)
                        self.contacts += parsedJSON.data
//                        self.contacts += self.contacts
                   
                        DispatchQueue.main.async {
                            self.tableContact.reloadData()
                             self.loadingData.isHidden = true
                        }
                      
                    }
                    catch {
                        self.lblCallFailedData.isHidden = false
                        self.tableContact.isHidden = true
                       
                        print("error")
                    }
                }
            }.resume()
        }
       
    }
    
    
    @IBAction func clickclick(_ sender: Any) {
        callAPI()
    }
    
    
}








