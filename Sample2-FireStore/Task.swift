//
//  Task.swift
//  Sample2-FireStore
//
//  Created by keiji yamaki on 2021/01/04.
//

import Foundation
import Firebase
import Ballcap

final class Task: Object, DataRepresentable, DataListenable, ObservableObject, Identifiable {
    typealias ID = String

    override class var name: String { "tasks" }

    struct Model: Modelable, Codable {
        // Taskのタイトル
        var title: String = ""
        // Taskの期限
        var due: ServerTimestamp?
        var isCompleted = false
    }
    // Cloud FirestoreのField dataを保持する
    @Published var data: Task.Model?
    // Cloud FirestoreのField dataの変更を監視する
    var listener: ListenerRegistration?
}
