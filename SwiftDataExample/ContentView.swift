//
//  ContentView.swift
//  SwiftDataExample
//
//  Created by Eugene Demenko on 03.12.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @State private var isShowingItemSheet = false
    @Query(filter: #Predicate<Expense> {$0.value > 1000 }, sort: \Expense.date)
    var expanses: [Expense] = []
    @State private var expenseToEdit: Expense?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expanses) { item in
                    ExpanseCell(expanse: item)
                        .onTapGesture {
                            expenseToEdit = item
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(expanses[index])
                    }
                }
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet, content: {
                AddExpenseSheet()
            })
            .sheet(item: $expenseToEdit) {  expense in
                UpdateExpenseSheet(expense: expense)
            }
            .toolbar {
                if !expanses.isEmpty{
                    Button("Add Expanse", systemImage: "plus"){
                        isShowingItemSheet = true
                    }
                }
            }
            .overlay {
                if expanses.isEmpty {
                    ContentUnavailableView(label : {
                        Label("No Expanses", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("start adding expenses to see your list.")
                    }, actions: {
                        Button("Add Expanses"){isShowingItemSheet = true}
                    })
                    .offset(y: -60)

                }
            }
        }
    }
    
    
}

struct ExpanseCell: View{
    let expanse: Expense
    
    var body: some View {
        HStack{
            Text(expanse.date, format: .dateTime.month(.abbreviated).day())
                .frame(width: 70, alignment: .leading)
            Text(expanse.name)
            Spacer()
            Text(expanse.value, format: .currency(code: "UAH"))
        }
    }
}
struct AddExpenseSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var value: Double = 0
    
    var body: some View{
        NavigationStack {
            Form {
                TextField("Expense Name", text: $name)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Value", value: $value, format: .currency(code: "UAH"))
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let expense = Expense(name: name, date: date, value: value)
                        context.insert(expense)
                        dismiss()
                    }
                }
            }
        }
    }
    
}


struct UpdateExpenseSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var expense: Expense

    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense Name", text: $expense.name)
                DatePicker("Date", selection: $expense.date, displayedComponents: .date)
                TextField("Value", value: $expense.value, format: .currency(code: "UAH"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Update Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Done") {
                        // Update your expense object here if needed
                        dismiss()
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
