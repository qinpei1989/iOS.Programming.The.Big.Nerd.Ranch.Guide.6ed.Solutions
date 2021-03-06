//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by Pei Qin on 08/07/2017.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var dateTaken: NSDate?
    @NSManaged public var photoID: String?
    @NSManaged public var remoteURL: NSURL?
    @NSManaged public var title: String?
    @NSManaged public var viewCount: Int64

}
