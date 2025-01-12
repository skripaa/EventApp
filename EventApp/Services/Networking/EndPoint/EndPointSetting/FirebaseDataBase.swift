//
//  FirebaseDataBase.swift
//  EventApp 1
//
//  Created by Vova SKR on 05/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation

enum Request {
    
    case getUserData
    case putNewData(data: EventModel, currentDate: Int)
    case deleteData(index: Int)
}
