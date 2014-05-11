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
//@property CGSize imageSize;

@property (weak, nonatomic) IBOutlet UILabel *scrollToPointXLabel;
@property (weak, nonatomic) IBOutlet UILabel *scrollToPointYLabel;
@property (weak, nonatomic) IBOutlet UISlider *scrollToPointXSlider;
@property (weak, nonatomic) IBOutlet UISlider *scrollToPointYSlider;


@property (weak, nonatomic) IBOutlet UILabel *scrollToRectLabel;
@property float scrollToRectOriginX;
@property float scrollToRectOriginY;
@property (weak, nonatomic) IBOutlet UILabel *scrollToRectXSliderValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *scrollToRectYSliderValueLabel;

@property (weak, nonatomic) IBOutlet UISlider *scrollRectToXValueSlider;
@property (weak, nonatomic) IBOutlet UISlider *scrollRectToYValueSlider;


@property (weak, nonatomic) IBOutlet UITextView *caScrollLayerTextView;



//@property (weak, nonatomic) IBOutlet UILabel *cAScrollLayerBoundsLabel;


@end

@implementation SublayerPositioningViewController

- (IBAction)showHideGrid:(id)sender
{
    self.overlayLayer.hidden = !self.overlayLayer.hidden;
}

- (IBAction)scrollLayerMasksToBoundsToggle:(id)sender
{
    self.cAScrollLayer.masksToBounds = !self.cAScrollLayer.masksToBounds;
}

- (IBAction)scrollRectToOriginX:(UISlider *)sender
{
    self.scrollToRectOriginX = sender.value;
    self.scrollToRectXSliderValueLabel.text = [NSString stringWithFormat:@"%1.0f",self.scrollToRectOriginX ];
}

- (IBAction)scrollRectToOriginY:(UISlider *)sender
{
    self.scrollToRectOriginY = sender.value;
    self.scrollToRectYSliderValueLabel.text = [NSString stringWithFormat:@"%1.0f",self.scrollToRectOriginY ];
    
    
    CGPoint newOrigin = CGPointMake(self.cAScrollLayer.position.x - self.scrollRectToXValueSlider.value, self.cAScrollLayer.position.y - self.scrollRectToYValueSlider.value);
    
    CGSize imageSize = ((UIImage *)self.cAScrollLayer.sublayers[0]).size;
    
    CGRect imageBounds = CGRectMake(newOrigin.x, newOrigin.y, imageSize.width, imageSize.height);
    
    [self.overlayLayer drawRect: imageBounds withName:@"newRect bounds"];
}

- (IBAction)scrollToRect:(UIButton *)sender
{
    CGRect newRect = self.cAScrollLayer.frame;

    newRect.origin = CGPointMake(self.scrollToRectOriginX , self.scrollToRectOriginY);
    [self.cAScrollLayer scrollToRect: newRect];
    
    self.scrollToRectLabel.text
        = [NSString stringWithFormat:@"(%1.0f,%1.0f) h:%1.0f, w:%1.0f", newRect.origin.x, newRect.origin.y, newRect.size.width, newRect.size.height];

    // draw various things
//    [self.overlayLayer drawPoint: self.cAScrollLayer.position withColor: [UIColor orangeColor] label: @"cAScrollLayer.position" name: @"cAScrollLayer.position"];
//    
    CGPoint boundsOrigin = CGPointMake(self.cAScrollLayer.position.x - self.cAScrollLayer.bounds.origin.x, self.cAScrollLayer.position.y - self.cAScrollLayer.bounds.origin.y);
    
//    [self.overlayLayer drawPoint: boundsOrigin withColor:[UIColor greenColor] label: @"bounds.origin" name:@"bounds.origin"] ;
//    
    CGSize imageSize = ((UIImage *)self.cAScrollLayer.sublayers[0]).size;
//
//    CGPoint boundsTopRight = CGPointMake(boundsOrigin.x + imageSize.width, boundsOrigin.y );
//    [self.overlayLayer drawPoint: boundsTopRight withColor: [UIColor blueColor] label: @"bounds top right" name:@"bounds.top.right"];
    
    CGRect imageBounds = CGRectMake(boundsOrigin.x, boundsOrigin.y, imageSize.width, imageSize.height);
    [self.overlayLayer drawRect: imageBounds withName:@"image bounds"];
    
    [self drawCAScrollLayer];
}


