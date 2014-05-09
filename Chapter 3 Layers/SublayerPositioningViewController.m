//
//  SublayerPositioningViewController.m
//  Chapter 3 Layers
//
//  Created by Daniel Wallace [DATACOM] on 7/05/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "SublayerPositioningViewController.h"
#import "OverlayLayer.h"

@interface SublayerPositioningViewController ()

@property (strong, nonatomic) CALayer *layer0;
@property  (strong, nonatomic) OverlayLayer *overlayLayer;

@property (weak, nonatomic) IBOutlet UISlider *xPositionSlider;
@property (weak, nonatomic) IBOutlet UILabel *positionXLabel;

@property (weak, nonatomic) IBOutlet UISlider *yPositionSlider;
@property (weak, nonatomic) IBOutlet UILabel *positionYLabel;

@property (weak, nonatomic) IBOutlet UISlider *anchorPointXSlider;
@property (weak, nonatomic) IBOutlet UILabel *anchorPointXLabel;

@property (weak, nonatomic) IBOutlet UISlider *anchorPointYSlider;
@property (weak, nonatomic) IBOutlet UILabel *anchorPointYLabel;

@property (strong, nonatomic) UIView *currentCenterMark;
@property (strong, nonatomic) UIView *currentAnchorPointMark;

@property (weak, nonatomic) CAScrollLayer *cAScrollLayer;
@property (weak, nonatomic) CALayer *imageLayer;

@property (weak, nonatomic) IBOutlet UILabel *scrollToPointXLabel;
@property (weak, nonatomic) IBOutlet UILabel *scrollToPointYLabel;

@end

@implementation SublayerPositioningViewController


- (IBAction)scrollToRect:(UIButton *)sender {
    self.cAScrollLayer.masksToBounds = NO;
    CGRect newRect = self.cAScrollLayer.frame;
    newRect.origin = CGPointMake(newRect.origin.x + 20.0 , newRect.origin.y + 20.0);
    
    newRect = [self.cAScrollLayer convertRect:newRect fromLayer: self.view.layer];
    
    [self.cAScrollLayer scrollToRect: newRect];
    self.cAScrollLayer.masksToBounds = YES;
}


- (IBAction)scrollToPointX:(UISlider *)sender
{
    [self.cAScrollLayer scrollToPoint: CGPointMake(sender.value, self.cAScrollLayer.bounds.origin.y)];
     self.scrollToPointXLabel.text = [NSString stringWithFormat:@"%f", sender.value];
}

- (IBAction)scrollToPointY:(UISlider *)sender
{
    [self.cAScrollLayer scrollToPoint: CGPointMake( self.cAScrollLayer.bounds.origin.x, sender.value )];
    self.scrollToPointYLabel.text = [NSString stringWithFormat:@"%f", sender.value];
}

- (IBAction)anchorPointXChanged:(UISlider *)sender
{
    self.layer0.anchorPoint = CGPointMake(sender.value, self.anchorPointYSlider.value);
    self.anchorPointXLabel.text = [NSString stringWithFormat:@"%f", sender.value];
    [self addAnchorPointMark: self.layer0];
    [self addPositionMark: self.layer0];
    NSLog(@" ");
    NSLog(@"self.layer0.anchorPoint=%f %f", self.layer0.anchorPoint.x, self.layer0.anchorPoint.y);
    NSLog(@"self.layer0.position=%f %f", self.layer0.position.x, self.layer0.position.y);
}

- (IBAction)anchorPointY:(UISlider *)sender
{
    self.layer0.anchorPoint = CGPointMake( self.anchorPointXSlider.value, sender.value);
    self.anchorPointYLabel.text = [NSString stringWithFormat:@"%f", sender.value];
    [self addAnchorPointMark: self.layer0];
    [self addPositionMark: self.layer0];
    NSLog(@" ");
    NSLog(@"self.layer0.anchorPoint=%f %f", self.layer0.anchorPoint.x, self.layer0.anchorPoint.y);
    NSLog(@"self.layer0.position=%f %f", self.layer0.position.x, self.layer0.position.y);
}

- (IBAction)xPositionChanged:(UISlider *)sender
{
    self.layer0.position = CGPointMake(sender.value, self.yPositionSlider.value);
    self.positionXLabel.text = [NSString stringWithFormat:@"%f", sender.value];
    [self addAnchorPointMark: self.layer0];
    [self addPositionMark:self.layer0];
    NSLog(@" ");
    NSLog(@"self.layer0.anchorPoint=%f %f", self.layer0.anchorPoint.x, self.layer0.anchorPoint.y);
    NSLog(@"self.layer0.position=%f %f", self.layer0.position.x, self.layer0.position.y);
}


