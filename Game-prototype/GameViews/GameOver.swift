
import Foundation
import SwiftUI

struct GameOver: View
{
    @Binding var currentPage: Page
    
    let gameManager = GameManager.sharedInstance
    
    var body: some View
    {
        VStack(spacing: 25)
        {
            Text("Game Over")
                .font(.system(size: 50, design: .monospaced))
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding([.top, .bottom], 40)
                .padding([.trailing, .leading], 25)
            
            Text("回到主頁")
                .font(.title)
                .padding(10)
                .background(Color.init(red: 0.7, green: 0.7, blue: 0.7, opacity: 0.3))
                .foregroundColor(.black)
                .cornerRadius(5)
                .shadow(radius: 10)
                .onTapGesture
                {
                    gameManager.reset()
                    withAnimation { currentPage = .mainMenu }
                    
                }
            
            Text("重新遊玩")
                .font(.title)
                .padding(10)
                .background(Color.init(red: 0.7, green: 0.7, blue: 0.7, opacity: 0.3))
                .foregroundColor(.black)
                .cornerRadius(5)
                .shadow(radius: 10)
                .onTapGesture {
                    gameManager.reset()
                    withAnimation
                    {
                        currentPage = .gameView
                    }
                }
       
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(lightBlue)
        .edgesIgnoringSafeArea([.all])
       
    }
}
