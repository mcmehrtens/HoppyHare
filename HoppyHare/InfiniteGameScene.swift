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
    var hero: SKSpriteNode!
    var bunnyPosition: CGPoint!
    
    /* Label references */
    var startLabel: SKLabelNode!
    var loadingLabel: SKLabelNode!
    var titleLabel_0: SKLabelNode!
    var titleLabel_1: SKLabelNode!
    var infScoreboardScore: SKLabelNode!
    var infScoreboardHighScoreLabel: SKLabelNode!
    var infScoreboardHighScoreNumber: SKLabelNode!
    var infScoreboardHighScoreNode: SKNode!
    
    /* Game Over Menu references */
    var gameOverMenuReferenceNode: SKReferenceNode!
    var gameOverMenuScoreLabels: (SKLabelNode, SKLabelNode)!
    var gameOverMenuJumpLabels: (SKLabelNode, SKLabelNode)!
    var gameOverMenuNewHighScoreLabel: SKLabelNode!
    
    /* Boolean counters */
    var hasJumped = false
    var labelsHaveSlid = false
    var hasGeneratedFirstObstacle = false
    var scoreLabelHasShrunk = false
    
    /* Buttons */
    var gameOverMenuReplayButton_1: MSButtonNode!
    var gameOverMenuGameStatsButton_1: MSButtonNode!

    /* Counters */
    var score = 0
    var jumps = 0
    
    /* Time Variables */
    let timeBetweenObstacles = 1.5

    /* Timers */
    let fixedDelta: TimeInterval = 1.0/60.0 /* 60 FPS */
    var sinceTouchTimer: TimeInterval = 0
    var spawnTimer: TimeInterval = 0
    var startLabelTimer: TimeInterval = 0
    var idleJumpTimer: TimeInterval = 0
    var automaticJumpTimer: TimeInterval = 0
    var timeSinceStart: TimeInterval = 0
    var gameOverMenuTimer: TimeInterval = 0
    
    /* Scroll Speeds*/
    let scrollSpeedGround: CGFloat = 110
    let scrollSpeedDistantBG: CGFloat = 10
    let scrollSpeedSky: CGFloat = 35
    
    /* Set up your scene here */
    override func didMove(to view: SKView) {
        /* Recursive node search for 'hero' (child of referenced node) */
        hero = self.childNode(withName: "//hero") as! SKSpriteNode
        
        /* Set reference to the bunny's position */
        bunnyPosition = hero.position
        
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
        infScoreboardScore = self.childNode(withName: "//infScoreboardScore") as! SKLabelNode
        infScoreboardHighScoreLabel = self.childNode(withName: "//infScoreboardHighScoreLabel") as! SKLabelNode
        infScoreboardHighScoreNumber = self.childNode(withName: "//infScoreboardHighScoreNumber") as! SKLabelNode
        infScoreboardHighScoreNode = self.childNode(withName: "//infScoreboardHighScoreNode")!
        
        /* Set the gameOverMenu references */
        gameOverMenuReferenceNode = self.childNode(withName: "//gameOverMenuReferenceNode") as! SKReferenceNode
        gameOverMenuScoreLabels = ((self.childNode(withName: "//gameOverMenuScoreLabel_0") as! SKLabelNode), (self.childNode(withName: "//gameOverMenuScoreLabel_1") as! SKLabelNode))
        gameOverMenuJumpLabels = ((self.childNode(withName: "//gameOverMenuJumpLabel_0") as! SKLabelNode), (self.childNode(withName: "//gameOverMenuJumpLabel_1") as! SKLabelNode))
        gameOverMenuNewHighScoreLabel = self.childNode(withName: "//gameOverMenuNewHighScoreLabel") as! SKLabelNode
        
        /* Set button connections */
        gameOverMenuReplayButton_1 = self.childNode(withName: "//gameOverMenuReplayButton_1") as! MSButtonNode
        gameOverMenuGameStatsButton_1 = self.childNode(withName: "//gameOverMenuGameStatsButton_1") as! MSButtonNode
        
        /* Setup restart button selection handler */
        gameOverMenuReplayButton_1.selectedHandler = { [unowned self] in
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = InfiniteGameScene(fileNamed:"InfiniteGameScene") as InfiniteGameScene!
            
            /* Ensure correct aspect mode */
            scene!.scaleMode = .aspectFill
            
            /* Restart game scene */
            skView!.presentScene(scene)
        }
        
        /* Setup back button selection handler */
        gameOverMenuGameStatsButton_1.selectedHandler = { [unowned self] in
            
            /* Grab reference to our SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load GameStats */
            let scene = GameStats(fileNamed:"GameStats") as GameStats!
            
            /* Ensure correct aspect mode */
            scene!.scaleMode = .aspectFill
            
            /* Set the view to the GameStats Scene */
            skView!.presentScene(scene)
        }
        
        /* Set physics contact delegate */
        physicsWorld.contactDelegate = self
        
        /* Initialize the sounds. Check if they've been initialized first. */
        Sounds.initializeSounds()
        
        /* Get all the game stats from the defaults */
        StoredStats.initDefaults()
        
        /* Set the high score label */
        infScoreboardHighScoreNumber.text = String(StoredStats.allTimeHighScore)
    }
    
    /* This func is called before each frame is rendered. */
    override func update(_ currentTime: TimeInterval) {
        /* Check if the game is ready to play. */
        checkIfGameIsReady()
        
        /* If the gameState is .Ready, run the idle actions */
        gameIdle()
        
        /* Check the vertical velocity and cap it */
        checkVelocityY()
        
        /* Apply the rotation on the hero */
        rotateHero()
        
        /* Skip this part of the game update if the game isn't active */
        if gameState == .Active {
            
            /* Process world scrolling */
            scrollWorld()
            updateObstacles()
            
            /* Check to see if the bunny is out of bounds */
            checkIfBunnyIsOutOfBounds()
        }
        
        /* Only activate this part of the game if the game is over */
        if gameState == .GameOver {
            displayGameOverMenu()
        }
    }
    
    /* Called when someone touches the screen (when they begin touching)*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Once the player presses the game, it starts the game. So, we change the state from .Ready to .Active. */
        if gameState == .Ready {
            setGameState(state: .Active)
        }
        
        /* Disable touch if game state is not active */
        if gameState != .Active { return }
        
        /* Jump the hero */
        jump()
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
    
    func updateObstacles() {
        /* Update Obstacles */
        
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
        if spawnTimer >= timeBetweenObstacles || !hasGeneratedFirstObstacle {
            /* Set the hasGeneratedFirstObstacle */
            hasGeneratedFirstObstacle = true
            
            /* Create a new obstacle reference object using our obstacle resource */
            let resourcePath = Bundle.main.path(forResource: "Obstacle", ofType: "sks")
            let newObstacle = SKReferenceNode(url: NSURL(fileURLWithPath: resourcePath!) as URL)
            obstacleLayer.addChild(newObstacle)
            
            /* Generate new obstacle position, start just outside screen and with a random y value */
            let randomPosition = CGPoint(x: ((self.size.width / 2) + ((obstacleLayer.childNode(withName: "/SKNode") as! SKSpriteNode).size.width / 2)), y: CGFloat.random(min: -45, max: 170))
            
            /* Convert new node position back to obstacle layer space */
            newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
            
            // Reset spawn timer
            spawnTimer = 0
        }
        
        /* Increment the obstacle spawn timer */
        spawnTimer += fixedDelta
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
            increaseScore()
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
    
    /* This function sets the game state and does all the appropriate steps*/
    func setGameState(state: GameState) {
        switch state {
            /* When setting the state to .Ready, the loading label needs to go away. Also starts flashing the start label.*/
        case .Ready:
            gameState = .Ready
            startLabel.isHidden = false
            
            /* Slide off the loading label */
            InfiniteGameSceneAnimations.loadingLabelSlideOff(node: loadingLabel)
            
            /* Slide on the title */
            InfiniteGameSceneAnimations.titleSlideIn(nodes: (titleLabel_0, titleLabel_1))
            
            /* When setting the state to .Active, the flashing "start" label needs to go away and the score board text needs to appear. */
        case .Active:
            /* Slide the title off the screen */
            InfiniteGameSceneAnimations.titleSlideOff(nodes: (titleLabel_0, titleLabel_1))
            
            /* Slide on the scoreboard labels :) */
            InfiniteGameSceneAnimations.infScoreboardSlideIn(nodes: [infScoreboardScore, infScoreboardHighScoreNode])
            
            startLabel.isHidden = true
            gameState = .Active
            
            /* Lot's of things happening here. #1, stop all angular velocity. #2: Set the angular velocity = 0. #3: Stop the flapping animation. #4: Run the death animation. #5: Shake the screen. #6: Show the restart button.*/
        case .GameOver:
            /* Update all the game statistics */
            GameStats.updateGameStats(score: score, jumps: jumps)
            
            /* Run the kill hero animation */
            killHero()
            
            /* Set the Game Over Menu to be visible */
            gameOverMenuReferenceNode.isHidden = false
            
            /* Set the proper numbers to the Game Over Menu (the score and the jumps) */
            gameOverMenuScoreLabels.1.text = String(score)
            gameOverMenuJumpLabels.1.text = String(jumps)
            
            /* Set the game state to .GameOver */
            gameState = .GameOver
        default: break
        }
    }
    
    /* Kill the hero */
    func killHero() {
        /* Stop any new angular velocity being applied */
        hero.physicsBody?.allowsRotation = false
        
        /* Reset angular velocity */
        hero.physicsBody?.angularVelocity = 0
        
        /* Stop hero flapping animation */
        hero.removeAllActions()
        
        /* Create our hero death action */
        let heroDeath = SKAction.run({
            /* Put our hero face down in the dirt */
            self.hero.zRotation = CGFloat(-90).degreesToRadians()
            
            /* Stop hero from colliding with anything else */
            self.hero.physicsBody?.collisionBitMask = 0
        })
        
        /* Run action */
        hero.run(heroDeath)
        
        /* Shake all the nodes in this scene  */
        InfiniteGameSceneAnimations.shake(nodes: self.children)
    }
    
    /* Checks if the game is ready to play. Once it's ready, it sets the GameState to .Ready. */
    func checkIfGameIsReady() {
        /* Only run this block if the GameState is .Preparing and the time since the game was initialized was 1 second. This 1 second timer is currently temporary. Once there's actually things to load, this block will trigger once those are loaded. */
        if gameState == .Preparing && timeSinceStart >= 1.75 {
            setGameState(state: .Ready)
            return
        }
        
        /* Right now there's not much of a use for this variable, but oh well. We'll keep incrementing it. */
        timeSinceStart += fixedDelta
    }
    
    /* Jumps the hero into the aiiiirrrrrrr!!!! */
    func jump() {
        /* Increment the jump counter */
        jumps += 1
        
        /* Reset velocity, helps improve response against cumulative falling velocity */
        hero.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        /* Apply vertical impulse */
        hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 180))
        
        /* Play SFX */
        Sounds.playSound(soundName: "flap", object: self)
        
        /* Apply subtle rotation */
        hero.physicsBody?.applyAngularImpulse(CGFloat(0.1))
        
        /* Reset touch timer */
        sinceTouchTimer = 0
    }
    
    /* Run this function when the game is idling (.Ready state). */
    func gameIdle() {
        /* Only run this idle code if the GameState is .Ready.*/
        if gameState == .Ready {
            /* This could makes the bunny hop on the ground as it moves :)*/
            idleJump()
            
            /* Scroll the ground, crystals, and clouds */
            scrollWorld()
            
            /* This variable is used for the first jump in the idle animation. If this variable didn't exist, the bunny would slide across the ground for a little bit on the start of the idle animation.*/
            if hasJumped == false {
                hasJumped = true
            }
            
            /* This makes the start the game start label flash. */
            flashStartGameLabel()
        }
    }
    
    /* This funcion causes the bunny to hop on the ground without any player touch necessary.*/
    func idleJump() {
        if idleJumpTimer >= 0.48  || hasJumped == false {
            /* Reset velocity, helps improve response against cumulative falling velocity */
            hero.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
            /* Apply vertical impulse */
            hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 175))
            
            /* Check and cap the Y Velocity*/
            checkVelocityY()
            
            /* Reset the idle jump timer back to 0 */
            idleJumpTimer = 0
        }
        
        /* Increment the idle jump timer */
        idleJumpTimer += fixedDelta
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
    
    /* Displays the menu item by item */
    func displayGameOverMenu() {
        if gameOverMenuTimer >= 0.75 && gameOverMenuScoreLabels.0.isHidden == true {
            gameOverMenuScoreLabels.0.isHidden = false
            gameOverMenuScoreLabels.1.isHidden = false
        } else if gameOverMenuTimer >= 1.5 && gameOverMenuJumpLabels.0.isHidden == true {
            gameOverMenuJumpLabels.0.isHidden = false
            gameOverMenuJumpLabels.1.isHidden = false
        } else if gameOverMenuTimer >= 2.25 && gameOverMenuNewHighScoreLabel.isHidden == true {
            if score > StoredStats.allTimeHighScore {
                gameOverMenuNewHighScoreLabel.isHidden = false
            }
        }
        
        gameOverMenuTimer += fixedDelta
    }
    
    /* Check if the bunnies vertical velocity is too high */
    func checkVelocityY() {
        /* Grab current velocity */
        let velocityY = hero.physicsBody?.velocity.dy ?? 0
        
        /* Check and cap vertical velocity */
        if velocityY > 350 {
            hero.physicsBody?.velocity.dy = 350
        }
    }
    
    /* Rotate the hero after a jump */
    func rotateHero() {
        if gameState == .Active {
            /* Apply falling rotation */
            if sinceTouchTimer > 0.29 { // Make this number smaller to start the falling rotation sooner
                let impulse = -20000 * fixedDelta
                hero.physicsBody?.applyAngularImpulse(CGFloat(impulse))
            }
            
            /* Clamp rotation */
            hero.zRotation = hero.zRotation.clamped(CGFloat(-10).degreesToRadians(), CGFloat(15).degreesToRadians()) // Negative number is the most it is allowed to turn downwards. Positive number is the max rotation upwards.
            hero.physicsBody!.angularVelocity = hero.physicsBody!.angularVelocity.clamped(-1, 1) // This clamp makes it so that the velocity never gets to high or low. Adjust these numbers to make the rotation happen faster/slower.
            
            /* Update last touch timer */
            sinceTouchTimer += fixedDelta
        }
    }
    
    /* This func sets a ceiling to the game; prevents you from going way up into the sky :) */
    func checkIfBunnyIsOutOfBounds() {
        /* Grab the bunny reference node's position */
        let bunnyReferencePos = self.childNode(withName: "bunnyReferenceNode")!.position
        /* Grab the bunny's position */
        let bunnyPos = self.childNode(withName: "//hero")!.position
        
        /* This is a funky bit of code right here. Essentially, the reference node and the bunny's actual node are two different entities. The reference node in this case is set to like, -118 or something, but the reference node never moves. The hero node on the other hand starts at 0,0 and as it jumps, that value increases. This is kind of frustrating to explain tbh :P So, we simulate the hero's yPos in this case by adding the reference nodes yPos to the hero's yPos. This sets the hero's and the referenceNode's y value to the same spot.
         
         For example: Here's the yPosition of the starting nodes.
         Bunny Node: 0
         Bunny Reference Node: -100
         
         By adding on the bunny reference node's yPos to the bunny node's y value, they match up and now this simulates the bunny's actual position on the screen. I hope this makes sense to me later >.<
         
         We set the cap to be the max height of the screen, plus 1/4 bunny. If we set the ceiling to be exactly at the top of the screen, the bunny can go a little bit higher than the screen for just a moment before the game udpates and set it's velocity to 0. This extra 1/4 of the hero allows for a bit of a pillow time so the game can catch up */
        if (bunnyPos.y + bunnyReferencePos.y) >= (self.size.height / 2) - (hero.size.height * (3/4)) {
            hero.physicsBody?.velocity.dy = 0
        }
    }
    
    /* This runs all the scrollWorld functions (except for the obstacles) */
    func scrollWorld() {
        scrollSprite(nodes: scrollLayerSprites[0]!, scrollLayer: scrollLayers[0]!, scrollSpeed: scrollSpeedGround)
        scrollSprite(nodes: scrollLayerSprites[1]!, scrollLayer: scrollLayers[1]!, scrollSpeed: scrollSpeedDistantBG)
        scrollSprite(nodes: scrollLayerSprites[2]!, scrollLayer: scrollLayers[2]!, scrollSpeed: scrollSpeedSky)
    }
    
    /* Increment the score */
    func increaseScore() {
        /* Increment points */
        score += 1
        
        /* Update score label */
        infScoreboardScore.text = String(score)
        
        /* Play the goal sound */
        Sounds.playSound(soundName: "goal", object: self)
        
        /* This checks if the player has surpassed the current high score. If yes, this sets the color of the high score labels to gold to notify the player that he's making history. */
        if score > StoredStats.allTimeHighScore {
            /* Set the highScore number to the number of points the player currently has */
            infScoreboardHighScoreNumber.text = String(score)
            
            /* Set the font color to yellloooowwwwwwwww */
            infScoreboardHighScoreLabel.fontColor = CustomColors.colorGold
            infScoreboardHighScoreNumber.fontColor = CustomColors.colorGold
        }
    }
}