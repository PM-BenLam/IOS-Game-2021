import Foundation
import SpriteKit


class GameScene: SKScene
{
    
    let player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
    
    var backgroundShouldMove = false
    
    override func didMove(to view: SKView)
    {
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        createBackground()
        
        createGround()
        
        createPlayer()
    }
    
    func createPlayer()
    {
        player.zPosition = 2
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        player.physicsBody?.mass = 1;
        player.physicsBody?.allowsRotation = false;
        player.physicsBody?.affectedByGravity = true;
        
        addChild(player)
    }
    
    let backgroundTexture = SKTexture(imageNamed: "background")
    
    let backgrounds = [SKSpriteNode(imageNamed: "background"), SKSpriteNode(imageNamed: "background")]
    
    func createBackground()
    {
        let topSky = SKSpriteNode(color: UIColor(hue: 0.55, saturation: 0.14, brightness: 0.97, alpha: 1), size: CGSize(width: frame.width, height: frame.height * 0.67))
            topSky.anchorPoint = CGPoint(x: 0.5, y: 1)

        let bottomSky = SKSpriteNode(color: UIColor(hue: 0.55, saturation: 0.16, brightness: 0.96, alpha: 1), size: CGSize(width: frame.width, height: frame.height * 0.33))
            bottomSky.anchorPoint = CGPoint(x: 0.5, y: 1)

        topSky.position = CGPoint(x: frame.midX, y: frame.height)
        bottomSky.position = CGPoint(x: frame.midX, y: bottomSky.frame.height)

        addChild(topSky)
        addChild(bottomSky)

        bottomSky.zPosition = -40
        topSky.zPosition = -40
        
        for background in backgrounds
        {
            background.zPosition = -30
            background.anchorPoint = CGPoint.zero
               
            addChild(background)
        }
        
        backgrounds[0].position = CGPoint(x: 0, y: 100)
        
        backgrounds[1].position = CGPoint(x: backgroundTexture.size().width, y: 100)
    }
    
    let groundTexture = SKTexture(imageNamed: "ground")
    
    let grounds = [SKSpriteNode(imageNamed: "ground"), SKSpriteNode(imageNamed: "ground")]
    
    func createGround()
    {
        for ground in grounds
        {
            
            ground.zPosition = -10
            
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: groundTexture.size().width, height: groundTexture.size().height))
            
            ground.physicsBody?.isDynamic = false
            ground.physicsBody?.affectedByGravity = false;
        }
        
        grounds[0].position = CGPoint(x: groundTexture.size().width / 2.0, y: frame.maxY / 6 )
        
        
        grounds[1].position = CGPoint(x: 3 * (groundTexture.size().width / 2.0), y: frame.maxY / 6 )
        
        addChild(grounds[0])
        
        addChild(grounds[1])
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let jumpForce = CGVector(dx: 0, dy: 500)

        player.physicsBody?.applyImpulse(jumpForce)
        
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        
        MoveLoop(duration: 5, nodes: grounds)
        MoveLoop(duration: 20, nodes: backgrounds)
        
    }
    
    func MoveLoop(duration: Double, nodes: [SKSpriteNode])
    {
        let moveLeft = SKAction.moveBy(x: -groundTexture.size().width, y: 0, duration: duration)
        let moveReset = SKAction.moveBy(x: groundTexture.size().width, y: 0, duration: 0)
        let moveLoop = SKAction.sequence([moveLeft, moveReset])
        
        if !nodes[0].hasActions() && !nodes[1].hasActions()
        {
            nodes[0].run(moveLoop)
            nodes[1].run(moveLoop)
        }
    }

}
