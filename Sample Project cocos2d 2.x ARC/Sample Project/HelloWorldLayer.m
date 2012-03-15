//
//  HelloWorldLayer.m
//  Sample Project
//
//  Created by Krzysztof Zabłocki on 3/14/12.
//  Copyright Krzysztof Zabłocki 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "CCNode+SFGestureRecognizers.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

static NSString * const UIGestureRecognizerNodeKey = @"UIGestureRecognizerNodeKey";
#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {
    
    
    static BOOL firstScene = YES;
    CCMenuItem *button = nil;
    if (firstScene) {
      if ([[CCMenuItemFont class] respondsToSelector:@selector(itemWithString:block:)]) {
        button = [CCMenuItemFont itemWithString:@"Push next scene" block:^(id sender) {
          [[CCDirector sharedDirector] pushScene:[HelloWorldLayer scene]];
        }];
      } else {
        button = [CCMenuItemFont itemFromString:@"Push next scene" block:^(id sender) {
          [[CCDirector sharedDirector] pushScene:[HelloWorldLayer scene]];
        }];
      }
      firstScene = NO;
    } else {
      if ([[CCMenuItemFont class] respondsToSelector:@selector(itemWithString:block:)]) {
      button = [CCMenuItemFont itemWithString:@"Pop scene" block:^(id sender) {
        [[CCDirector sharedDirector] popScene];
      }];
      } else {
        button = [CCMenuItemFont itemFromString:@"Pop scene" block:^(id sender) {
          [[CCDirector sharedDirector] popScene];
        }];
      }
    }
		
		CCMenu *menu = [CCMenu menuWithItems:button, nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
    CGSize size = [CCDirector sharedDirector].winSize;
		[menu setPosition:ccp( size.width/2, size.height/2 - 50)];
		
		// Add the menu to the layer
		[self addChild:menu];
    
    
    //! add some random nodes
    int count = arc4random() % 12 + 4;
    for (int i=0; i < count; ++i) {
      CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
      sprite.scale = 0.5f;
      sprite.position = ccp(arc4random() % (int)size.width, arc4random() % (int)size.height);
      sprite.isTouchEnabled = YES;
      
      //! pan gesture recognizer
      UIGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
      panGestureRecognizer.delegate = self;
      [sprite addGestureRecognizer:panGestureRecognizer];
      
      //! pinch gesture recognizer
      UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
      [sprite addGestureRecognizer:pinchGestureRecognizer];
      pinchGestureRecognizer.delegate = self;
      
      //! rotation gesture recognizer
      UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGestureRecognizer:)];
      [sprite addGestureRecognizer:rotationGestureRecognizer];
      rotationGestureRecognizer.delegate = self;
      
      [self addChild:sprite];
    }
    
	}
	return self;
}

#pragma mark - GestureRecognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
  return YES;
}

- (void)handlePanGesture:(UIPanGestureRecognizer*)aPanGestureRecognizer
{
  CCNode *node = aPanGestureRecognizer.node;
  CGPoint translation = [aPanGestureRecognizer translationInView:aPanGestureRecognizer.view];
  translation.y *= -1;
  [aPanGestureRecognizer setTranslation:CGPointZero inView:aPanGestureRecognizer.view];
  
  node.position = ccpAdd(node.position, translation);
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer*)aPinchGestureRecognizer
{
  if (aPinchGestureRecognizer.state == UIGestureRecognizerStateBegan || aPinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
    CCNode *node = aPinchGestureRecognizer.node;
    float scale = [aPinchGestureRecognizer scale];
    node.scale *= scale;
    aPinchGestureRecognizer.scale = 1;
  }
}

- (void)handleRotationGestureRecognizer:(UIRotationGestureRecognizer*)aRotationGestureRecognizer
{
  if (aRotationGestureRecognizer.state == UIGestureRecognizerStateBegan || aRotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
    CCNode *node = aRotationGestureRecognizer.node;
    float rotation = aRotationGestureRecognizer.rotation;
    node.rotation += CC_RADIANS_TO_DEGREES(rotation);
    aRotationGestureRecognizer.rotation = 0;
  }
}

// on "dealloc" you need to release all your retained objects

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
