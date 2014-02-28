//
//  HelloWorldScene.m
//  cram_a3
//
//  Created by Erin Cramer on 2/12/2014.
//  Copyright Erin Cramer 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "Menu.h"
#import "LevelTwoScene.h"
#import "WinningScene.h"
#import "LosingScene.h"

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation LevelTwoScene
{
    CCSprite *_player;
    CCPhysicsNode *_physicsWorld;
    int _hits;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (LevelTwoScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.6f green:0.6f blue:0.6f alpha:1.0f]];
    [self addChild:background];
    
    _physicsWorld = [CCPhysicsNode node];
    _physicsWorld.gravity = ccp(0,0);
    _physicsWorld.debugDraw = NO;
    _physicsWorld.collisionDelegate = self;
    [self addChild:_physicsWorld];
    
    
    // Add a sprite
    _player = [CCSprite spriteWithImageNamed:@"player-hd.png"];
    _player.position  = ccp(self.contentSize.width/8,self.contentSize.height/2);
    _player.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, _player.contentSize} cornerRadius:0]; // 1
    _player.physicsBody.collisionGroup = @"playerGroup"; // 2
    [_physicsWorld addChild:_player];
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    // done
	return self;
}

- (void)addMonster:(CCTime)dt {
    
    CCSprite *monster = [CCSprite spriteWithImageNamed:@"monster.png"];
    
    // 1
    int minY = monster.contentSize.height / 2;
    int maxY = self.contentSize.height - monster.contentSize.height / 2;
    int rangeY = maxY - minY;
    int randomY = (arc4random() % rangeY) + minY;
    
    // 2
    monster.position = CGPointMake(self.contentSize.width + monster.contentSize.width/2, randomY);
    monster.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, monster.contentSize} cornerRadius:0]; // 1
    monster.physicsBody.collisionGroup = @"monsterGroup"; // 2
    monster.physicsBody.collisionType = @"monsterCollision";
    [_physicsWorld addChild:monster];
    
    //divide screen into 3 pieces
    int frameSize = self.contentSize.width/3;
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    
    float minDuration = 1;
    float maxDuration = 2;
    int rangeDuration = maxDuration - minDuration;
    int randomX;
    for (int i = 2; i >= 0; i--) {

        int randomDuration = (arc4random() % rangeDuration) + minDuration;
        randomY = (arc4random() % rangeY) + minY;
        
        if (i ==0) {
            
            randomX = -monster.contentSize.width/2;
            
            
        } else {
            
            int minX = i*frameSize;
            randomX = (arc4random() % frameSize) + minX;
            
        }
        
        // 4
        CCAction *actionMove1 = [CCActionMoveTo actionWithDuration:randomDuration position:CGPointMake(randomX, randomY)];
        
        [questions addObject:actionMove1];
        
    }
    
    [questions addObject:[CCActionCallFunc actionWithTarget:self selector:@selector(youLose)]];
    
    //    CCAction *actionRemove = [CCActionRemove action];
    [monster runAction:[CCActionSequence actionWithArray: questions]];
}

-(void) youLose {
    
    //go to level 2
    [[CCDirector sharedDirector] replaceScene:[LosingScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionInvalid duration:1.0f]];
    
}



// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    [self schedule:@selector(addMonster:) interval:1.5];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Pr frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    // 1
    CGPoint touchLocation = [touch locationInNode:self];
    
    // 2
    CGPoint offset    = ccpSub(touchLocation, _player.position);
    float   ratio     = offset.y/offset.x;
    int     targetX   = _player.contentSize.width/2 + self.contentSize.width;
    int     targetY   = (targetX*ratio) + _player.position.y;
    CGPoint targetPosition = ccp(targetX,targetY);
    
    // 3
    CCSprite *projectile = [CCSprite spriteWithImageNamed:@"projectile.png"];
    projectile.position = _player.position;
    projectile.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:projectile.contentSize.width/2.0f andCenter:projectile.anchorPointInPoints]; // 1
    projectile.physicsBody.collisionType = @"projectileCollision"; // 2
    projectile.physicsBody.collisionGroup = @"playerGroup";
    [_physicsWorld addChild:projectile];
    
    // 4
    CCActionMoveTo *actionMove   = [CCActionMoveTo actionWithDuration:1.5f position:targetPosition];
    CCActionRemove *actionRemove = [CCActionRemove action];
    [projectile runAction:[CCActionSequence actionWithArray:@[actionMove,actionRemove]]];
    
    [[OALSimpleAudio sharedInstance] playEffect:@"pew-pew-lei.caf"];
    
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair monsterCollision:(CCNode *)monster projectileCollision:(CCNode *)projectile {
    [monster removeFromParent];
    [projectile removeFromParent];
    _hits++;
    
    if (_hits == 3) {
        
        [WinningScene setGameDone: true];
        [[CCDirector sharedDirector] replaceScene:[WinningScene scene]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionInvalid duration:1.0f]];

    }
    
    return YES;
}



// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[Menu scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------
@end