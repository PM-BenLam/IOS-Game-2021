import Foundation
import SpriteKit


class GameScene: SKScene
{
    let testSpriteNode = SKSpriteNode(color: UIColor.red, size: CGSize(width: 100, height: 100))
    
    
    // let var = SKSpriteNode(ImageNamed: " ")
    // to make sprite with picture
    
    override func didMove(to view: SKView)
    {
        let screenCenter = CGPoint(x: frame.midX, y: frame.midY)
        
        testSpriteNode.position = screenCenter
        
        addChild(testSpriteNode)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        testSpriteNode.physicsBody = SKPhysicsBody(circleOfRadius: 50 )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //testSpriteNode.run(SKAction.moveTo(x: frame.maxX, duration: 1), completion: { self.testSpriteNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY) })
        
        
    }

}
