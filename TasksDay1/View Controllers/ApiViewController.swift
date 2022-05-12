//
//  ApiViewController.swift
//  TasksDay1
//
//  Created by Rehan Shah on 09/05/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD


class ApiViewController: UIViewController {

    @IBOutlet weak var Clview: UICollectionView!
    @IBOutlet weak var search: UISearchBar!
    
    var imgdata = [String]()
    var networkA = [String]()
    var nameA = [String]()
    var slgA = [String]()
    var s_comA = [String]()
    var detailA = [String]()
    var searchText : String = ""
    
    var info = [DataModel]()
    var cashModel = [Cashback]()
    var coreDataArray = [CoreDataTask]()
    var Check = false
    
    var store = [StoreModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let loader = MBProgressHUD.showAdded(to: view, animated: true)

        //ApiCall()
//        coreDataArray = Database.shareinstance.GetData()
//
//        if coreDataArray.isEmpty
//        {
//            print(coreDataArray.count)
//            Check = true
//            let service = Services()
//            service.GetAllData { [self] result in
//                switch result {
//                case .failure(let error):
//                    print(error)
//
//                case .success(let value):
//                    DispatchQueue.main.async {
//                        self.info.append(contentsOf: value)
//                        print(info)
//                        self.Clview.reloadData()
//                    }
//
//                }
//                loader.hide(animated: true)
//            }
//        }
//        else
//        {
//            self.Clview.reloadData()
//            loader.hide(animated: true)
//        }
        
        let service = Services()
        service.GetPageData { [self] result in
            switch result {
            case .failure(let error):
                print(error)

            case .success(let value):
                DispatchQueue.main.async {
                    self.store.append(contentsOf: value)
                    print(store)
                    print(info)
                    self.Clview.reloadData()
                }

            }
            loader.hide(animated: true)
        }
        
        
        Clview.delegate = self
        Clview.dataSource = self
        
        search.delegate = self
        
    }
    
    
    
   
    
    func SearchApi()
    {
        let Urlreq = URL(string : "https://trscashback.tk/api/featured_cashback")
        
        
        let hd: HTTPHeaders = [
            "X-Requested-With" : "XMLHttpRequest",
            "Accept" : "application/json"
        ]
        
        //   let hud = MBProgressHUD.showAdded(to: view, animated: true)
        Alamofire.request(Urlreq!, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: hd).responseJSON { [self] (response) in
            
            switch response.result{
            
            case .success(_):
                print(response.result)
                
                let result = try? JSON(data: response.data!)
                
                let Data = result!["data"]
                
                self.imgdata.removeAll()
                self.networkA.removeAll()
                self.nameA.removeAll()
                self.slgA.removeAll()
                self.s_comA.removeAll()
                self.detailA.removeAll()
                
                for i in Data.arrayValue{
                    
                    let nam = i["name"].stringValue
                    print(nam)
                    print(self.searchText)
                    var nsearch = [String]()
                    nsearch.append(nam)
                    let matchingTerms = nsearch.filter({
                        $0.range(of: self.searchText, options: .caseInsensitive) != nil
                    })
                    print(matchingTerms)
                    if matchingTerms.contains(nam)
                    {
                        
                        
                        let image = i["logo"].stringValue
                        let net = i["network"].stringValue
                        let slg = i["slug"].stringValue
                        
                        
                        let cash = i["cashbacks"]
                        for i in cash.arrayValue
                        {
                            let com = i["sale_commission"].stringValue
                            let det = i["detail"].stringValue
                            
                            //MARK:- Append Data
                            s_comA.append(com)
                            detailA.append(det)
                        }
                        
                        //MARK:- Append Data
                        imgdata.append(image)
                        networkA.append(net)
                        nameA.append(nam)
                        slgA.append(slg)
                        
                    }
                    else
                    
                    {
                      print("NO")
                    }
                    
                }
                DispatchQueue.main.async{
                    
                    self.Clview.reloadData()
                }
            case .failure(_):
                print(response.result)
            }
        }
    }
    

}
extension ApiViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.count
//        if Check == true
//        {
//            return info.count
//        }
//        else
//        {
//            return coreDataArray.count
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = Clview.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! APICollectionViewCell
        
//        if Check == true
//        {
//        let apiData = info[indexPath.row]
//        cell.populateCell(data: apiData)
//   //     cell.detail.text = apiData.cashback[indexPath.row].cashbackName
//        cell.cashBack(cash: apiData.cashback[indexPath.row])
//        }
//        else
//        {
//            let apiData = coreDataArray[indexPath.row]
//            cell.coreData(data: apiData)
//        }
       
        let data = store[indexPath.row]
        cell.detail.text = data.store[indexPath.row].cashback[indexPath.row].cashbackName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let CV = Clview.bounds.width
        return CGSize(width: CV/10, height: 234)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)
//    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//            let size = CGSize(width: Clview.frame.width, height: Clview.frame.height)
//            return size
//        }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var NumberOfRows = 20
        if NumberOfRows >= indexPath.row
        {
            // call API
            // add data to array
            // reload collectionview
            //  NumberOfRows == TableDataArray.count
            NumberOfRows = indexPath.row+1
        }
    }
    
}
extension ApiViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        self.searchText = searchText
        if searchText.isEmpty
        {

            let service = Services()
            service.GetAllData { [self] result in
                switch result {
                case .failure(let error):
                    print(error)

                case .success(let value):
                    DispatchQueue.main.async {
                        self.info = value
                        print(info)
                        self.Clview.reloadData()
                    }
                   
                }
            }
        }
        else
        {
        print(searchText)
            SearchApi()
        }
    }
}
