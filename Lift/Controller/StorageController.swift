//
//  StorageController.swift
//  Lift
//
//  Created by Richard Hughes on 06/06/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

/*
class StorageController {
private let documentsDirectoryURL = FileManager.default
 .urls(for: .documentDirectory, in: .userDomainMask)
 .first!

private var accountsFileURL: URL {
 return documentsDirectoryURL
 .appendingPathComponent("Groups")
 .appendingPathExtension("json")
 }

func save(_ groups: [Group]) {
 let encoder = JSONEncoder()
 guard let data = try? encoder.encode(accounts) else { return }
 try? data.write(to: accountsFileURL)
 }
 
func fetchGroups() -> [Group] {
 guard let data = try? Data(contentsOf: accountsFileURL) else { return [] }
 let decoder = JSONDecoder()
 let accounts = try? decoder.decode([Account].self, from: data)
 return accounts ?? []
 }
}
 
 
 */
