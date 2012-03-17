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
    
    self.isTouchEnabled = YES;
    
    static BOOL firstScene = YES;
    CGSize size = [CCDirector sharedDirector].winSize;
    if (firstScene) {
      CCLabelTTF *label = [CCLabelTTF labelWithString:@"Swipe to push scene" fontName:@"Verdana" fontSize:28];
      label.position = ccp(size.width * 0.5f, size.height * 0.5f);
      [self addChild:label];
      firstScene = NO;
      
      UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePushSceneGestureRecognizer:)];
      [self addGestureRecognizer:swipeGestureRecognizer];
      swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
      swipeGestureRecognizer.delegate = self;
      [swipeGestureRecognizer release];
    } else {
      CCLabelTTF *label = [CCLabelTTF labelWithString:@"Swipe to pop scene" fontName:@"Verdana" fontSize:28];
      label.position = ccp(size.width * 0.5f, size.height * 0.5f);
      [self addChild:label];
      UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopSceneGestureRecognizer:)];
      swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
      swipeGestureRecognizer.delegate = self;
      [self addGestureRecognizer:swipeGestureRecognizer];
      [swipeGestureRecognizer release];
    }
    
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
      [panGestureRecognizer release];
      
      //! pinch gesture recognizer
      UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
      [sprite addGestureRecognizer:pinchGestureRecognizer];
      pinchGestureRecognizer.delegate = self;
      [pinchGestureRecognizer release];
      
      //! rotation gesture recognizer
      UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGestureRecognizer:)];
      [sprite addGestureRecognizer:rotationGestureRecognizer];
      rotationGestureRecognizer.delegate = self;
      [rotationGestureRecognizer release];
      
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
  //! For swipe gesture recognizer we want it to be executed only if it occurs on the main layer, not any of the subnodes ( main layer is higher in hierarchy than children so it will be receiving touch by default ) 
  if ([gestureRecognizer class] == [UISwipeGestureRecognizer class]) {
    CGPoint pt = [touch locationInView:touch.view];
    pt = [[CCDirector sharedDirector] convertToGL:pt];
    
    for (CCNode *child in self.children) {
      if ([child isNodeInTreeTouched:pt]) {
        return NO;
      }
    }
  }
  
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

- (void)handlePushSceneGestureRecognizer:(UISwipeGestureRecognizer*)aGestureRecognizer
{
  CCScene *scene = [CCScene node];
  [scene addChild:[HelloWorldLayer scene]];
  [[CCDirector sharedDirector] pushScene:scene];
}

- (void)handlePopSceneGestureRecognizer:(UISwipeGestureRecognizer*)aGestureRecognizer
{
  [[CCDirector sharedDirector] popScene];
}
@end
