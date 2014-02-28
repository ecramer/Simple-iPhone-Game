//
//  InstructionsScene.m
//  cram_a3
//
//  Created by Erin Cramer on 2/13/2014.
//  Copyright (c) 2014 Erin Cramer. All rights reserved.
//

#import "InstructionsScene.h"
#import "Menu.h"

@implementation InstructionsScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (InstructionsScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Shoot at the monsters" fontName:@"Chalkduster" fontSize:18.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.80f); // Middle of screen
    [self addChild:label];
    
    CCLabelTTF *newLabel = [CCLabelTTF labelWithString:@"Don't let them cross the screen!" fontName:@"Chalkduster" fontSize:18.0f];
    newLabel.positionType = CCPositionTypeNormalized;
    newLabel.color = [CCColor redColor];
    newLabel.position = ccp(0.5f, 0.60); // Middle of screen
    [self addChild:newLabel];
    
    // done
	return self;
}

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[Menu scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
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

@end