- (IBAction)yPositionChanged:(UISlider *)sender
{
    self.layer0.position = CGPointMake(self.xPositionSlider.value, sender.value);
    self.positionYLabel.text = [NSString stringWithFormat:@"%f", sender.value];
    [self addAnchorPointMark: self.layer0];
    [self addPositionMark: self.layer0];
    NSLog(@" ");
    NSLog(@"self.layer0.anchorPoint=%f %f", self.layer0.anchorPoint.x, self.layer0.anchorPoint.y);
    NSLog(@"self.layer0.position=%f %f", self.layer0.position.x, self.layer0.position.y);
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // black rectangle
    self.layer0 = [CALayer new];
//    self.layer0.frame = CGRectMake(0, 0, 100, 100);
    // bounds and position is better for CALayers.
    self.layer0.bounds = CGRectMake(0, 0, 100, 100);
    self.layer0.position = CGPointMake(50, 50);
    self.layer0.anchorPoint = CGPointMake(0.5, 0.5);
    self.layer0.backgroundColor = [[UIColor blackColor] CGColor];
    [self.view.layer addSublayer:self.layer0];
    [self addPositionMark:self.layer0];
    [self addAnchorPointMark: self.layer0];
    
    self.cAScrollLayer = [self createMonaLisaScrollLayer];
    [self.view.layer addSublayer:  self.cAScrollLayer];
    
    self.overlayLayer = [OverlayLayer new];
    [self.view.layer addSublayer:  self.overlayLayer];
}

- (CAScrollLayer *) createMonaLisaScrollLayer
{
    UIImage *monaLisa = [UIImage imageNamed:@"396px-Mona_Lisa.png"];
    
    CAScrollLayer *cAScrollLayer = [CAScrollLayer new];
    cAScrollLayer.bounds = CGRectIntegral(CGRectMake(0, 0, monaLisa.size.width, monaLisa.size.height));
    cAScrollLayer.position =  CGPointMake( self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
    cAScrollLayer.backgroundColor = [[UIColor whiteColor] CGColor];
    
    CALayer *imageLayer = [CALayer new];
    imageLayer.frame = CGRectMake(0, 0, cAScrollLayer.bounds.size.width * 2.0, cAScrollLayer.bounds.size.height * 2.0);
    imageLayer.contents = (id)monaLisa.CGImage;
    [cAScrollLayer addSublayer:imageLayer];
    
    return cAScrollLayer;
//    [self.view.layer addSublayer: cAScrollLayer];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addPositionMark: (CALayer*)layer
{
    [self.currentCenterMark removeFromSuperview];
    self.currentCenterMark = nil;
    
    CGPoint position = [self.view.layer convertPoint: layer.position fromLayer: layer.superlayer];
    NSLog(@"position = %f, %f", position.x, position.y);
    
    CGRect centerRect = CGRectMake(0, 0, 4, 4);
    
    UIView *centerPoint = [[UIView alloc] initWithFrame: centerRect];
    centerPoint.center = position;
    
    centerPoint.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:centerPoint];
    self.currentCenterMark = centerPoint;
}


# warning TODO Check this
- (void) addAnchorPointMark: (CALayer*)layer
{
    [self.currentAnchorPointMark removeFromSuperview];
    self.currentAnchorPointMark = nil;
    
    CGFloat anchorPointX = layer.anchorPoint.x * layer.bounds.size.width;
    CGFloat anchorPointY = layer.anchorPoint.y * layer.bounds.size.height;

    CGPoint anchorPoint = CGPointMake(anchorPointX, anchorPointY);
    CGPoint anchorPointConverted = [self.view.layer convertPoint: anchorPoint fromLayer: layer.superlayer];
    NSLog(@"anchorPoint = %f, %f", anchorPointConverted.x, anchorPointConverted.y);
    
    CGRect centerRect = CGRectMake(0, 0, 4, 4);
    
    UIView *anchorPointView = [[UIView alloc] initWithFrame: centerRect];
    anchorPointView.center = anchorPointConverted;
    
    anchorPointView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:anchorPointView];
    self.currentAnchorPointMark = anchorPointView;
}

@end
