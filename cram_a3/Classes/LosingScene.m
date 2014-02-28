//
//  HelloWorldScene.m
//  cram_a3
//
//  Created by Erin Cramer on 2/12/2014.
//  Copyright Erin Cramer 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "Menu.h"
#import "LosingScene.h"

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation LosingScene


// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (LosingScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f]];
    [self addChild:background];
    
    //display winning message here
    CCLabelTTF *newLabel = [CCLabelTTF labelWithString:@"Loser!" fontName:@"Chalkduster" fontSize:36.0f];
    newLabel.positionType = CCPositionTypeNormalized;
    newLabel.color = [CCColor redColor];
    newLabel.position = ccp(0.5f, 0.60); // Middle of screen
    [self addChild:newLabel];
    
    // done
	return self;
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
    [self performSelector:@selector(goToMenu:) withObject:self afterDelay:3.0];
    
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

-(void) goToMenu:(id)myID {
    
    //go to level 2
    [[CCDirector sharedDirector] replaceScene:[Menu scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
    
}


@end