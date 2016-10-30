//
//  ViewController.swift
//  WhiteHousePetitions
//
//  Created by Brian Wong on 10/29/16.
//  Copyright © 2016 Brian Wong. All rights reserved.
//

import UIKit


class ViewController: UITableViewController {

    //Array of dictionaries
    var petitions = [[String:String]]();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        //URL returns URL? so safely unwrap
        if let url = URL(string: urlString) {
            //Try is used to indicate that the method can throw an error
            
            //try? will either give us an optional with a value or an optional with nil. This is why it works well with optional binding: 
            //if(try succeeds and we get a value or true){
            //else { try failed with nil or false}
            if let data = try? Data(contentsOf: url) {
                //SwiftyJSON goin to work!
                let json = JSON(data: data)
                
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    parse(json: json)
                }
            }else{
                print("Invalid URL")
            }
        }
        
    }
    
    func parse(json: JSON) {
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title": title, "body": body, "sigs": sigs]
            petitions.append(obj)
        }
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        
        cell.textLabel?.text = petition["title"]
        cell.detailTextLabel?.text = petition["body"]
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

