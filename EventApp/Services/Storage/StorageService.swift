//
//  StorageService.swift
//  EventApp
//
//  Created by Vova Skripnichenko on 17.01.2022.
//  Copyright © 2022 Vova SKR. All rights reserved.
//

import Foundation

protocol StorageServiceProtocol {
    
    func getSavedEvents() -> [EventModel]
       
    func insert(event: EventModel, at index: Int)
    
    func append(event: EventModel?)
    
    func remove(event: EventModel?)
       
    func updateSavedEvents(newList: [EventModel])
    
    func isEventSaved(event: EventModel?) -> Bool
}

final class StorageService: StorageServiceProtocol {
    
    private var eventsList: [EventModel] = []
    
    func getSavedEvents() -> [EventModel] {
        
        eventsList
    }
    
    func insert(event: EventModel, at index: Int) {
        
        eventsList.insert(event, at: index)
    }
    
    func append(event: EventModel?) {
        
        guard let event = event else {
            return
        }
        
        eventsList.append(event)
    }
    
    func remove(event: EventModel?) {
        
        guard let index = eventsList.firstIndex(where: { $0.id == event?.id }) else {
            return
        }
        
        eventsList.remove(at: index)
    }
    
    func updateSavedEvents(newList: [EventModel]) {
        
        eventsList = newList
    }
    
    func isEventSaved(event: EventModel?) -> Bool {
        
        guard let event = event else {
            return false
        }
        
        return eventsList.contains { $0.id == event.id }
    }
}
