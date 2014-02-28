//
//  IntroScene.h
//  cram_a3
//
//  Created by Erin Cramer on 2/12/2014.
//  Copyright Erin Cramer 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using cocos2d-v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

/**
 *  The intro scene
 *  Note, that scenes should now be based on CCScene, and not CCLayer, as previous versions
 *  Main usage for CCLayer now, is to make colored backgrounds (rectangles)
 *
 */
@interface Menu : CCScene

// -----------------------------------------------------------------------

+ (Menu *)scene;
- (id)init;

// -----------------------------------------------------------------------
@end