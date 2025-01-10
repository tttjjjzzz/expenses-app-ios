//
//  sheetView.swift
//  expenses2
//
//  Created by Tiger Zhou on 2024-12-28.
//

//
//  sheetView.swift
//  expensesGT
//
//  Created by Tiger Zhou on 2024-12-27.
//

//work on dynamic padding and spacing for lining up column

import SwiftUI

struct SheetView: View {
    @Binding var sheet: Sheet
    @Environment(\.presentationMode) var presentationMode
    @State private var showStats = false
    @State private var showingAddExpense = false
    @State private var showingDatePicker = false
    @State private var showingStats = false
    @State private var newExpenseAmount: String = ""
    @State private var newExpenseDate: Date = Date()
    @State private var newExpenseCategory: String = "Groceries"
    let categories = ["Groceries", "Transport", "Rent", "Entertainment", "Other"]
    
    @State private var selectedDate = Date()
    
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack {
                
                Text(sheet.name)
                    .font(.system(size:28))
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 15)
                
                List {
                    ForEach(sheet.sortedExpenses) { expense in
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(red: 60/255, green: 60/255, blue: 60/255))
                                .frame(width: 375, height: 100)
                            
                            HStack {
                                ZStack{
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(15)
                                    Image(systemName: expense.iconName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(Color.white)
                                }
                                // Spacer()
                                VStack(alignment: .leading){
                                    Text(expense.category)
                                        .foregroundColor(Color.white)
                                    Text("\(expense.date, formatter: dateFormatter)")
                                        .foregroundColor(Color(red: 150/255, green: 150/255, blue: 150/255))
                                    
                                }
                                .frame(maxWidth:.infinity, alignment:.leading)
                                .padding(.leading,10)
                                
                                
                                //Spacer()
                                Text("$\(expense.amount, specifier: "%.2f")")
                                    .foregroundColor(Color.white)
                                    .padding(.trailing, 10)
                                
                            }
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10))
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        
                        
                    }
                    .onDelete(perform: deleteExpense)
                    .listRowBackground(Color.black)
                    
                    
                }
                .listStyle(PlainListStyle())
                
                //.scrollContentBackground(Color.black)
                // .background(Color.black)
                
                HStack{
                    
                    Button (action:{
                        showStats = true
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(red: 60/255, green: 60/255, blue: 60/255))
                                .frame(width: 160, height: 60)
                            Text("View Summary")
                                .font(.title3)
                                .foregroundColor(Color.white)
                        }
                        .padding(10)
                    }
                    .fullScreenCover(isPresented: $showStats){
                        ZStack{
                            Color.black
                                .ignoresSafeArea()
                            VStack{
                                ZStack{
                                    Button {
                                        showStats = false
                                    } label: {
                                        HStack{
                                            Image(systemName: "chevron.left")
                                                .foregroundColor(Color.white)
                                            Text("Back")
                                                .font(.title2)
                                                .foregroundColor(Color.white)
                                            
                                        }
                                        .padding(.leading,7)
                                        Spacer()
                                    }
                                    .padding(.leading,10)
                        
                                    Text("Summary")
                                        .font(.system(size: 24))
                                        .foregroundColor(Color.white)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.top,1)
                                }
            
                               
                                    
                                    List{
                                    
                                        HStack{
                                            Text("Total Spent:")
                                                .foregroundColor(Color.white)
                                                .font(.title)
                                            Text("$\(String(sheet.totalAmount(type:"total")))")
                                                .foregroundColor(Color.white)
                                                .font(.title)
                                        }
                                        .listRowBackground(Color.black)
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                                        
                                        HStack{
                                            Text("Monthly Avg:")
                                                .foregroundColor(Color.white)
                                                .font(.title)
                                            Text("$\(String(sheet.monthAvg(type:"total")))")
                                                .foregroundColor(Color.white)
                                                .font(.title)
                                        }
                                        .listRowBackground(Color.black)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                        
                                        
                                        sheetSummaryCatElements(title: "Groceries", iconName: "carrot", total: sheet.totalAmount(type: "Groceries"), monthAvg: sheet.monthAvg(type: "Groceries"))
                                            .listRowBackground(Color.black)
                                        sheetSummaryCatElements(title: "Transport", iconName: "car", total: sheet.totalAmount(type: "Transport"), monthAvg: sheet.monthAvg(type: "Transport"))
                                            .listRowBackground(Color.black)
                                        sheetSummaryCatElements(title: "Rent", iconName: "house", total: sheet.totalAmount(type: "Rent"), monthAvg: sheet.monthAvg(type: "Rent"))
                                            .listRowBackground(Color.black)
                                        sheetSummaryCatElements(title: "Rent", iconName: "film", total: sheet.totalAmount(type: "Entertainment"), monthAvg: sheet.monthAvg(type: "Entertainment"))
                                            .listRowBackground(Color.black)
                                        sheetSummaryCatElements(title: "Rent", iconName: "option", total: sheet.totalAmount(type: "Other"), monthAvg: sheet.monthAvg(type: "Other"))
                                            .listRowBackground(Color.black)
                                        
                                        
                                    }
                                    .listStyle(PlainListStyle())
                                    
                                    
                                    
                                }
                            
                        }
                    }

                    
                    
                    
                    Button(action:{
                        showingAddExpense = true
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(red: 60/255, green: 60/255, blue: 60/255))
                                .frame(width: 160, height: 60)
                            Text("Add Expense")
                                .font(.title3)
                                .foregroundColor(Color.white)
                        }
                        .padding(10)
                    }
                    .fullScreenCover(isPresented: $showingAddExpense) {
                        ZStack{
                        
                        //Color(Color(red: 60/255, green: 60/255, blue: 60/255))
                            Color.black
                               .ignoresSafeArea()
                            VStack {
                                Image(systemName: "dollarsign.arrow.trianglehead.counterclockwise.rotate.90")
                                    .resizable()
                                    .foregroundColor(Color.white)
                                    .frame(width: 170, height: 150)
                                    .padding(.top,30)
                                Text("Add New Expense")
                                    .font(.system(size: 34))
                                    .foregroundColor(Color.white)
                                    .padding(10)
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(Color(red: 60/255, green: 60/255, blue: 60/255)))
                                        .frame(width: 250, height: 50)
                                    
                                    TextField("Amount", text: $newExpenseAmount)
                                        .padding(.horizontal,20)
                                        .font(.title)
                                        .frame(width:250)
                                        .keyboardType(.decimalPad)
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.center)
                                        .overlay(
                                            Text("Amount")
                                                .foregroundColor(Color.white.opacity(0.5)) // Lighter color for placeholder
                                            //.padding(.leading, 20)
                                                .opacity(newExpenseAmount.isEmpty ? 1 : 0) // Show placeholder only if the TextField is empty
                                                .font(.title2)
                                        )
                                    
                                }
                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 20, trailing: 0))
                                
                                
                                
                                
                                Picker("Category", selection: $newExpenseCategory) {
                                    ForEach(categories, id: \.self) { category in Text(category)
                                            .foregroundColor(Color.white)
                                            .font(.title)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .background(Color(red: 60/255, green: 60/255, blue: 60/255))
                                .frame(width:250,height:125)
                                .cornerRadius(15)
                                .clipped()
                                .padding(.bottom,8)
                                
                                DatePicker("Select Date", selection: $newExpenseDate, displayedComponents: .date)
                                    .datePickerStyle(WheelDatePickerStyle())
                                    .labelsHidden()
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color(Color(red: 60/255, green: 60/255, blue: 60/255)))
                                            .padding()
                                    )
                                    .colorScheme(.dark)
                                
                                
                                Spacer()
                                
                                
                                HStack{
                                    
                                    Button() {
                                        showingAddExpense = false
                                    } label:{
                                        ZStack{
                                            RoundedRectangle(cornerRadius:15)
                                                .fill(Color(red: 60/255, green: 60/255, blue: 60/255))
                                                .frame(width:150, height:60)
                                            Text("Cancel")
                                                .font(.title3)
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                    .padding(10)
                                    
                                    
                                    Button() {
                                        addExpense()
                                    } label:{
                                        ZStack{
                                            RoundedRectangle(cornerRadius:15)
                                                .fill(Color(red: 60/255, green: 60/255, blue: 60/255))
                                                .frame(width:150, height:60)
                                            Text("Add Expense")
                                                .font(.title3)
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                    .padding(10)
                                
                            }
                            
                            
                            
                            
                        }
                    }
                }
            }
                    
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton())
            //.navigationTitle("dad")
            
        }
        

    }
        
    
    private func addExpense() {
        var icon: String = ""
        guard let amount = Double(newExpenseAmount), !newExpenseCategory.isEmpty else { return }
        //"Groceries", "Transport", "Rent", "Entertainment", "Other"
        switch newExpenseCategory {
        case "Groceries":
            icon = "carrot"
        case "Transport":
            icon = "car"
        case "Rent":
            icon = "house"
        case "Entertainment":
            icon = "film"
        case "Other":
            icon = "option"
        default:
            icon = ""
        }
        
        let newExpense = Expense(date: newExpenseDate, amount: amount, category: newExpenseCategory, iconName: icon)
        sheet.expenses.append(newExpense)
    
        newExpenseAmount = ""
        newExpenseCategory = ""
        showingAddExpense = false
    }
    
    private func deleteExpense(at offsets: IndexSet) {
        sheet.expenses.remove(atOffsets: offsets)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    private func dismiss(){
        showingAddExpense = false
        
    }
    
    
    private func backButton() -> some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss() // Dismiss the view
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.white)
                Text("Back")
                    .font(.title2)
                    .foregroundColor(Color.white)
            }

        }
    }
    
    
    
    
    
}






#Preview {

    var sampleSheet = Sheet(name: "cad term 1 2025")
    sampleSheet.expenses = [
        Expense(date: Date(), amount: 3233, category: "Groceries", iconName: "carrot"),
        Expense(date: Date(), amount: 0.50, category: "Transport", iconName: "carrot"),
        Expense(date: Date(), amount: 45.00, category: "Utilities", iconName: "carrot")
    ]
    
    return NavigationView {
        SheetView(sheet: .constant(sampleSheet))
    }
    
}
