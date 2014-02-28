//
//  LevelOneScene.h
//  cram_a3
//
//  Created by Erin Cramer on 2/12/2014.
//  Copyright Erin Cramer 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using Cocos2D v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface LevelOneScene : CCScene <CCPhysicsCollisionDelegate>

// -----------------------------------------------------------------------

+ (LevelOneScene *)scene;
- (id)init;

// -----------------------------------------------------------------------
@end