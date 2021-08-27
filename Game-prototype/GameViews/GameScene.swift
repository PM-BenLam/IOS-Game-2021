import Foundation
import SpriteKit
import SwiftUI


class GameScene: SKScene
{
    /// Initialization
    
    let stopSymbol = SKSpriteNode(imageNamed: "stopSign")
    let transparentGray = SKSpriteNode(color: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5), size: CGSize(width: 1, height: 1))
    
    func createStopScreen()
    {
        stopSymbol.zPosition = 210
        stopSymbol.size = CGSize(width: 50, height: 50)
        stopSymbol.position = camera?.position ?? CGPoint(x: frame.midX, y: frame.midY)
        
        transparentGray.zPosition = 200
        transparentGray.size = frame.size
        transparentGray.position = camera?.position ?? CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(stopSymbol)
        addChild(transparentGray)
    }
    
    let player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 25, height: 40))
    
    func createPlayer()
    {
        print("Hello")
        player.zPosition = 2
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.mass = 1;
        player.physicsBody?.allowsRotation = false;
        player.physicsBody?.affectedByGravity = true;
        
        addChild(player)
    }
    
    let UILayer = SKNode()
    
    let leftButton = SKSpriteNode(imageNamed: "leftTriangle")
    let rightButton =  SKSpriteNode(imageNamed: "rightTriangle")
    let jumpButton = [SKSpriteNode(imageNamed: "arrowUp"), SKSpriteNode(imageNamed: "arrowUp")]
   
    func createController()
    {
        leftButton.size = CGSize(width: 30, height: 30)
        leftButton.anchorPoint = CGPoint(x: 0, y: 0)
        leftButton.position = CGPoint(x: 20, y: 70)
        leftButton.zPosition = 100
        UILayer.addChild(leftButton)
        
        jumpButton[0].size = CGSize(width: 35, height: 30)
        jumpButton[0].anchorPoint = CGPoint(x: 0, y: 0)
        jumpButton[0].position = CGPoint(x: 18, y:  110)
        jumpButton[0].zPosition = 100
        UILayer.addChild(jumpButton[0])
        
        rightButton.size = CGSize(width: 30, height: 30)
        rightButton.anchorPoint = CGPoint(x: 1, y: 0)
        rightButton.position = CGPoint(x: frame.width - 20, y: 70)
        rightButton.zPosition = 100
        UILayer.addChild(rightButton)
        
        jumpButton[1].size = CGSize(width: 35, height: 30)
        jumpButton[1].anchorPoint = CGPoint(x: 1, y: 0)
        jumpButton[1].position = CGPoint(x: frame.width - 18, y: 110)
        jumpButton[1].zPosition = 100
        UILayer.addChild(jumpButton[1])
        
        addChild(UILayer)
    }
    
    let backgroundLayer = SKNode()
    
    let backgroundTexture = SKTexture(imageNamed: "background")
    let backgrounds = [SKSpriteNode(imageNamed: "background"), SKSpriteNode(imageNamed: "background")]
    
    var background0StartPosition: CGPoint = CGPoint.zero
    var background1StartPosition: CGPoint = CGPoint.zero
   
    func createBackground()
    {
        let topSky = SKSpriteNode(color: UIColor(hue: 0.55, saturation: 0.14, brightness: 0.97, alpha: 1), size: CGSize(width: frame.width * 2, height: frame.height * 0.67))
            topSky.anchorPoint = CGPoint(x: 0.5, y: 1)

        let bottomSky = SKSpriteNode(color: UIColor(hue: 0.55, saturation: 0.16, brightness: 0.96, alpha: 1), size: CGSize(width: frame.width * 2, height: frame.height * 0.33))
            bottomSky.anchorPoint = CGPoint(x: 0.5, y: 1)

        topSky.position = CGPoint(x: frame.midX, y: frame.height)
        bottomSky.position = CGPoint(x: frame.midX, y: bottomSky.frame.height)

        backgroundLayer.addChild(topSky)
        backgroundLayer.addChild(bottomSky)

        bottomSky.zPosition = -40
        topSky.zPosition = -40
        
        for background in backgrounds
        {
            background.zPosition = -30
            background.anchorPoint = CGPoint.zero
               
            backgroundLayer.addChild(background)
        }
        
        backgrounds[0].position = CGPoint(x: 0, y: 100)
        
        backgrounds[1].position = CGPoint(x: backgroundTexture.size().width, y: 100)
        
        addChild(backgroundLayer)
        
    }
    
    var tileArray: [SKSpriteNode] = []
    
    func createLevelMap()
    {
        let main = SKSpriteNode(fileNamed: "LevelMap")?.childNode(withName: "Level1") as! SKTileMapNode
        
        addPhysicBodyToTileMap(tileMap: main)
        
    }
    
    func addPhysicBodyToTileMap(tileMap: SKTileMapNode)
    {
        for col in 0 ..< tileMap.numberOfColumns
        {
            for row in 0 ..< tileMap.numberOfRows
            {
                if let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row)
                {
                    let tileTexture = tileDefinition.textures[0]
                    
                    let tileNode = SKSpriteNode(texture: tileTexture)
                    
                    tileNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    
                    let x = CGFloat(col) * tileMap.tileSize.width
                    let y = CGFloat(row) * tileMap.tileSize.height
                    
                    tileNode.position = CGPoint(x: x, y: y)
                    tileNode.physicsBody = SKPhysicsBody(texture: tileTexture, size: tileTexture.size())
                    
                    tileNode.physicsBody?.isDynamic = false
                    tileNode.physicsBody?.affectedByGravity = false
                    
                    tileNode.move(toParent: self)
                    
                    tileArray.append(tileNode)
                    
                }
            }
        }
    }
    
    func createCamera()
    {
        let cameraNode = SKCameraNode()
            
        cameraNode.position = CGPoint(x: frame.width / 2, y: frame.size.height / 2)
            
        addChild(cameraNode)
        self.camera = cameraNode
    }
    
    override func didMove(to view: SKView)
    {
        
        self.view?.isMultipleTouchEnabled = true
        
        physicsBody = SKPhysicsBody()
        
        createBackground()
        
        createLevelMap()
        
        createController()
        
        createPlayer()
        
        createCamera()
    
    }
    
    var leftButtonOnTouch = false
    var rightButtonOnTouch = false

    var selectedNodes:[UITouch:SKSpriteNode] = [:]

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            print(location.debugDescription)
            if let node = self.atPoint(location) as? SKSpriteNode
            {
                let jumpForce = CGVector(dx: 0, dy: 400)
                
                if node == jumpButton[0] || node == jumpButton[1]
                {
                    player.physicsBody?.applyImpulse(jumpForce)
                }
                
                if node == leftButton
                {
                    leftButtonOnTouch = true
                }
                
                if node == rightButton
                {
                    rightButtonOnTouch = true
                 
                }
 
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            if let node = self.atPoint(location) as? SKSpriteNode
            {
                if node != leftButton
                {
                    leftButtonOnTouch = false
                }
                
                if node != rightButton
                {
                    rightButtonOnTouch = false
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            if let node = self.atPoint(location) as? SKSpriteNode
            {
                if node == leftButton
                {
                    leftButtonOnTouch = false
                }
                
                if node == rightButton
                {
                    rightButtonOnTouch = false
                }
            }
        }
    }

    var cameraStartPosition: CGPoint = CGPoint.zero
    
    override func update(_ currentTime: TimeInterval)
    {
        cameraStartPosition = camera?.position ?? CGPoint.zero
        
        showPauseScreen()
        
        if player.position.y < 50
        {
            
        }
        
        if leftButtonOnTouch == true && !leftButton.hasActions()
        {
            MovePlayer(direction: "right", distance: 15)
        }
        
        if rightButtonOnTouch == true && !rightButton.hasActions()
        {
            MovePlayer(direction: "left", distance: 15)
        }
    }
   
    override func didSimulatePhysics()
    {
        camera?.position = player.position
        
        let cameraEndPosition = camera?.position ?? CGPoint.zero
       
        let xOffset = cameraEndPosition.x - cameraStartPosition.x
        let yOffset = cameraEndPosition.y - cameraStartPosition.y
        
        for child in UILayer.children
        {
            if let spriteChild = child as? SKSpriteNode
            {
                spriteChild.position = CGPoint(x: spriteChild.position.x + xOffset, y: spriteChild.position.y + yOffset)
            }
        }
        
        backgroundLayer.position = CGPoint(x:  backgroundLayer.position.x + (0.95 * xOffset), y:  backgroundLayer.position.y + (0.95 * yOffset))
    }
    
    func showPauseScreen()
    {
        if gameIsPaused
        {
            if !self.children.contains(stopSymbol) && !self.children.contains(transparentGray)
            {
                createStopScreen()
            }
            
            for node in self.children
            {
                if let spriteNode = node as? SKSpriteNode
                {
                    if spriteNode != stopSymbol && spriteNode != transparentGray && !tileArray.contains(spriteNode)
                    {
                        spriteNode.physicsBody?.isResting = true
                        spriteNode.physicsBody?.isDynamic = false
                        spriteNode.isPaused = true
                    }
                }
                
            }
                
        } else
        {
            if self.children.contains(stopSymbol) && self.children.contains(transparentGray)
            {
                stopSymbol.removeFromParent()
                transparentGray.removeFromParent()
            }
            
            for node in self.children
            {
                if let spriteNode = node as? SKSpriteNode
                {
                    if spriteNode != stopSymbol && spriteNode != transparentGray && !tileArray.contains(spriteNode)
                    {
                        spriteNode.physicsBody?.isResting = false
                        spriteNode.physicsBody?.isDynamic = true
                        spriteNode.isPaused = false
                    }
                }
            }
        }
    }
    
    func MovePlayer(direction: String, distance: CGFloat)
    {
        
        let moveLeft = SKAction.moveBy(x: -distance, y: 0, duration: 0.1)
        let moveRight = SKAction.moveBy(x: distance, y: 0, duration: 0.1)
        
        if !(player.hasActions())
        {
            if direction == "right"
            {
                player.run(moveLeft)
                
                
            } else if direction == "left"
            {
                player.run(moveRight)
            }
        }
        
    }
}
