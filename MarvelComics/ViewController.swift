//
//  ViewController.swift
//  MarvelComics
//
//  Created by Dominik on 26/05/2020.
//  Copyright © 2020 Dominik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var comics: [Comic]? = []
    let ts = NSDate().timeIntervalSince1970
    let privateKey = "deae3563b15d2988d67844126915dfa0538f01df"
    let publicKey = "6c4c913ce4dc4b4d61ce5dc3e7079efa"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchArticles()
    }
    
    
    func fetchArticles(){
        

        
        let hash=md5("\(ts)\(privateKey)\(publicKey)")
        
        let urlRequest = URLRequest(url:URL(string: "https://gateway.marvel.com/v1/public/comics?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest){(data,response,error) in
            if error != nil {
                print(error)
                return
            }
            
            self.comics = [Comic]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                
                if let comicsFromJson = json["data"] as? [String: AnyObject]{
                    let comicsFromJson = comicsFromJson["results"] as? [[String: AnyObject]]

                    
                    for comicsFromJson in comicsFromJson! {
                        let thumbFromJson = comicsFromJson["thumbnail"]
                        let dateFromJson = comicsFromJson["dates"]
                        let comic = Comic()
                        if let title = comicsFromJson["title"] as? String, let isbn = comicsFromJson["isbn"] as? String {
                            comic.title = title
                            comic.isbn = isbn
                            
                        }
                        if let path = thumbFromJson?["path"] as? String, let ext = thumbFromJson?["extension"] as? String {
                            comic.imgUrl = "\(path).\(ext)"
                            

                        }
                        if let date = dateFromJson?["date"] as? String{
                            comic.dateOnSale = date
                            
                        }
                        
                        self.comics?.append(comic)
                    }
                    
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }catch let error{
                print(error)
            }
        }
        task.resume()
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comicCell", for: indexPath) as! ComicCell
        
        cell.title.text = comics?[indexPath.row].title
        cell.dateOnSale.text = comics?[indexPath.row].dateOnSale

        
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.comics?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func md5(_ string: String) -> String {
        
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate(capacity: 1)
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
    
        return hexString
    }
    
}


