//
//  GameScene.swift
//  HoppyBunny
//
//  Created by Matthew Mehrtens on 11/30/16.
//  Copyright © 2016 Mattkx4. All rights reserved.
//

import SpriteKit
import GameplayKit

/* States of the Infinite GameMode */
enum GameState {
    case Active, GameOver, Ready, Preparing
}

class InfiniteGameScene: SKScene, SKPhysicsContactDelegate {
    
    /* Game management */
    var gameState: GameState = .Preparing
    
    /* Reference Nodes */
    var scrollLayers = [SKNode?](repeating: nil, count: 3) // Array contains all the scroll layer nodes
    var scrollLayerSprites = [(SKNode, SKNode)?](repeating: nil, count: 3) // Array contains tuples for the all scroll layer sprites
    var obstacleLayer: SKNode!
    
    /* Label references */
    var startLabel: SKLabelNode!
    var loadingLabel: SKLabelNode!
    var titleLabel_0: SKLabelNode!
    var titleLabel_1: SKLabelNode!
    var inGameDifficultyLabelNode: SKNode!
    var inGameDifficulty: SKLabelNode!
    
    /* UI Elements */
    
    /* Entities */
    var bunny: EntityBunny!
    var cloud: EntityCloud!
    
    /* Menus */
    var startMenu: UIStartMenu!
    var gameOverMenu: UIGameOverMenu!
    var infiniteScoreboard: UIInfiniteScoreboard!
    
    /* Boolean counters */
    var brokeHighScore = false

    /* Counters */
    var score = 0
    var jumps = 0
    var oldHighScore = 0

    /* Timers */
    let fixedDelta: TimeInterval = 1.0/60.0 /* 60 FPS */
    var sinceTouchTimer: TimeInterval = 0
    var spawnTimer: TimeInterval = 0
    var startLabelTimer: TimeInterval = 0
    var timeSinceStart: TimeInterval = 0
    
    /* Scroll Speeds*/
    let scrollSpeedGround: CGFloat = 110
    let scrollSpeedDistantBG: CGFloat = 8
    let scrollSpeedSky: CGFloat = 35
    
    /* Set up your scene here */
    override func didMove(to view: SKView) {
        /* Set reference to the scroll layers */
        scrollLayers[0] = self.childNode(withName: "groundScrollLayer")!
        scrollLayers[1] = self.childNode(withName: "distantBGScrollLayer")!
        scrollLayers[2] = self.childNode(withName: "skyScrollLayer")!
        
        /* Set reference to the scroll layer sprites */
        scrollLayerSprites[0] = (self.childNode(withName: "//groundSpriteNode_0")!, self.childNode(withName: "//groundSpriteNode_1")!)
        scrollLayerSprites[1] = (self.childNode(withName: "//distantBGSpriteNode_0")!, self.childNode(withName: "//distantBGSpriteNode_1")!)
        scrollLayerSprites[2] = (self.childNode(withName: "//skySpriteNode_0")!, self.childNode(withName: "//skySpriteNode_1")!)
        
        /* Set reference to obstacle layer node */
        obstacleLayer = self.childNode(withName: "obstacleLayer")
        
        /* Set label references */
        startLabel = self.childNode(withName: "startLabel") as! SKLabelNode
        loadingLabel = self.childNode(withName: "loadingLabel") as! SKLabelNode
        titleLabel_0 = self.childNode(withName: "titleLabel_0") as! SKLabelNode
        titleLabel_1 = self.childNode(withName: "titleLabel_1") as! SKLabelNode
        inGameDifficultyLabelNode = self.childNode(withName: "inGameDifficultyLabelNode")!
        inGameDifficulty = self.childNode(withName: "//inGameDifficulty") as! SKLabelNode
        
        /* Set physics contact delegate */
        physicsWorld.contactDelegate = self
        
        /* If it's the first time loading, enable the sound/music */
        if !GameStats.defaults.bool(forKey: GameStats.loadedBefore) {
            GameStats.defaults.set(true, forKey: GameStats.soundEnabled)
            GameStats.defaults.set(true, forKey: GameStats.musicEnabled)
            GameStats.defaults.set(true, forKey: GameStats.loadedBefore)
        }
        
        setGameState(state: .Preparing)
    }
    
