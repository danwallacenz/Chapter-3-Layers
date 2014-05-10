//
//  OverlayLayer.h
//  Chapter 3 Layers
//
//  Created by Daniel Wallace [DATACOM] on 9/05/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface OverlayLayer : CAScrollLayer

//-(void)drawPoint:(CGPoint)point;
//
//-(CALayer *)drawPoint:(CGPoint)point withColor:(UIColor *)color;
//
//-(CALayer *)drawPoint:(CGPoint)point withColor:(UIColor *)color label: (NSString *)string;

-(CALayer *)drawPoint:(CGPoint)point withColor:(UIColor *)color label: (NSString *)label name: (NSString *)name;

//-(CALayer *)drawRect: (CGRect)rect;

-(void)drawRect: (CGRect)rect withName:(NSString *)name;

@end
