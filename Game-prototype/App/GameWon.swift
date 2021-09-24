import Foundation
import SwiftUI

struct GameWon: View
{
    
    let gameManager = GameManager.sharedInstance
    
    var body: some View
    {
        VStack(spacing: 25)
        {
            Text("遊戲完成！")
                .font(.system(size: 50, design: .monospaced))
                .foregroundColor(darkGreen)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding([.top, .bottom], 40)
                .padding([.trailing, .leading], 25)
            
            
            Text("重新遊玩")
                .font(.title)
                .padding(10)
                .background(Color.init(red: 0.7, green: 0.7, blue: 0.7, opacity: 0.3))
                .foregroundColor(.black)
                .cornerRadius(5)
                .shadow(radius: 10)
                .onTapGesture {
                    gameManager.reset()
                }
       
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(lightBlue)
        .edgesIgnoringSafeArea([.all])
       
    }
}
