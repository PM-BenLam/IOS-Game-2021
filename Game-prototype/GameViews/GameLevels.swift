import Foundation
import SpriteKit
import SwiftUI

class Level1: GameScene
{
    override func didMove(to view: SKView)
    {
        super.didMove(to: view)
        
        createLevelMap(fileName: "Level1", tileMapName: "Level1")
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        super.update(currentTime)
        
        if let portalSprite = portal as? SKSpriteNode
        {
            if portalSprite.contains(player.position)
            {
                gameManager.gameLevel = 2
            }
        }
    }
}

class Level2: GameScene
{
    override func didMove(to view: SKView)
    {
        super.didMove(to: view)
        
        createLevelMap(fileName: "Level2", tileMapName: "Level2")
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        super.update(currentTime)
        
        if player.position.y < 50
        {
            gameManager.gameIsOver = true
        }
    }
}
