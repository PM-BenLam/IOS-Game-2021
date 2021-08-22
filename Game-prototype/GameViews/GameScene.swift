import Foundation
import SpriteKit
import SwiftUI

class GameScene: SKScene
{
    let stopSymbol = SKSpriteNode(imageNamed: "stopSign")
    let transparentGray = SKSpriteNode(color: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5), size: CGSize(width: 1, height: 1))
    
    func createStopScreen()
    {
        stopSymbol.zPosition = 210
        stopSymbol.size = CGSize(width: 50, height: 50)
        stopSymbol.position = CGPoint(x: frame.midX, y: frame.midY)
        
        transparentGray.zPosition = 200
        transparentGray.size = frame.size
        transparentGray.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(stopSymbol)
        addChild(transparentGray)
    }
    
    let player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
    
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
    
    let leftButton = SKSpriteNode(color: .darkGray, size: CGSize(width: 30, height: 30))
    let rightButton = SKSpriteNode(color: .darkGray, size: CGSize(width: 30, height: 30))
    let jumpButton = SKSpriteNode(color: .darkGray, size: CGSize(width: 30, height: 30))
   
    func createController()
    {
        let startX = frame.minX + 10
        let startY = frame.minY + 70
        
        leftButton.anchorPoint = CGPoint(x: 0, y: 0)
        leftButton.position = CGPoint(x: startX, y: startY)
        leftButton.zPosition = 100
        addChild(leftButton)
        
        rightButton.anchorPoint = CGPoint(x: 1, y: 0)
        rightButton.position = CGPoint(x: startX + 100, y: startY)
        rightButton.zPosition = 100
        addChild(rightButton)
        
        let midX = (leftButton.position.x + rightButton.position.x) / 2
        
        jumpButton.anchorPoint = CGPoint(x: 0.5, y: 0)
        jumpButton.position = CGPoint(x: midX, y: startY)
        jumpButton.zPosition = 100
        addChild(jumpButton)
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
    
    let ground = SKSpriteNode(fileNamed: "Level")?.childNode(withName: "ground")
    
    func createGround()
    {
        ground?.move(toParent: self)
        
        ground?.zPosition = -10
        
        ground?.physicsBody?.isDynamic = false
        ground?.physicsBody?.affectedByGravity = false
        
        ground?.position = CGPoint(x: frame.midX, y: frame.maxY / 6 )
    }
    
    
    override func didMove(to view: SKView)
    {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        createBackground()
        
        createGround()
        
        createController()
        
        createPlayer()
    }
    
    var leftButtonOnTouch = false
    var rightButtonOnTouch = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            let jumpForce = CGVector(dx: 0, dy: 500)
            
            if jumpButton.contains(location)
            {
                player.physicsBody?.applyImpulse(jumpForce)
            }
            
            if leftButton.contains(location)
            {
                leftButtonOnTouch = true
            }
            
            if rightButton.contains(location)
            {
                rightButtonOnTouch = true
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        leftButtonOnTouch = false
        rightButtonOnTouch = false
    }

    override func update(_ currentTime: TimeInterval)
    {
        
        if gameIsPaused
        {
            if !self.children.contains(stopSymbol) && !self.children.contains(transparentGray)
            {
                createStopScreen()
            }
            
            for node in self.children
            {
                if node != stopSymbol && node != transparentGray
                {
                    node.physicsBody?.isResting = true
                    node.isPaused = true
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
                if node != stopSymbol && node != transparentGray
                {
                    node.physicsBody?.isResting = false
                    node.isPaused = false
                }
            }
        }
       
        if leftButtonOnTouch == true && !leftButton.hasActions()
        {
            MoveBackground(direction: "right", distance: 1)
            MoveGround(direction: "right", distance: 15)
        }
        
        if rightButtonOnTouch == true && !rightButton.hasActions()
        {
            MoveBackground(direction: "left", distance: 1)
            MoveGround(direction: "left", distance: 15)
        }
    }
   
    func MoveBackground(direction: String, distance: CGFloat)
    {
        let moveLeft: SKAction
        let moveRight: SKAction
        
        moveLeft = SKAction.moveBy(x: -distance, y: 0, duration: 0.1)
        moveRight = SKAction.moveBy(x: distance, y: 0, duration: 0.1)
        
        if direction == "left"
        {
            if !backgrounds[0].hasActions() && !backgrounds[1].hasActions()
            {
                backgrounds[0].run(moveLeft)
                backgrounds[1].run(moveLeft)
            }
        } else if direction == "right"
        {
            if !backgrounds[0].hasActions() && !backgrounds[1].hasActions()
            {
                backgrounds[0].run(moveRight)
                backgrounds[1].run(moveRight)
            }
        }
        
    }

    func MoveGround(direction: String, distance: CGFloat)
    {
        let moveLeft: SKAction
        let moveRight: SKAction
        
        moveLeft = SKAction.moveBy(x: -distance, y: 0, duration: 0.1)
        moveRight = SKAction.moveBy(x: distance, y: 0, duration: 0.1)
        
        
        if !(ground?.hasActions())!
        {
            
            if direction == "left"
            {
                ground?.run(moveLeft)
                
            } else if direction == "right"
            {
                ground?.run(moveRight)
            }
        }
    }
}
