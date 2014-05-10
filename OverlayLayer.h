//
//  OverlayLayer.h
//  Chapter 3 Layers
//
//  Created by Daniel Wallace [DATACOM] on 9/05/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface OverlayLayer : CAScrollLayer

-(void)drawPoint:(CGPoint)point;

-(void)drawPoint:(CGPoint)point withColor:(UIColor *)color;

-(void)drawPoint:(CGPoint)point withColor:(UIColor *)color label: (NSString *)string;

-(void)drawRect: (CGRect)rect;

@end
