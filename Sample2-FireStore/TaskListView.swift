//
//  TaskListView.swift
//  Sample2-FireStore
//
//  Created by keiji yamaki on 2021/01/04.
//

import SwiftUI
import Ballcap

struct TaskListView: View {

    enum Presentation: View, Hashable, Identifiable {
        var id: Presentation { self }   // idを追加　yamaki
        case new
        case edit(task: Task)
        var body: some View {
            switch self {
            case .new: return  AnyView(EditTaskView(task: Task()))
            case .edit(let task): return AnyView(EditTaskView(task: task))
            }
        }
    }

    @State var presentation: Presentation?

    @State var tasks: [Task] = []

    let dataSource: DataSource<Task> = Task.order(by: "updatedAt").dataSource()

    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    VStack {
                        Text(task[\.title])
                    }
                    .contextMenu {
                        Button("完了") {
                            task[\.isCompleted] = true
                            task.update()
                        }
                        Button("編集") {
                            self.presentation = .edit(task: task)
                        }
                        Button("削除") {
                            task.delete()
                        }
                    }
                }
            }
            .onAppear {
                self.dataSource
                    .retrieve(from: { (_, snapshot, done) in
                        let task: Task = try! Task(snapshot: snapshot)
                        done(task)
                    })
                    .onChanged({ (_, snapshot) in
                        self.tasks = snapshot.after
                    })
                    .listen()
            }
            .sheet(item: self.$presentation) { $0 }
            .navigationBarTitle("Todo")
            .navigationBarItems(trailing: Button("追加") {
                self.presentation = .new
            })

        }
    }
}

struct NewTaskView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject(initialValue: Task()) var task: Task

    var body: some View {
        NavigationView {
            TextField("新しいタスク", text: self.$task[\.title])
            .navigationBarTitle("新しいタスク")
            .navigationBarItems(trailing: Button("保存") {
                self.task.save()
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct EditTaskView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var task: Task

    var body: some View {
        NavigationView {
            TextField("新しいタスク", text: self.$task[\.title])
                .padding()
                .navigationBarTitle("新しいタスク")
                .navigationBarItems(trailing: Button("保存") {
                    self.task.save()
                    self.presentationMode.wrappedValue.dismiss()
                })
        }
    }
}

