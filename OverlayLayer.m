//
//  OverlayLayer.m
//  Chapter 3 Layers
//
//  Created by Daniel Wallace [DATACOM] on 9/05/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "OverlayLayer.h"

@interface OverlayLayer ()

@property (strong, nonatomic) CAShapeLayer *grid;
@property (strong, nonatomic) CATextLayer *text;
@property (strong, nonatomic) NSMutableArray *points;
@property (strong, nonatomic) NSMutableArray *rects;

@property (strong, nonatomic) NSMutableDictionary *layers;

@property BOOL labelsDrawn;

@end

@implementation OverlayLayer


-(void)drawRect: (CGRect)rect withName:(NSString *)name
{
    
    if(!self.layers){
        self.layers = [NSMutableDictionary new];
    }
    CALayer *previous = [self.layers objectForKey:name];
    if(previous){
        [previous removeFromSuperlayer];
        [self.layers removeObjectForKey:name];
        previous = nil;
    }
    [self.layers setObject: [self drawRect:rect] forKey:name];
}

-(CALayer *)drawRect: (CGRect)rect
{
    CAShapeLayer *rectLayer = [CAShapeLayer new];
    rectLayer.contentsScale = [UIScreen mainScreen].scale;
    rectLayer.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1].CGColor;
    rectLayer.lineWidth = 2.0;
    rectLayer.lineDashPattern = @[@2,@3];
    rectLayer.strokeColor = [UIColor whiteColor].CGColor;
    
//    rectLayer.opaque = NO;
//    rectLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, rect);
    rectLayer.path = path;
    CGPathRelease(path);
    
    if(!self.rects){
        self.rects = [[NSMutableArray alloc]init];
    }
    [self.rects addObject:rectLayer];
    
    [self addSublayer:rectLayer];
    [self setNeedsDisplay];
    
    return rectLayer;
}

-(void)drawPoint:(CGPoint)point withColor:(UIColor *)color label: (NSString *)string
{
    [self drawPoint:point withColor: color];
    CATextLayer *label = [self drawText: string atPoint: CGPointMake(point.x, point.y + 20.0)];
    [self addSublayer: label];
}


-(void)drawPoint:(CGPoint)point
{
    [self drawPoint:point withColor: [UIColor redColor]];
}

-(void)drawPoint:(CGPoint)point withColor:(UIColor *)color
{
    
    CAShapeLayer *pointLayer = [CAShapeLayer new];
    pointLayer.contentsScale = [UIScreen mainScreen].scale;
    pointLayer.fillColor = color.CGColor;
    pointLayer.lineWidth = 2.0;
    pointLayer.strokeColor = color.CGColor;
    pointLayer.bounds = CGRectMake(0, 0, 5, 5);
    pointLayer.position = point;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, pointLayer.bounds);
    pointLayer.path = path;
    CGPathRelease(path);
    
    if(!self.points){
        self.points = [[NSMutableArray alloc]init];
    }
    [self.points addObject:pointLayer];
    
    [self addSublayer:pointLayer];
    [self setNeedsDisplay];
    
}

- (void)display
{

    self.bounds = [UIScreen mainScreen].bounds;
    self.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
//    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.2].CGColor;
    
    if(!self.grid){
        self.grid = [self createGrid];
        [self addSublayer: self.grid];
    }
    
    if(!self.labelsDrawn){
        [self createCoordinateLabels];
        self.labelsDrawn = YES;
    }
    
    for (CALayer *point in self.points) {
        [point removeFromSuperlayer];
    }
    
    for (CALayer *point in self.points) {
        [self addSublayer:point];
    }
}

- (void) createCoordinateLabels
{
    for (int x=0; x < self.bounds.size.width; x += 100) {
        for (int y=0 ; y < self.bounds.size.height; y +=100) {
            [self addSublayer:[self drawCoordinateAtPoint: CGPointMake(x, y)]];
        }
    }
}

-(CATextLayer *)drawCoordinateAtPoint: (CGPoint)point
{
    return [self drawText:[NSString stringWithFormat:@"(%1.0f, %1.0f)",point.x, point.y ] atPoint:point];
}

-(CATextLayer *)drawText: (NSString *)string atPoint: (CGPoint)point
{
    CATextLayer *text = [CATextLayer new];
    text.contentsScale = [UIScreen mainScreen].scale;
    text.string = string;
    text.bounds = CGRectMake(0, 0, 100, 30);
    text.position = point;
    text.alignmentMode = kCAAlignmentCenter;
    text.foregroundColor = [[UIColor whiteColor] colorWithAlphaComponent: 0.8].CGColor;
    text.fontSize = 10.0;
    return text;
}

//-(CATextLayer *)createTextAtPoint: (CGPoint)point
//{
//    CATextLayer *text = [CATextLayer new];
//    text.contentsScale = [UIScreen mainScreen].scale;
//    text.string = [NSString stringWithFormat:@"(%1.0f, %1.0f)",point.x, point.y ];
//    text.bounds = CGRectMake(0, 0, 100, 30);
//    text.position = point;
//    text.alignmentMode = kCAAlignmentCenter;
//    text.foregroundColor = [[UIColor whiteColor] colorWithAlphaComponent: 0.8].CGColor;
//    text.fontSize = 10.0;
//    return text;
//}

- (CAShapeLayer *)createGrid
{
    CAShapeLayer *grid = [CAShapeLayer new];

    grid.contentsScale = [UIScreen mainScreen].scale;
    grid.lineWidth = 2.0;
    grid.fillColor = [[UIColor blackColor] colorWithAlphaComponent: 0.1].CGColor;
    grid.strokeColor = [[UIColor grayColor] colorWithAlphaComponent: 0.5].CGColor;
    
    CGMutablePathRef p = CGPathCreateMutable();
    CGFloat lineWidth = 1.0;
    
    // height and width are flipped in landscape
    float height = 0;
    float width = 0;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(orientation == UIInterfaceOrientationPortrait){
        height = self.bounds.size.height;
        width = self.bounds.size.width;
    }else{
        height = self.bounds.size.width;
        width = self.bounds.size.height;
    }
    
    // draw horizontal lines.
    for (int y=0; y < self.bounds.size.height; y += 100) {
        CGPathAddRect(p, nil, CGRectIntegral(CGRectMake(0.0, y, width, lineWidth)));
    }
    
    // draw vertical lines
    for (int x=0; x < self.bounds.size.width; x += 100) {
        CGPathAddRect(p, nil, CGRectIntegral( CGRectMake(x, 0.0, lineWidth, height)));
    }

    grid.path = p;
    CGPathRelease(p);
    
    return grid;
}

@end
