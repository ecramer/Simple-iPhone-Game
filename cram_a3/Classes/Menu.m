//
//  IntroScene.m
//  cram_a3
//
//  Created by Erin Cramer on 2/12/2014.
//  Copyright Erin Cramer 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "Menu.h"
#import "LevelOneScene.h"
#import "InstructionsScene.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation Menu

static bool hasStarted;


// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (Menu *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    
    if (!hasStarted) {
        
        [[OALSimpleAudio sharedInstance] playBg:@"background-music-aac.caf" loop:YES];
        hasStarted = true;
        
        
    }
    
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Erin's World" fontName:@"Chalkduster" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.80f); // Middle of screen
    [self addChild:label];
    
    // Spinning scene button
    CCButton *playGameButton = [CCButton buttonWithTitle:@"[ Play Game ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    playGameButton.positionType = CCPositionTypeNormalized;
    playGameButton.position = ccp(0.5f, 0.40f);
    [playGameButton setTarget:self selector:@selector(onPlayGameClicked:)];
    [self addChild:playGameButton];

    // Next scene button
    CCButton *stopMusicButton = [CCButton buttonWithTitle:@"[ Stop Music ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    stopMusicButton.positionType = CCPositionTypeNormalized;
    stopMusicButton.position = ccp(0.5f, 0.30f);
    [stopMusicButton setTarget:self selector:@selector(onStopMusicClicked:)];
    [self addChild:stopMusicButton];
    
    // Next scene button
    CCButton *playMusicButton = [CCButton buttonWithTitle:@"[ Play Music ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    playMusicButton.positionType = CCPositionTypeNormalized;
    playMusicButton.position = ccp(0.5f, 0.20f);
    [playMusicButton setTarget:self selector:@selector(onPlayMusicClicked:)];
    [self addChild:playMusicButton];
    
    // Next scene button
    CCButton *instructionsButton = [CCButton buttonWithTitle:@"[ Instructions ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    instructionsButton.positionType = CCPositionTypeNormalized;
    instructionsButton.position = ccp(0.5f, 0.10f);
    [instructionsButton setTarget:self selector:@selector(onInstructionsClicked:)];
    [self addChild:instructionsButton];
	
    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onPlayGameClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[LevelOneScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

- (void)onStopMusicClicked:(id)sender
{
    //stop the music
    [[OALSimpleAudio sharedInstance] stopEverything];
    
    
}

-(void)onPlayMusicClicked:(id)sender
{
    
    //start that wonderful music
    [[OALSimpleAudio sharedInstance] playBg:@"background-music-aac.caf" loop:YES];
    
}

-(void)onInstructionsClicked:(id)sender
{
    
    [[CCDirector sharedDirector] replaceScene:[InstructionsScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
    
}

// -----------------------------------------------------------------------
@end
