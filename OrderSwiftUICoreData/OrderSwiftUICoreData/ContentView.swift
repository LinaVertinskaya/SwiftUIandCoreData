//
//  ContentView.swift
//  OrderSwiftUICoreData
//
//  Created by Лина Вертинская on 2.08.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: Order.getAllOrders()) var orders: FetchedResults<Order>

    @State private var newOrder = ""

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("NewOrder")) {
                    HStack {
                        TextField("New order", text: $newOrder)
                        Button(action: {
                            let order = Order(context: self.viewContext)
                            order.drink = self.newOrder
                            order.createdAt = Date()
                            do {
                                try self.viewContext.save()
                            } catch {
                                print(error)
                            }
                            newOrder = ""
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                        })
                    }
                }
                Section(header: Text("Your Orders")) {
                    ForEach(self.orders, id: \.self) { order in
                        OrderItemView(drink: order.drink, createdAt: "\(order.createdAt)")
                    }.onDelete(perform: removeOrder)
                }
            }.navigationTitle(Text("Order View"))
                .navigationBarItems(trailing: EditButton())
        }
    }

    func removeOrder(at offsets: IndexSet) {
        for index in offsets {
            let man = orders[index]
            viewContext.delete(man)
            do {
                try self.viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}

struct OrderItemView: View {

    var drink: String = ""
    var createdAt: String = ""

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(drink).font(.headline)
                Text(createdAt).font(.caption)
            }
        }
    }
}

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