#pragma mark scrollToPoint:
- (IBAction)scrollToPointX:(UISlider *)sender
{
    
    CGPoint scrollPoint = CGPointMake((self.cAScrollLayer.position.x + sender.value), (self.cAScrollLayer.position.y + self.scrollToPointYSlider.value));

    self.scrollToPointXLabel.text = [NSString stringWithFormat:@"%1.0f", sender.value];
    
//    CGPoint convertedPoint = [self.view.layer convertPoint:scrollPoint fromLayer: self.cAScrollLayer];
    CGPoint convertedPoint = [self.cAScrollLayer convertPoint:scrollPoint toLayer: self.cAScrollLayer.sublayers[0]];
    
    [self.overlayLayer drawPoint: convertedPoint
                       withColor: [UIColor yellowColor]
                           label: [NSString stringWithFormat:  @"scrollPoint: (%1.0f,%1.0f)", convertedPoint.x, convertedPoint.y]
                            name:@"scroll.point"];
   
    [self drawCAScrollLayer];
}

- (IBAction)scrollToPointY:(UISlider *)sender
{
    CGPoint scrollPoint = CGPointMake( (self.cAScrollLayer.position.x + self.scrollToPointXSlider.value), (self.cAScrollLayer.position.y + sender.value) );

    self.scrollToPointYLabel.text = [NSString stringWithFormat:@"%1.0f", sender.value];

    CGPoint convertedPoint = [self.cAScrollLayer convertPoint:scrollPoint toLayer: self.cAScrollLayer.sublayers[0]];
    
    [self.overlayLayer drawPoint: convertedPoint
                       withColor: [UIColor yellowColor]
                           label: [NSString stringWithFormat:  @"scrollPoint: (%1.0f,%1.0f)", convertedPoint.x, convertedPoint.y]
                            name:@"scroll.point"];
    
    [self drawCAScrollLayer];
}

- (IBAction)scrollToPoint:(id)sender
{
    CGPoint scrollPoint = CGPointMake(self.scrollToPointXSlider.value, self.scrollToPointYSlider.value);
    
//    CGPoint convertedPoint = [self.view.layer convertPoint:scrollPoint fromLayer: self.cAScrollLayer];
    
    [self.cAScrollLayer scrollToPoint: scrollPoint];
    
    [self drawCAScrollLayer];
}

#pragma draw points

-(void)drawCAScrollLayer
{
    // draw various things
//    [self.overlayLayer drawPoint: self.cAScrollLayer.position withColor: [UIColor orangeColor] label: @"cAScrollLayer.position" name: @"cAScrollLayer.position"];
    [self.overlayLayer drawPoint: self.cAScrollLayer.position
                       withColor: [UIColor greenColor]
                           label: [NSString stringWithFormat:@"bounds origin: (%1.0f,%1.0f)",self.cAScrollLayer.bounds.origin.x, self.cAScrollLayer.bounds.origin.y]
                            name: @"cAScrollLayer.position"];
    
    CGPoint boundsOrigin = CGPointMake(self.cAScrollLayer.position.x - self.cAScrollLayer.bounds.origin.x, self.cAScrollLayer.position.y - self.cAScrollLayer.bounds.origin.y);
    
//    [self.overlayLayer drawPoint: boundsOrigin withColor:[UIColor greenColor] label: @"sublayer origin" name:@"bounds.origin"] ;
    
    CGSize imageSize = ((UIImage *)self.cAScrollLayer.sublayers[0]).size;
    
//    CGPoint boundsTopRight = CGPointMake(boundsOrigin.x + imageSize.width, boundsOrigin.y );
//    [self.overlayLayer drawPoint: boundsTopRight withColor: [UIColor greenColor] label: @"bounds top right" name:@""];
    
    CGRect imageBounds = CGRectMake(boundsOrigin.x, boundsOrigin.y, imageSize.width, imageSize.height);
    [self.overlayLayer drawRect: imageBounds withName:@"image bounds"];
    
    NSString *position = [NSString stringWithFormat: @"position: %1.0f, %1.0f",self.cAScrollLayer.position.x, self.cAScrollLayer.position.y];
    
    NSString *anchorPoint = [NSString stringWithFormat: @"anchorPoint: %1.0f, %1.0f",self.cAScrollLayer.anchorPoint.x, self.cAScrollLayer.anchorPoint.y];
    
    NSString *bounds = [NSString stringWithFormat: @"bounds: %1.0f, %1.0f, %1.0f, %1.0f",self.cAScrollLayer.bounds.origin.x, self.cAScrollLayer.bounds.origin.y, self.cAScrollLayer.bounds.size.width, self.cAScrollLayer.bounds.size.height];
    
    self.caScrollLayerTextView.text = [NSString stringWithFormat:@"%@\n%@\n%@", position, anchorPoint, bounds];
}

