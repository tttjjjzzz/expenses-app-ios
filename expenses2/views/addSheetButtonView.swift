//
//  addSheetButtonView.swift
//  expenses2
//
//  Created by Tiger Zhou on 2025-01-09.
//

import SwiftUI

struct addSheetButtonView: View {
    @Binding var sheets: [Sheet]
    @State private var showingAddSheet = false
    @State private var newSheetName: String = ""
   // @State private var newSheet: Sheet
    var buttonColor: Color
    
    var body: some View {
        Button (action:{
            showingAddSheet = true
        }) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(buttonColor)
        }
        .fullScreenCover(isPresented: $showingAddSheet) {
            
            ZStack{
                Color.black
                    .ignoresSafeArea()
                
                VStack{
                    Image(systemName: "list.triangle")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: 125, height: 110)
                        .padding(EdgeInsets(top: 80, leading: 0, bottom: 30, trailing: 0))
                    Text("Add New Sheet")
                        .foregroundColor(Color.white)
                        .font(.system(size:34))
                        .padding(.bottom, 50)
                 
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(Color(red: 60/255, green: 60/255, blue: 60/255)))
                            .frame(width: 250, height: 75)
                        
                        TextField("New Sheet Same", text: $newSheetName)
                            .padding(.horizontal,30)
                            .font(.title)
                            .frame(width:250)
                            .keyboardType(.decimalPad)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .overlay(
                                Text("new sheet name")
                                    .foregroundColor(Color.white.opacity(0.5)) // Lighter color for placeholder
                                //.padding(.leading, 20)
                                    .opacity(newSheetName.isEmpty ? 1 : 0) // Show placeholder only if the TextField is empty
                                    .font(.title2)
                                    
                            )
                           
                    }
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                   
                    HStack{
                        
                        Button() {
                            showingAddSheet = false
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
                            addSheet()
                        } label:{
                            ZStack{
                                RoundedRectangle(cornerRadius:15)
                                    .fill(Color(red: 60/255, green: 60/255, blue: 60/255))
                                    .frame(width:150, height:60)
                                Text("Add Sheet")
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
    
    private func addSheet() {
        let newSheet = Sheet(name: newSheetName)
        sheets.append(newSheet)
        newSheetName = ""
        showingAddSheet = false
    }
    
    
}

/*
 #Preview {
     addSheetButtonView(sheets: $sheets, buttonColor: .black)
 }
 
*/
