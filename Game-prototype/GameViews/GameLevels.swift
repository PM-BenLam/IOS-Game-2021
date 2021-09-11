import Foundation
import SpriteKit
import SwiftUI

class Level1: GameScene
{
    
    let cone = SKSpriteNode(imageNamed: "detectionCone")
    
    func createCCTVCamera()
    {
        let startingAngle: Double = 120
        CCTVCamera.addChild(cone)
        
        cone.name = "cone"
        cone.position = CGPoint(x: 0, y: 5)
        cone.zPosition = 100
        cone.anchorPoint = CGPoint(x: 1, y: 0)
        cone.zRotation = CGFloat((startingAngle / 180) * Double.pi)
    }
    
    override func didMove(to view: SKView)
    {
        super.didMove(to: view)
        
        createLevelMap(fileName: "Level1", tileMapName: "Level1")
        
        createCCTVCamera()
        
        //showTutorial()
        
        loadBackgroundGIF(withName: "digitalBackground")
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        super.update(currentTime)
        
        rotateCone()
    
        if let portalSprite = portal as? SKSpriteNode
        {
            if portalSprite.contains(player.position)
            {
                gameManager.gameLevel = 2
            }
        }
    }
    
    func rotateCone()
    {
        if let cone = CCTVCamera.childNode(withName: "cone")
        {
            let rotateUp = SKAction.rotate(byAngle: -0.5, duration: 7)
            let rotateDown = SKAction.rotate(byAngle: 0.5, duration: 7)
            let stop = SKAction.wait(forDuration: 4)

            let rotateActions = SKAction.sequence(
            [
                rotateUp,
                stop,
                rotateDown,
                stop
            ])
            if !cone.hasActions()
            {
                cone.run(rotateActions)
        
            }
        
            let coneAngle = cone.zRotation + CGFloat(Double.pi)
            let offsetAngle = CGFloat((25 / 180) * Double.pi)
            
            for index in 1...5
            {
                let isPlayerInSight = isPlayerVisibleAtAngle(from: CCTVCamera.position, angle: coneAngle - offsetAngle / CGFloat(index))
                
                if isPlayerInSight
                {
                    gameManager.playerLives -= 1
                }
                
            }
        }
 
    }
    
    func isPlayerVisibleAtAngle (from: CGPoint, angle: CGFloat) -> Bool
    {
        let rayStart = from
        let rayEnd = CGPoint(x: from.x + 500 * cos(angle), y: from.y + 500 * sin(angle))
        
        let body = scene?.physicsWorld.body(alongRayStart: rayStart, end: rayEnd)
        
        return body == player.physicsBody
    }
    func showTutorial()
    {
        let dialogBox = SKSpriteNode(imageNamed: "dialogBox")
        dialogBox.position = CGPoint(x: frame.midX, y: frame.midY)
        UILayer.addChild(dialogBox)
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
    }

}

