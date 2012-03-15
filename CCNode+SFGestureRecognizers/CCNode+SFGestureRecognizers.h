//
//  CCNode+GestureRecognizers.h
//  Kubik
//
//  Created by Krzysztof Zablocki on 2/12/12.
//  Copyright (c) 2012 Krzysztof Zablocki. All rights reserved.
//
#import "cocos2d.h"

//! do you want to use sf_method or just method, disable shorthand if you have problems with methods names duplication from other code
#define SF_GESTURE_RECOGNIZERS_USE_SHORTHAND 1

//! when you add gesture recognizer to any node it will set isTouchEnabled on this node
#define SF_GESTURE_RECOGNIZERS_AUTO_ENABLE_TOUCH_ON_NEW_GESTURE_RECOGNIZER 0


@interface UIGestureRecognizer (SFGestureRecognizers)
#if SF_GESTURE_RECOGNIZERS_USE_SHORTHAND
@property (nonatomic, readonly) CCNode *node;
#else
@property (nonatomic, readonly) CCNode *sf_node;
#endif
@end

@interface CCNode (SFGestureRecognizers)

#if SF_GESTURE_RECOGNIZERS_USE_SHORTHAND
@property (nonatomic, assign) BOOL isTouchEnabled;
@property (nonatomic, assign) CGRect touchRect;

- (void)addGestureRecognizer:(UIGestureRecognizer*)aGestureRecognizer;
- (void)removeGestureRecognizer:(UIGestureRecognizer*)aGestureRecognizer;
- (NSArray*)gestureRecognizers;

- (BOOL)isPointInArea:(CGPoint)pt;
- (BOOL)isNodeInTreeTouched:(CGPoint)pt;
#else
@property (nonatomic, assign, setter=sf_setIsTouchEnabled:) BOOL sf_isTouchEnabled;
@property (nonatomic, assign, setter=sf_setTouchRect:) CGRect sf_touchRect;

- (void)sf_addGestureRecognizer:(UIGestureRecognizer*)aGestureRecognizer;
- (void)sf_removeGestureRecognizer:(UIGestureRecognizer*)aGestureRecognizer;
- (NSArray*)sf_gestureRecognizers;

- (BOOL)sf_isPointInArea:(CGPoint)pt;
- (BOOL)sf_isNodeInTreeTouched:(CGPoint)pt;
#endif
@end
