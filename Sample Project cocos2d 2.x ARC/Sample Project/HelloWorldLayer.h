//
//  HelloWorldLayer.h
//  Sample Project
//
//  Created by Krzysztof Zabłocki on 3/14/12.
//  Copyright Krzysztof Zabłocki 2012. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <UIGestureRecognizerDelegate>
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
