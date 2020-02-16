//
//  Contacts.swift
//  NashmiClient
//
//  Created by mohamed abdo on 8/21/18.
//  Copyright © 2018 Nashmi. All rights reserved.
//

import Foundation
import CoreData
import Contacts
import UIKit

class ContactsHelper: NSObject {
    private let contactStore = CNContactStore()
    private var list = [CNContact]()
    private var contactsModel: [ContactsResult] = []
  
    override init() {
        super.init()
        self.fetch()
    }
    func fetch(){
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),CNContactImageDataKey , CNContactThumbnailImageDataKey , CNContactPhoneNumbersKey , CNContactGivenNameKey ] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])

        
        do {
            try self.contactStore.enumerateContacts(with: request) { (contact, stop) in
                self.list.append(contact)
                
                let model = ContactsResult()
                
                if contact.imageData != nil {
                    model.imageData = contact.imageData
                }else{
                    let image = #imageLiteral(resourceName: "placeHolder")
                    model.imageData = image.compressedData(quality: 0.1)
                }
                model.name = contact.givenName
                if contact.phoneNumbers.first?.value != nil  {
                    contact.phoneNumbers.forEach({ (phone) in
                        let contactPhone = ContactsResult()
                        contactPhone.imageData = model.imageData
                        contactPhone.name = model.name
                        contactPhone.mobile = phone.value.stringValue
                        self.contactsModel.append(contactPhone)
                    })
                }
                
            }
        }
        catch {
            print("unable to fetch contacts")
        }
    }
    func contacts() -> [ContactsResult] {
        return self.contactsModel
    }
}