    /* This func is called before each frame is rendered. */
    override func update(_ currentTime: TimeInterval) {
        /* Checks if the game is ready to begin */
        if gameState == .Preparing {
            if timeSinceStart >= 1.75 {
                setGameState(state: .Ready)
            } else {
                timeSinceStart += fixedDelta
            }
        }
        
        /* Runs the game idle */
        if gameState == .Ready {
            scrollWorld()
            flashStartGameLabel()
        }
        
        /* Skip this part of the game update if the game isn't active */
        if gameState == .Active {
            /* Process world scrolling */
            scrollWorld()
            updateObstacles()
            
            /* Check to see if the bunny is out of bounds */
            bunny.capBunnyY()
            
            /* Check the vertical velocity of the bunny and cap it */
            bunny.capBunnyVelocityY()
            
            /* Rotate the bunny */
            bunny.rotateBunny(sinceTouch: sinceTouchTimer)
            sinceTouchTimer += fixedDelta
        }
    }
    
    /* This function sets the game state and does all the appropriate steps*/
    func setGameState(state: GameState) {
        switch state {
        case .Preparing:
            /* Add the startMenu onto the screen */
            startMenu = UIStartMenu(baseScene: self, pos: CGPoint(x: -270, y: -209.5), zPos: 3, referenceName: "startMenuReferenceNode", resourcePath: "UIStartMenu", resourceType: "sks")
            
            /* Initialize the sounds. Check if they've been initialized first. */
            Sounds.initializeSounds()
            
            /* Add the bunny node to the screen */
            bunny = EntityBunny(baseScene: self, pos: CGPoint(x: 0, y: 0), zPos: 4, referenceName: "bunnyReferenceNode", resourcePath: "EntityBunny", resourceType: "sks")
            
            /* Add the cloud node to the screen */
            cloud = EntityCloud(baseScene: self, pos: CGPoint(x: -200, y: 0), zPos: 3, referenceName: "cloudReferenceNode", resourcePath: "EntityCloud", resourceType: "sks")
            
            /* When setting the state to .Ready, the loading label needs to go away. Also starts flashing the start label.*/
        case .Ready:
            gameState = .Ready
            startLabel.isHidden = false
            
            /* Play some jams */
            BGMusic.playBGMusic(url: BGMusic.getRandSongURL())
            
            /* Slide on the startMenu */
            startMenu.closeSlide()
            
            /* Slide off the loading label */
            GameAnimations.loadingLabelSlideOff(node: loadingLabel)
            
            /* Slide on the title */
            GameAnimations.titleSlideIn(nodes: (titleLabel_0, titleLabel_1))
            
            /* When setting the state to .Active, the flashing "start" label needs to go away and the score board text needs to appear. */
        case .Active:
            /* Get the old high score */
            oldHighScore = GameStats.defaults.integer(forKey: GameStats.highScore)
            
            /* Slide the cloud off the screen */
            cloud.slideOff()
            
            /* Slide the title off the screen */
            GameAnimations.titleSlideOff(nodes: (titleLabel_0, titleLabel_1))
            
            /* Slide off the startMenu and close any visible windows */
            startMenu.offSlide()
            
            /* Set the inGameDifficultyLabel to the proper value and slide it in */
            inGameDifficulty.text = String(GameStats.defaults.integer(forKey: GameStats.gameDiff))
            GameAnimations.inGameDifficultyLabelSlideIn(node: inGameDifficultyLabelNode)
            
            /* Add the infiniteScoreboard :) */
            infiniteScoreboard = UIInfiniteScoreboard(baseScene: self, pos: CGPoint(x: 0, y: -212.5), zPos: 3, referenceName: "infiniteScoreboardReferenceNode", resourcePath: "UIInfiniteScoreboard", resourceType: "sks")
            
            /* Set the final game difficulty */
            GameDifficulty.setDifficulty()
            
            startLabel.isHidden = true
            gameState = .Active
            
            /* Lot's of things happening here. #1, stop all angular velocity. #2: Set the angular velocity = 0. #3: Stop the flapping animation. #4: Run the death animation. #5: Shake the screen. #6: Show the restart button.*/
        case .GameOver:
            /* Kill the music */
            if GameStats.defaults.bool(forKey: GameStats.musicEnabled) { BGMusic.stopBGMusic(scene: self) }
            
            /* Run the kill hero animation */
            bunny.killBunny()
            
            /* Shake the screen */
            shake()
            
            /* Set the Game Stats */
            setGameStats()
            
            /* Slide the scoreboard off the screen */
            infiniteScoreboard.removeElement()
            
            /* Set the Game Over Menu to be visible */
            gameOverMenu = UIGameOverMenu(baseScene: self, pos: CGPoint(x: 0, y: 0), zPos: 5, referenceName: "gameOverMenuReferenceNode", resourcePath: "UIGameOverMenu", resourceType: "sks", score: score, jumps: jumps, brokeHighScore: brokeHighScore)
            
            /* Set the game state to .GameOver */
            gameState = .GameOver
        }
    }
    
