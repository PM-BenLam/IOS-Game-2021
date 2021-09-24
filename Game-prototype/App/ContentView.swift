

import SwiftUI
import SpriteKit

let lightBlue = Color.init(red: 0.6, green: 0.9, blue: 1)
let darkGreen = Color.init(red: 0.1, green: 0.5, blue: 0.3)

struct ContentView: View
{
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @ObservedObject var gameManager = GameManager.sharedInstance
    
    @State var cautionAccepted = false
    
    var scene1: SKScene
    {
        let scene1 = Level1()
        scene1.size = CGSize(width: 400, height: 300)
        scene1.scaleMode = .aspectFill
        return scene1
    }
    
    
    var sceneView: some View
    {
        SpriteView(scene: scene1)
    }
    
    
    var body: some View
    {
        if !cautionAccepted
        {

            VStack
            {
                Text("在進入遊戲前，建議您把裝置橫放，以獲得最佳的遊戲體驗")
                    .font(.title)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Button(action: {cautionAccepted = true})
                { Text("開始遊戲")
                        .font(.largeTitle)
                        .padding(10)
                        .background(Color.init(red: 0.7, green: 0.7, blue: 0.7, opacity: 0.3))
                        .foregroundColor(.black)
                        .cornerRadius(5)
                        .shadow(radius: 10)
                        .padding()
                }
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(lightBlue)
           
            
            
        } else
        {
            if !gameManager.gameIsOver && !gameManager.gameWon
            {
                Group
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
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(lightBlue)
                    .edgesIgnoringSafeArea([.all])
                 
            }
            else if gameManager.gameIsOver
            {
                GameOver()
            } else if gameManager.gameWon
            {
                GameWon()
            }
        }
        
        
        
    }
    
    
}

