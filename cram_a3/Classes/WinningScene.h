//
//  WinningScene.h
//  cram_a3
//
//  Created by Erin Cramer on 2/13/2014.
//  Copyright (c) 2014 Erin Cramer. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"


@interface WinningScene : CCScene

+ (WinningScene*)scene;
- (id)init;
+ (void) setGameDone:(BOOL)value;

@end