#pragma mark anchorPoint
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

#pragma mark UIViewController methods

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
    
    [self initLayers];
    
    self.caScrollLayerTextView.layer.cornerRadius = 20.0f;
    self.caScrollLayerTextView.layer.masksToBounds = YES;
    self.caScrollLayerTextView.contentInset =  UIEdgeInsetsMake(10.0, 40.0, 20.0, 20.0);
    self.caScrollLayerTextView.textColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark initialization

- (IBAction)resetView:(id)sender
{
    [self.layer0 removeFromSuperlayer];
    [self.cAScrollLayer removeFromSuperlayer];
    [self.overlayLayer removeFromSuperlayer];
    
    [self initLayers];
}

-(void)initLayers
{
    // black rectangle
    self.layer0 = [CALayer new];
    //    self.layer0.frame = CGRectMake(0, 0, 100, 100);
    // bounds and position is better for CALayers.
    self.layer0.bounds = CGRectMake(0, 0, 100, 100);
    self.layer0.position = CGPointMake(50, 50);
    self.layer0.anchorPoint = CGPointMake(0.5, 0.5);
    //    self.layer0.backgroundColor = [[UIColor blackColor] CGColor];
    self.layer0.backgroundColor = [UIColor colorWithRed:127.0/255.0 green:67.0/255.0 blue:119.0/255.0 alpha:0.8].CGColor;
    [self.view.layer addSublayer:self.layer0];
    [self addPositionMark:self.layer0];
    [self addAnchorPointMark: self.layer0];
    
    self.cAScrollLayer = [self createMonaLisaScrollLayer];
    [self.view.layer addSublayer:  self.cAScrollLayer];
    
    self.overlayLayer = [OverlayLayer new];
    [self.view.layer addSublayer:  self.overlayLayer];
    [self.overlayLayer setNeedsDisplay];
//    self.overlayLayer.hidden = YES;
    
    [self drawCAScrollLayer];
}

- (CAScrollLayer *) createMonaLisaScrollLayer
{
    UIImage *monaLisa = [UIImage imageNamed:@"396px-Mona_Lisa.png"];
    
    CAScrollLayer *cAScrollLayer = [CAScrollLayer new];
    cAScrollLayer.bounds = CGRectIntegral(CGRectMake(0, 0, monaLisa.size.width, monaLisa.size.height));
//    cAScrollLayer.position =  CGPointMake( self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
    cAScrollLayer.position =  CGPointMake( 300, 200);
    cAScrollLayer.anchorPoint = CGPointMake(0,0); // top left
    
//    cAScrollLayer.backgroundColor = [[UIColor whiteColor] CGColor];
    cAScrollLayer.backgroundColor = [UIColor colorWithRed:204/255.0 green:107/255.0 blue:191/255.0 alpha:0.4].CGColor;
    
    CALayer *imageLayer = [CALayer new];
    imageLayer.frame = CGRectMake(0, 0, cAScrollLayer.bounds.size.width * 2.0, cAScrollLayer.bounds.size.height * 2.0);
    imageLayer.contents = (id)monaLisa.CGImage;
    [cAScrollLayer addSublayer:imageLayer];
    cAScrollLayer.opaque = YES;
    cAScrollLayer.borderColor = [UIColor redColor].CGColor;
    cAScrollLayer.borderWidth = 2.0;
    
    return cAScrollLayer;
}

#pragma mark -

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
