Purpose
--------------

CCNode+SFGestureRecognizers is a category designed to simplify adding UIGestureRecognizers support in cocos2d. 
It removes the need to change cocos2d source code so that you can update your cocos2d anytime new versions are released.

Supported OS & SDK Versions
-----------------------------

* iOS 4.0 (Xcode 4.3, Apple LLVM compiler 3.1)
* cocos2d version 1.x or 2.x works fine.

ARC Compatibility
------------------

CCNode+SFGestureRecognizers automatically works with both ARC and non-ARC projects through conditional compilation. There is no need to exclude CCNode+SFGestureRecognizers files from the ARC validation process, or to convert CCNode+SFGestureRecognizers using the ARC conversion tool.

Installation
--------------

To use the CCNode+SFGestureRecognizers category in an app, just drag the category files (demo files and assets are not needed) into your project.
Include the CCNode+SFGestureRecognizers.h in your Prefix.pch file so that you can use it everywhere.

Properties
--------------
CCNode+SFGestureRecognizers adds following properties / methods to CCNode:

    @property (nonatomic, assign) BOOL isTouchEnabled;
Defines if touches are enabled, if you disable it no gesture will be working.    
    
    @property (nonatomic, assign) CGRect touchRect;
Defines touchable rectangle in node local coordinate space.

    - (void)addGestureRecognizer:(UIGestureRecognizer*)aGestureRecognizer;
Adds gesture recognizer to node.
    
    - (void)removeGestureRecognizer:(UIGestureRecognizer*)aGestureRecognizer;
Removes gesture recognizer from node.
    
    - (NSArray*)gestureRecognizers;
Returns all gesture recognizers that are bound to this node.

    - (BOOL)isPointInArea:(CGPoint)pt;
Tests if point is touchable in selected area without testing children nodes.    
    
    - (BOOL)isNodeInTreeTouched:(CGPoint)pt;
Tests if points is touchable in a node or any of its children nodes.

CCNode+SFGestureRecognizers also adds this property in UIGestureRecognizer class:

    @property (nonatomic, readonly) CCNode *node;
Node that this gesture is added to.


