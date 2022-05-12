//
//  ApiServices.swift
//  TasksDay1
//
//  Created by Rehan Shah on 10/05/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class Services {
    
    func ApiCall(_ section: String, completion: @escaping (Result<[DataModel]>) -> Void) {
        
        var model = [DataModel]()
        var CASH = [Cashback]()
        var lnk = [Links]()
        
        let Urlreq = URL(string : Urls.allDataUrl)
        
        let hd: HTTPHeaders = [
            "X-Requested-With" : "XMLHttpRequest",
            "Accept" : "application/json"
        ]
        
        
        Alamofire.request(Urlreq!, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: hd).responseJSON { [self] (response) in
            
            switch response.result{
            
            case .success(_):
                print(response.result)
                
                let result = try? JSON(data: response.data!)
                
                let Data = result!["data"]
                
                for i in Data.arrayValue {
                    
                        let image = i["logo"].stringValue
                        let net = i["network"].stringValue
                        let nam = i["name"].stringValue
                        let slg = i["slug"].stringValue
                        let cash = i["cashbacks"]
                    for i in cash.arrayValue
                    {
                        let com = i["sale_commission"].stringValue
                        let det = i["detail"].stringValue
                        
                      let cashBack = Cashback(cashbackName: det, cashbackAmount: com)
                        CASH.append(cashBack)
                    }
                    
                    let data = DataModel(imageUrl: image, title: nam, decription: slg, network: net, cashback: CASH)
                   // print(data)
                    model.append(data)
                    completion(.success(model))
                    
                    //CoreData
                    let Dict = ["name": nam,"date": image ,"education": slg]
                    Database.shareinstance.Save(object: Dict)
                    
                }
                
                let Link = result!["links"]
                
                let linkData = Link["next"].stringValue
                if linkData.isEmpty
                {
                    print("NO More Data")
                }
                else
                {
                    let data = Links(next: linkData)
                    lnk.append(data)
                }
                
                case .failure(_):
                print(response.result)
            }
        }
    }
    
    func GetAllData(completionHandler: @escaping (Result<[DataModel]>) -> Void) {
        
        ApiCall("DataModel", completion: completionHandler)
    }
    
    
    
    func Pagination(_ section: String, completion: @escaping (Result<[StoreModel]>) -> Void) {
        
        var model = [DataModel]()
        var CASH = [Cashback]()
        var lnk = [Links]()
        var Store = [StoreModel]()
        
        let Urlreq = URL(string : Urls.pagination + "per_page=10")
        
        let hd: HTTPHeaders = [
            "X-Requested-With" : "XMLHttpRequest",
            "Accept" : "application/json"
        ]
        
        
        Alamofire.request(Urlreq!, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: hd).responseJSON { [self] (response) in
            
            switch response.result{
            
            case .success(_):
                print(response.result)
                
                let result = try? JSON(data: response.data!)
                
                let Data = result!["data"]
                
                for i in Data.arrayValue {
                    
                        let image = i["logo"].stringValue
                        let net = i["network"].stringValue
                        let nam = i["name"].stringValue
                        let slg = i["slug"].stringValue
                        let cash = i["cashbacks"]
                    for i in cash.arrayValue
                    {
                        let com = i["sale_commission"].stringValue
                        let det = i["detail"].stringValue
                        
                      let cashBack = Cashback(cashbackName: det, cashbackAmount: com)
                        CASH.append(cashBack)
                    }
                    
                    let data = DataModel(imageUrl: image, title: nam, decription: slg, network: net, cashback: CASH)
                   // print(data)
                    model.append(data)
                    
                }
                
                let Link = result!["links"]
                
                let linkData = Link["next"].stringValue
                if linkData.isEmpty
                {
                    print("NO More Data")
                }
                else
                {
                    let data = Links(next: linkData)
                    lnk.append(data)
                }
                let modelData = StoreModel(store: model, pagination: lnk)
                Store.append(modelData)
                completion(.success(Store))
                
                case .failure(_):
                print(response.result)
            }
        }
    }
    
    func GetPageData(completionHandler: @escaping (Result<[StoreModel]>) -> Void) {
        
        Pagination("StoreModel", completion: completionHandler)
    }
    
    
    
}
