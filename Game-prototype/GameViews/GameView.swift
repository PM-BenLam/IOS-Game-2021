
import SpriteKit
import SwiftUI

// A sample SwiftUI creating a GameScene and sizing it
// at 300x400 points

var gameIsPaused = false

struct GameView: View
{
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @Binding var currentPage: Page

    
    var scene: SKScene
    {
        
        let scene = GameScene()
        scene.size = CGSize(width: 400, height: 300)
        scene.scaleMode = .aspectFill
        return scene
        
    }
    
        
    var body: some View
    {
        Group
        {
            if horizontalSizeClass == .compact && verticalSizeClass == .regular
            {
                
                Text("請把裝置橫放，以獲得最佳的遊戲體驗")
                    .font(.title)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            }
            else
            {
                ZStack
                {
                    SpriteView(scene: scene)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    VStack
                    {
                        HStack
                        {
                            Text("離開遊戲")
                                .padding(10)
                                .background(Color.init(red: 0.7, green: 0.7, blue: 0.7, opacity: 0.3))
                                .foregroundColor(.black)
                                .cornerRadius(5)
                                .shadow(radius: 10)
                                .padding([.leading], 25)
                                .padding([.top], 15)
                                .onTapGesture { withAnimation { currentPage = .mainMenu } }
                            
                            Spacer()
                        }
                        
                        HStack
                        {
                            Text("停止/繼續遊戲")
                                .padding(10)
                                .background(Color.init(red: 0.7, green: 0.7, blue: 0.7, opacity: 0.3))
                                .foregroundColor(.black)
                                .cornerRadius(5)
                                .shadow(radius: 10)
                                .padding([.leading], 25)
                                .padding([.top], 15)
                                .onTapGesture
                                {
                                    if gameIsPaused
                                    {
                                        gameIsPaused = false
                                    } else
                                    {
                                        gameIsPaused = true 
                                    }
                                }
                            
                            Spacer()
                        }
                        Spacer()
                    }
                    
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(lightBlue)
        .edgesIgnoringSafeArea([.all])
        
    }
}
