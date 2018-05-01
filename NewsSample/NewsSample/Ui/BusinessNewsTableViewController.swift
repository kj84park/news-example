//
//  NewsTableViewController.swift
//  NewsSample
//
//  Created by mac on 2018. 4. 26..
//  Copyright © 2018년 StudioKJ. All rights reserved.
//

import UIKit
import Moya


class BusinessNewsTableViewController: UITableViewController , UITabBarControllerDelegate{
    var newsInfos  = [Article]()
    var businessInfos : [Article]?
    
    @IBOutlet var newsListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        getNews()
    }
    
    
    fileprivate func getNewsInfoFromServer() -> Cancellable {
        return MoyaProvider<NewsAPI>(plugins: [NetworkLoggerPlugin(verbose: true)]).request(.getNewsInfo("Kr", "business", "04871c167cfb4a3c9c18b9d170d8ba7f")) { result in
            switch result {
            case .success (let response) :
                do {
                    let result = try! JSONDecoder().decode(NewsResponse.self, from: response.mapString().data(using: .utf8)!)
                    if let articles = result.articles{
                        self.businessInfos = articles
                        self.newsInfos = articles
                    }
                    self.newsListView.reloadData()
                } catch MoyaError.statusCode(let errorResponse){
                    print(errorResponse)
                } catch {
                    print("exception")
                }
            case .failure (let error):
                print(error)
            }
        }
    }
    
    func getNews(){
        if businessInfos != nil {
            newsInfos = businessInfos!
            newsListView.reloadData()
        } else {
            getNewsInfoFromServer()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsInfos.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "newsCell") as? NewsTableViewCell
        cell.configurateTheCell(info : self.newsInfos[indexPath.row])
        return cell!
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsDetail" {
            let indexPath = self.tableView!.indexPathForSelectedRow
            let destinationViewController: DetailedNewsViewController = segue.destination as! DetailedNewsViewController
            destinationViewController.detailedNewsLink = self.newsInfos[(indexPath?.row)!].url
        }
    }
}
