import SwiftUI

struct ContentView: View {
    @State private var sheets: [Sheet] = []
   // @State private var newSheetName: String = ""
   // @State private var showingAddSheet = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.black
                    .ignoresSafeArea()
                
                VStack{
                    ZStack{
                        Text("Sheets")
                            .font(.system(size: 28))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top,1)
                        
                        addSheetButtonView(sheets: $sheets, buttonColor: .white)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing,20)
                        /*
                        HStack{
                            Spacer()
                            Button (action:{
                                showingAddSheet = true
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color.white)
                                    .padding(.trailing, 20)
                            }
                        }
                         */
                       
                        
                    }
                    .padding(.bottom, 10)
                    
                    
                    List {
                        ForEach(sheets) { sheet in
                            NavigationLink(destination: SheetView(sheet: $sheets[sheets.firstIndex(where: { $0.id == sheet.id })!])) {
                              
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(red: 60 / 255, green: 60 / 255, blue: 60 / 255))
                                        .overlay(
                                            Text(sheet.name)
                                                .font(.system(size: 24))
                                                .foregroundColor(.white)
                                                .padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 100))
                                                .multilineTextAlignment(.leading)
                                                .frame(maxWidth:.infinity, alignment: .leading)
                                        )
                                        .frame(minHeight:100) // Minimum height
                                    
                                    HStack{
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .resizable()
                                            .frame(width: 15, height: 25)
                                            .foregroundColor(Color.white)
                                           
                                    }
                                    .padding(.trailing, 20)
                                     
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 0))
                                
                                /*
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color(red: 60/255, green: 60/255, blue: 60/255))
                                            .frame(width: 325, height: 50
                                            )
                                        Text(sheet.name)
                                            .font(.system(size: 24))
                                            .foregroundColor(Color.white)
                            
                                          //  .border(Color.black)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 0))
                                 */
                                /*
                                Text(sheet.name)
                                    .font(.system(size:24))
                                    .foregroundColor(Color.white)
                                    .background(Color.gray)
                                    .frame(maxWidth:.infinity, alignment: .leading)
                                 */
                            }
                            .listRowInsets(EdgeInsets())
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .onDelete(perform: deleteSheet)
                        .listRowBackground(Color.black)
                        
                    }
                    .listStyle(PlainListStyle())
                 
                
                }
            
            }
        
            /*
           // .navigationTitle("Expense Sheets")
            .navigationBarItems(trailing: Button(action: {
                showingAddSheet = true
            }) {
                Image(systemName: "plus")
            })
            
            .sheet(isPresented: $showingAddSheet) {
                VStack {
                    TextField("Sheet Name", text: $newSheetName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button("Add Sheet") {
                        addSheet()
                    }
                    .padding()
                }
            }
            */
            
            
            
            
            
        }

        
    }
    
    /*
    private func addSheet() {
        let newSheet = Sheet(name: newSheetName)
        sheets.append(newSheet)
        newSheetName = ""
        showingAddSheet = false
    }
     */
    
    private func deleteSheet(at offsets: IndexSet) {
        sheets.remove(atOffsets: offsets)
    }
}


#Preview {
    ContentView()
}
