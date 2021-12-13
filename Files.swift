//
//  Cards.swift
//  mindMap
//
//  Created by Алина Бондарчук on 10.12.2021.
//

import Foundation

class Files {
    var files = [File]()
    init(files: [File]) {
        self.files = files
    }
}

class File {
    var name: String
    var notes: [CardView]
    init(name: String, notes: [CardView]) {
        self.name = name
        self.notes = notes
    }
}

//class Singleton {
//
//    static var shared: Singleton!
//    private init() {}
//
//    func save(_ files: [File]) {
//        let defaults = UserDefaults.standard
//        let data = files.map { try? JSONEncoder().encode($0)}
//        defaults.set(data, forKey: "saveFiles")
//    }
//
//    func loadData() -> [CardView] {
//        let defaults = UserDefaults.standard
//        guard let encodeData = defaults.array(forKey: "saveFiles") as? [Data] else {
//            return []
//        }
//
//        return encodeData.map { try! JSONDecoder().decode(File.self, from: $0) }
//    }
//}
