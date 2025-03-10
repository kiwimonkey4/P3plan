import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("APP NAME + LOGO")
                .font(.system(size: 35, weight: .heavy, design: .default))
            
            Button("SCAN"){
                //Execute code
            }
            .font(.system(size: 125, weight: .heavy, design: .default))
            .foregroundStyle(.black)
            .frame(width:400, height: 400)
            .background(Color(red:0.223, green:1, blue:0.0784))
            .cornerRadius(15)
            
            Button("SETT-INGS"){
                //Execute code
            }
            .font(.system(size: 125, weight: .heavy, design: .default))
            .foregroundStyle(.black)
            .frame(width:400, height: 400)
            .background(Color(red:1, green:0, blue:0.192))
            .cornerRadius(15)
            
        }
    }
}
