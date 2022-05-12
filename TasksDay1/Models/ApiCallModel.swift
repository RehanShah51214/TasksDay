//
//  ApiCallModel.swift
//  TasksDay1
//
//  Created by Rehan Shah on 10/05/2022.
//


struct StoreModel {
    var store: [DataModel]
    var pagination: [Links]
}


struct DataModel {
    var imageUrl: String
    var title: String
    var decription: String
    var network : String
    var cashback: [Cashback]
}

struct Cashback {
    var cashbackName: String
    var cashbackAmount: String
}

struct Links {
    var next: String
}
