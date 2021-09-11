import Foundation
import SpriteKit
import SwiftUI

class GameManager: ObservableObject
{
    static let sharedInstance = GameManager()
    @Published var gameIsOver = false
    @Published var gameLevel: Int = 1
    @Published var playerLives: Int = 3
    
    
    func reset()
    {
        gameIsOver = false
        gameLevel = 1
        playerLives = 3
    }
    
    private init() { }
}

class GameScene: SKScene, SKPhysicsContactDelegate
{
    let gameManager = GameManager.sharedInstance

    static var gameIsPaused = false
    
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
    
    let playerTextures = [SKTexture(imageNamed: "leftIdle"),
                         SKTexture(imageNamed: "rightIdle"),
                         SKTexture(imageNamed: "leftRun1"),
                         SKTexture(imageNamed: "rightRun1"),
                         SKTexture(imageNamed: "leftRun2"),
                         SKTexture(imageNamed: "rightRun2")]
 
    let player = SKSpriteNode(texture: nil)

    func createPlayer()
    {
        player.name = "player"
        player.zPosition = 2
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        player.texture = playerTextures[1]
        player.size = player.texture!.size()
        player.physicsBody = SKPhysicsBody(rectangleOf: player.texture!.size())
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

    var tileArray: [SKSpriteNode] = []
    
    func createLevelMap(fileName: String, tileMapName: String)
    {
        let tileMap = SKSpriteNode(fileNamed: fileName)?.childNode(withName: tileMapName) as! SKTileMapNode
        
        addPhysicBodyToTileMap(tileMap: tileMap)
        
    }
    
    var portal = SKNode()
    var CCTVCamera = SKNode()
    
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
                    
                    if tileNode.texture?.description == "<SKTexture> 'portal' (16 x 32)"
                    {
                        portal = tileNode
                        
                    } else if tileNode.texture?.description == "<SKTexture> 'CCTVCamera' (16 x 16)"
                    {
                        CCTVCamera = tileNode
                    } else
                    {
                        tileNode.physicsBody = SKPhysicsBody(texture: tileTexture, size: tileTexture.size())
                            
                        tileNode.physicsBody?.isDynamic = false
                        tileNode.physicsBody?.affectedByGravity = false
                        
                    }
                    
                    tileArray.append(tileNode)
                    
                    tileNode.move(toParent: self)
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
    
    let heartIconTextures = [
        SKTexture(imageNamed: "heart"),
        SKTexture(imageNamed: "heart2"),
        SKTexture(imageNamed: "heart3")
    ]
    
    let heartIcon = SKSpriteNode(texture: SKTexture(imageNamed: "heart3"))
    
    /// initialization
    override func didMove(to view: SKView)
    {
        
        heartIcon.position = CGPoint(x: 0, y: 18)
        
        player.addChild(heartIcon)
        
        UILayer.zPosition = 1000
        
        self.view?.isMultipleTouchEnabled = true
        
        physicsBody = SKPhysicsBody()
        
        physicsWorld.contactDelegate = self
        
        addChild(backgroundLayer)
        
        createController()
        
        createPlayer()
        
        createCamera()
        
    }
    
    var leftButtonOnTouch = false
    var rightButtonOnTouch = false
    var cameraStartPosition: CGPoint = CGPoint.zero
    
    override func update(_ currentTime: TimeInterval)
    {
        cameraStartPosition = camera?.position ?? CGPoint.zero
        
        showPauseScreen()
        
        updateLivesCount()
        
        changeToIdleTexture()
        
        if leftButtonOnTouch == true && !leftButton.hasActions()
        {
            MovePlayer(direction: "right", distance: 10)
        }
        
        if rightButtonOnTouch == true && !rightButton.hasActions()
        {
            MovePlayer(direction: "left", distance: 10)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
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
        if GameScene.gameIsPaused
        {
            if !self.children.contains(stopSymbol) && !self.children.contains(transparentGray)
            {
                createStopScreen()
            }
            
            togglePause(status: true)
                
        } else
        {
            if self.children.contains(stopSymbol) && self.children.contains(transparentGray)
            {
                stopSymbol.removeFromParent()
                transparentGray.removeFromParent()
            }
            
            togglePause(status: false)
        }
    }
    
    func togglePause(status: Bool)
    {
        for node in self.children
        {
            if node != stopSymbol && node != transparentGray
            {
                if status == true
                {
                    node.isPaused = true
                } else
                {
                    node.isPaused = false
                }
            }
        }
    }
    
    func MovePlayer(direction: String, distance: CGFloat)
    {
        
        let moveLeft = SKAction.moveBy(x: -distance, y: 0, duration: 0.075)
        let moveRight = SKAction.moveBy(x: distance, y: 0, duration: 0.075)
        
        if !(player.hasActions())
        {
            if direction == "right"
            {
                player.run(moveLeft)
                
                if player.texture != playerTextures[2]
                {
                    player.texture = playerTextures[2]
                    
                } else if player.texture != playerTextures[4]
                {
                    player.texture = playerTextures[4]
                }
                    
            } else if direction == "left"
            {
                player.run(moveRight)
                
                if player.texture != playerTextures[3]
                {
                    player.texture = playerTextures[3]
                    
                } else if player.texture != playerTextures[5]
                {
                    player.texture = playerTextures[5]
                }
            }
        }
        
    }
    
    func changeToIdleTexture()
    {
        if !(player.hasActions())
        {
           DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            { [self] in
                
                if !(player.hasActions())
                {
                    if player.texture == playerTextures[2] || player.texture == playerTextures[4]
                    {
                        player.texture = playerTextures[0]
                        
                    } else if player.texture == playerTextures[3] || player.texture == playerTextures[5]
                    {
                        player.texture = playerTextures[1]
                    }
                }
            }
        }
    }
    
    func loadBackgroundGIF(withName: String)
    {
        
        func load(imageURL: URL) -> [SKTexture]
        {
            guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, nil) else { return [] }
       
            let count = CGImageSourceGetCount(imageSource)
            var images: [CGImage] = []

            for i in 0..<count
            {
                guard let img = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else { continue }
                images.append(img)
            }

            return images.map { SKTexture(cgImage: $0) }
        }
        
        
        if let imageURL = Bundle.main.url(forResource: withName, withExtension: "gif")
        {
            
            let backgroundTextures = load(imageURL: imageURL)
                        
            let backgroundImage = SKSpriteNode(texture: backgroundTextures[0])
           
            backgroundImage.size = CGSize(width: frame.width * 1.5, height: frame.height * 1.5)
            backgroundImage.position = CGPoint(x: frame.midX, y: frame.midY)
            
            backgroundLayer.addChild(backgroundImage)
            
            backgroundImage.run(SKAction.repeatForever(SKAction.animate(with: backgroundTextures, timePerFrame: 1)))
        }
        
        
    }
    
    func loadBackground(withName: String, scale: CGFloat)
    {
        let backgroundImage = SKSpriteNode(imageNamed: withName)
        
        backgroundImage.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundImage.size = CGSize(width: backgroundImage.size.width * scale, height: backgroundImage.size.height * scale)
        backgroundImage.zPosition = -10
        backgroundLayer.addChild(backgroundImage)
        
    }
    
    func updateLivesCount()
    {
        let iconScaling: CGFloat = 0.7
        switch gameManager.playerLives
        {
        case 0:
            gameManager.gameIsOver = true
            break
  
        case 1:
            if heartIcon.texture != heartIconTextures[0]
            {
                heartIcon.texture = heartIconTextures[0]
                heartIcon.size = CGSize(width: heartIconTextures[0].size().width * iconScaling, height: heartIconTextures[0].size().height * iconScaling)
            }
            break
            
        case 2:
            if heartIcon.texture != heartIconTextures[1]
            {
                heartIcon.texture = heartIconTextures[1]
                heartIcon.size = CGSize(width: heartIconTextures[1].size().width * iconScaling, height: heartIconTextures[1].size().height * iconScaling)
                
            }
            break
            
        case 3:
            if heartIcon.texture != heartIconTextures[2]
            {
                heartIcon.texture = heartIconTextures[2]
                heartIcon.size = CGSize(width: heartIconTextures[2].size().width * iconScaling, height: heartIconTextures[2].size().height * iconScaling)
            }
            break
            
        default:
            break
        }
        
    }
  
}

