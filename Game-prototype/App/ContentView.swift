

import SwiftUI
import SpriteKit

let lightBlue = Color.init(red: 0.5, green: 0.5, blue: 0.5)

struct ContentView: View
{
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @ObservedObject var gameManager = GameManager.sharedInstance
    
    var scene1: SKScene
    {
        let scene1 = Level1()
        scene1.size = CGSize(width: 400, height: 300)
        scene1.scaleMode = .aspectFill
        return scene1
    }
    
    var scene2: SKScene
    {
        let scene2 = Level2()
        scene2.size = CGSize(width: 400, height: 300)
        scene2.scaleMode = .aspectFill
        return scene2
    }
    
    var sceneView: some View
    {
        switch gameManager.gameLevel
        {
        case 1:
            return SpriteView(scene: scene1)
        case 2:
            return SpriteView(scene: scene2)
        default:
            return SpriteView(scene: scene1)
        }
        
    }
    
    var body: some View
    {
        if !gameManager.gameIsOver
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
                    
                        sceneView
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        VStack
                        {
                            
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
                                        if GameScene.gameIsPaused
                                        {
                                            GameScene.gameIsPaused = false
                                        } else
                                        {
                                            GameScene.gameIsPaused = true
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
        else
        {
            GameOver()
        }
        
        
    }
    
}

