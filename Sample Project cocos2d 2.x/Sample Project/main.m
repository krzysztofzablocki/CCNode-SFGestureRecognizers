//
//  main.m
//  Sample Project
//
//  Created by Krzysztof Zabłocki on 3/14/12.
//  Copyright Krzysztof Zabłocki 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"AppController");
    [pool release];
    return retVal;
}