    /* Called when someone touches the screen (when they begin touching)*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Once the player presses the game, it starts the game. So, we change the state from .Ready to .Active. */
        if gameState == .Ready {
            setGameState(state: .Active)
        }
        
        /* Disable touch if game state is not active */
        if gameState == .Active {
            /* Jump the hero */
            bunny.jump()
            
            /* Increment the jumps */
            jumps += 1
            
            /* Resets the since touch timer */
            sinceTouchTimer = 0
        }
    }
    
    /* This function scrolls a specified sprite infinitely */
    func scrollSprite(nodes: (SKNode, SKNode), scrollLayer: SKNode, scrollSpeed: CGFloat) {
        /* Scroll the scroll layers */
        scrollLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
        
        /* Get the SPRITE NODES. THIS IS USED TO FIND SIZE NOT POSITION! */
        let spriteNodes = (nodes.0 as! SKSpriteNode, nodes.1 as! SKSpriteNode)
        
        /* Get the position of the two sprites and convert them to the GameScene. */
        let spritePositions = (scrollLayer.convert(nodes.0.position, to: self), scrollLayer.convert(nodes.1.position, to: self))
        
        /* If the first sprite is outisde the left boundary of the screen, do this: */
        if spritePositions.0.x <= (-(self.size.width / 2) - (spriteNodes.0.size.width / 2)) {
            /* This defines a new position that is to the right of the second sprite based on the relative position of the second sprite, rather than basing this new position on the screen. By making this position relative to the second sprite, we fix two problems. #1: With the previous system, you could only make the sprites the size of the screen else it wouldn't work properly. #2: With this system, it elimantes a slight gap that would appear with the previous system. I assume this came from a slight delay on the system or a slight inacurracy in the numbers.*/
            let newPos = CGPoint(x: (spritePositions.1.x + spriteNodes.0.size.width), y: nodes.0.position.y)
            
            /* Convert the positions back to the scrollLayer */
            nodes.0.position = self.convert(newPos, to: scrollLayer)
            nodes.1.position = self.convert(spritePositions.1, to: scrollLayer)
        } else if spritePositions.1.x <= (-(self.size.width / 2) - (spriteNodes.1.size.width / 2)) {
            /* SAME CODE AS ABOVE! ( just flip flopped :] )*/
            let newPos = CGPoint(x: (spritePositions.0.x + spriteNodes.1.size.width), y: nodes.1.position.y)
            
            nodes.1.position = self.convert(newPos, to: scrollLayer)
            nodes.0.position = self.convert(spritePositions.0, to: scrollLayer)
        }
    }
    
    /* Update Obstacles */
    func updateObstacles() {
        /* Scroll the obstacles at the same speed as the ground */
        obstacleLayer.position.x -= scrollSpeedGround * CGFloat(fixedDelta)
        
        /* Loop through obstacle layer nodes */
        for obstacle in obstacleLayer.children as! [SKReferenceNode] {
            
            /* Get obstacle node position, convert node position to scene space */
            let obstaclePosition = obstacleLayer.convert(obstacle.position, to: self)
            
            /* Check if obstacle has left the screen */
            if obstaclePosition.x <= -(self.size.width / 2) {
                
                /* Remove obstacle node from obstacle layer */
                obstacle.removeFromParent()
            }
        }
        
        /* Add a new obstacle if the time is greater than or equal to 1.5. Also adds an obstacle right off the bat if the game just started (hasGeneratedFirstObstacle) */
        if spawnTimer >= 1.5 || obstacleLayer.childNode(withName: ".//goal") == nil {
            /* Generate an obstacle */
            generateObstacle()
            
            /* Reset spawn timer */
            spawnTimer = 0
        }
        
        /* Increment the obstacle spawn timer */
        spawnTimer += fixedDelta
    }
    
    /* Generates an obstacle at a random position */
    func generateObstacle() {
        /* Create a new obstacle reference object using our obstacle resource */
        let resourcePath = Bundle.main.path(forResource: "EntityObstacle", ofType: "sks")
        let newObstacle = SKReferenceNode(url: NSURL(fileURLWithPath: resourcePath!) as URL)
        
        /* Get references to the individual sprite nodes within our newObstacle */
        let goal = newObstacle.childNode(withName: "//goal") as! SKSpriteNode
        let obstacleTop = newObstacle.childNode(withName: "//obstacleTop") as! SKSpriteNode
        let obstacleBottom = newObstacle.childNode(withName: "//obstacleBottom") as! SKSpriteNode
        
        /* Set the proper y-values and heights for the sprites in the newObstacle */
        goal.size.height = GameDifficulty.goalHeight
        goal.position.y = CGFloat(0)
        obstacleTop.position = CGPoint(x: 0, y: (GameDifficulty.goalHeight / 2) + (obstacleTop.size.height / 2))
        obstacleBottom.position = CGPoint(x: 0, y: -(GameDifficulty.goalHeight / 2) - (obstacleBottom.size.height / 2))
        
        /* Add the obstacle to the obstacleLayer */
        obstacleLayer.addChild(newObstacle)
        
        /* Generate new obstacle position, start just outside screen and with a random y value */
        let randomPosition = CGPoint(x: ((self.size.width / 2) + ((obstacleLayer.childNode(withName: "/SKNode") as! SKSpriteNode).size.width / 2)), y: CGFloat.random(min: GameDifficulty.minHeight, max: GameDifficulty.maxHeight))
        
        /* Convert new node position back to obstacle layer space */
        newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
    }
    
    
    /* Increment the score when the hero stops making contact with the goal entity */
    func didEnd(_ contact: SKPhysicsContact) {
        /* Ensure only called while game running */
        if gameState != .Active { return }
        
        /* Get references to bodies involved in collision */
        let contactA:SKPhysicsBody = contact.bodyA
        let contactB:SKPhysicsBody = contact.bodyB
        
        /* Get references to the physics body parent nodes */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        /* Did our hero pass through the 'goal'? */
        if nodeA.name == "goal" || nodeB.name == "goal" {
            
            /* Run the code to increase the score by 1 */
            score += 1
            
            infiniteScoreboard.setScore(score: score)
            
            Sounds.playSound(soundName: "goal", object: self)
        }
    }
    
    /* Call this function when the hero makes contact with something */
    func didBegin(_ contact: SKPhysicsContact) {
        /* Ensure only called while game running */
        if gameState != .Active { return }
        
        /* Get references to bodies involved in collision */
        let contactA:SKPhysicsBody = contact.bodyA
        let contactB:SKPhysicsBody = contact.bodyB
        
        /* Get references to the physics body parent nodes */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        /* If one of the nodes doing the colliding was the goal, don't set the game over!!!!! */
        if nodeA.name != "goal" && nodeB.name != "goal" {
            /* If the hero touches anything besides the goals, game over */
            setGameState(state: .GameOver)
        }
    }
    
    /* This function causes the startLabel to flash */
    func flashStartGameLabel() {
        /* By adding the && operator, we were able to reuse the same timer variable for optimzation purposes. We run the first block of code if it's been 0.75 time since the label appeared. We run the second block of code if it's been 0.5 time since the label had been hidden.*/
        if startLabelTimer >= 0.75 && startLabel.isHidden == false {
            startLabel.isHidden = true
            startLabelTimer = 0
        } else if startLabelTimer >= 0.5 && startLabel.isHidden == true {
            startLabel.isHidden = false
            startLabelTimer = 0
        }
        
        /* Increment the timer */
        startLabelTimer += fixedDelta
    }
    
    /* This runs all the scrollWorld functions (except for the obstacles) */
    func scrollWorld() {
        scrollSprite(nodes: scrollLayerSprites[0]!, scrollLayer: scrollLayers[0]!, scrollSpeed: scrollSpeedGround)
        scrollSprite(nodes: scrollLayerSprites[1]!, scrollLayer: scrollLayers[1]!, scrollSpeed: scrollSpeedDistantBG)
        scrollSprite(nodes: scrollLayerSprites[2]!, scrollLayer: scrollLayers[2]!, scrollSpeed: scrollSpeedSky)
    }
    
    /* This animation shakes the screen when the hero dies */
    func shake() {
        /* Shake #1 */
        let shakeOne = SKAction.move(by: CGVector(dx: 4, dy: 2), duration: 0.1)
        
        /* Shake #2 */
        let shakeTwo = SKAction.move(by: CGVector(dx: -8, dy: -4), duration: 0.1)
        
        /* Shake #3 */
        let shakeThree = SKAction.move(by: CGVector(dx: 4, dy: 2), duration: 0.1)
        
        /* This puts all the shakes one after another. NOTE: due to the math here, the screen should end up in the same original position.*/
        let shake = SKAction.sequence([shakeOne, shakeTwo, shakeThree])
        
        /* Run the shake action in all nodes in the scene */
        for obj in self.children {
            obj.run(shake)
        }
    }
    
    /* Set the game stats at the end of the game */
    func setGameStats() {
        /* Set the new high score */
        if score > oldHighScore {
            brokeHighScore = true
            GameStats.defaults.set(score, forKey: GameStats.highScore)
        }
        
        /* Set the average score */
        if GameStats.defaults.array(forKey: GameStats.avgScore) == nil {
            GameStats.defaults.set([score], forKey: GameStats.avgScore)
        } else {
            var avgScoreArray = GameStats.defaults.array(forKey: GameStats.avgScore) as! [Int]
            avgScoreArray.append(score)
            GameStats.defaults.set(avgScoreArray, forKey: GameStats.avgScore)
        }
        
        /* Set the total jumps */
        GameStats.defaults.set(GameStats.defaults.integer(forKey: GameStats.totalJumps) + jumps, forKey: GameStats.totalJumps)
        
        /* Set the average jumps */
        if GameStats.defaults.array(forKey: GameStats.avgJumps) == nil {
            GameStats.defaults.set([jumps], forKey: GameStats.avgJumps)
        } else {
            var avgJumpsArray = GameStats.defaults.array(forKey: GameStats.avgJumps) as! [Int]
            avgJumpsArray.append(jumps)
            GameStats.defaults.set(avgJumpsArray, forKey: GameStats.avgJumps)
        }
        
        /* Set the jump record */
        if jumps > GameStats.defaults.integer(forKey: GameStats.jumpRecord) {
            GameStats.defaults.set(jumps, forKey: GameStats.jumpRecord)
        }
        
        /* Increase the total games */
        GameStats.defaults.set(GameStats.defaults.integer(forKey: GameStats.totalGames) + 1, forKey: GameStats.totalGames)
    }
}
