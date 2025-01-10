//
//  sheetSummaryCatElements.swift
//  expenses2
//
//  Created by Tiger Zhou on 2025-01-04.
//

import SwiftUI

struct sheetSummaryCatElements: View {
    
    var title: String
    var iconName: String
    var total: Double
    var monthAvg: Double
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: 60/255, green: 60/255, blue: 60/255))
                .frame(width:375, height:150)
            
            HStack{
                
                  
                ZStack{
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 90, height: 90)
                        .cornerRadius(15)
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)
                        .foregroundColor(Color.white)
                }
                
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Total:")
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.trailing)
                        .underline()
                    Text(String(format: "$%.2f", total))
                        .font(.title2)
                        .foregroundColor(Color(red: 200/255, green: 200/255, blue: 200/255))
                        .multilineTextAlignment(.trailing)
                    Text("Monthly Average:")
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.trailing)
                        .underline()
                    Text(String(format: "$%.2f", monthAvg))
                        .font(.title2)
                        .foregroundColor(Color(red: 200/255, green: 200/255, blue: 200/255))
                        .multilineTextAlignment(.trailing)
                    
                    
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                .fixedSize(horizontal: true, vertical: false)
                
               
            }
            
            
            
        }
        
    }
}

#Preview {
    sheetSummaryCatElements(title:"Rent", iconName: "house", total: 4443323.33, monthAvg: 323)
}
