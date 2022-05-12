//
//  APICollectionViewCell.swift
//  TasksDay1
//
//  Created by Rehan Shah on 09/05/2022.
//

import UIKit

class APICollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var border: UIView!
    @IBOutlet weak var B2view: UIView!
    @IBOutlet weak var network: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var slug: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var sale_com: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        border.layer.cornerRadius = 10
        border.layer.borderWidth = 1
        
        B2view.layer.cornerRadius = 10
        B2view.layer.borderWidth = 1
        
    }
    
    func coreData(data: CoreDataTask)
    {
        let url = NSURL(string: data.date!)
        let Dataurl = NSData(contentsOf: url! as URL)
        img.image = UIImage(data: Dataurl! as Data)
        
        name.text = data.name
        slug.text = data.education
    }
    
    
    
    func populateCell(data: DataModel)
    {
        let url = NSURL(string: data.imageUrl)
        let Dataurl = NSData(contentsOf: url! as URL)
        img.image = UIImage(data: Dataurl! as Data)
        
        name.text = data.title
        slug.text = data.decription
        network.text = data.network
        
    }
    
    
    func cashBack(cash: Cashback)
    {
        sale_com.text = cash.cashbackAmount
        detail.text = cash.cashbackName
    }
    
    func storeData(str: StoreModel)
    {
       // populateCell(data: str.store)
    }
}
