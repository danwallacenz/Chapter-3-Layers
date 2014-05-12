//
//  ContentResizinAndPositioningViewController.m
//  Chapter 3 Layers
//
//  Created by Daniel Wallace [DATACOM] on 12/05/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "ContentResizinAndPositioningViewController.h"
#import "OverlayLayer.h"

@interface ContentResizinAndPositioningViewController ()

@property (strong, nonatomic) CALayer *monaLisaFrameLayer;
//@property (strong, nonatomic) CALayer *monaLisaLayer;
@property  (strong, nonatomic) OverlayLayer *overlayLayer;

@property (weak, nonatomic) IBOutlet UILabel *contentsGravityValueLabel;

@property (weak, nonatomic) IBOutlet UISlider *contentsRectWidthSlider;
@property (weak, nonatomic) IBOutlet UISlider *contentsRectHeightSlider;
@property (weak, nonatomic) IBOutlet UILabel *contentsRectWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentsRectHeightLabel;

@end

@implementation ContentResizinAndPositioningViewController



#pragma mark actions

- (IBAction)contentsRectWidthChanged:(UISlider *)sender
{
//    CGFloat width = self.contentsRectWidthSlider.value;
//    CGFloat height = self.contentsRectHeightSlider.value;
//
//    self.monaLisaFrameLayer.contentsRect = CGRectMake(width,height,width,height);
        [self changeContentsRect];
}

- (IBAction)contentsRectHeightChanged:(UISlider *)sender
{
    [self changeContentsRect];
}

-(void)changeContentsRect
{
    CGFloat width = self.contentsRectWidthSlider.value;
    CGFloat height = self.contentsRectHeightSlider.value;
    
    self.monaLisaFrameLayer.contentsRect = CGRectMake(width,height,width,height);
    
    self.contentsRectWidthLabel.text = [NSString stringWithFormat:@"w=%1.1f",self.contentsRectWidthSlider.value];
    self.contentsRectHeightLabel.text = [NSString stringWithFormat:@"h=%1.1f",self.contentsRectHeightSlider.value];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
/*
 
 NSString * const kCAGravityCenter;
 NSString * const kCAGravityTop;
 NSString * const kCAGravityBottom;
 NSString * const kCAGravityLeft;
 NSString * const kCAGravityRight;
 NSString * const kCAGravityTopLeft;
 NSString * const kCAGravityTopRight;
 NSString * const kCAGravityBottomLeft;
 NSString * const kCAGravityBottomRight;
 NSString * const kCAGravityResize;
 NSString * const kCAGravityResizeAspect;
 NSString * const kCAGravityResizeAspectFill;
 
 
 */
- (IBAction)masksToBoundsChanged:(id)sender
{
    self.monaLisaFrameLayer.masksToBounds = !self.monaLisaFrameLayer.masksToBounds;
}

- (IBAction)contentsGravityChanged:(UISegmentedControl *)sender
{
    
    long selectedIndex = sender.selectedSegmentIndex;
    switch (selectedIndex) {
        case 0:
            self.monaLisaFrameLayer.contentsGravity = kCAGravityCenter;
            break;
        case 1:
            self.monaLisaFrameLayer.contentsGravity = kCAGravityTop;
            break;
        case 2:
            self.monaLisaFrameLayer.contentsGravity = kCAGravityBottom;
            break;
        case 3:
            self.monaLisaFrameLayer.contentsGravity = kCAGravityLeft;
            break;
        case 4:
            self.monaLisaFrameLayer.contentsGravity = kCAGravityRight;
            break;
        case 5:
            self.monaLisaFrameLayer.contentsGravity = kCAGravityTopLeft;
            break;
        case 6:
            self.monaLisaFrameLayer.contentsGravity = kCAGravityTopRight;
            break;
        case 7:
            self.monaLisaFrameLayer.contentsGravity = kCAGravityBottomLeft;
            break;
        case 8:
            self.monaLisaFrameLayer.contentsGravity = kCAGravityBottomRight;
            break;
        case 9:
            self.monaLisaFrameLayer.contentsGravity = kCAGravityResize;
            break;
        case 10:
            self.monaLisaFrameLayer.contentsGravity = kCAGravityResizeAspect;
            break;
        case 11:
            self.monaLisaFrameLayer.contentsGravity = kCAGravityResizeAspectFill;
            break;
        default:
            break;
    }
    self.contentsGravityValueLabel.text = [NSString stringWithFormat:@"contentsGravity = %@",self.monaLisaFrameLayer.contentsGravity]; //self.monaLisaLayer.contentsGravity;
    [self.view setNeedsDisplay];
}

#pragma mark init

- (CALayer *) createMonaLisaLayer
{
    UIImage *monaLisa = [UIImage imageNamed:@"396px-Mona_Lisa.png"];
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectIntegral(CGRectMake(0, 0, monaLisa.size.width - 50 , monaLisa.size.height - 50));
    layer.position =  CGPointMake( 200, 200);
    layer.anchorPoint = CGPointMake(0,0); // top left
    
    layer.backgroundColor = [UIColor colorWithRed:204/255.0 green:107/255.0 blue:191/255.0 alpha:0.4].CGColor;
    
//    CALayer *imageLayer = [CALayer new];
    
//    imageLayer.frame = CGRectMake(0, 0, monaLisa.size.width * 2, monaLisa.size.height * 2);
    layer.contents = (id)monaLisa.CGImage;
//    [layer addSublayer:imageLayer];
//    
//    self.monaLisaLayer = imageLayer;
    
    layer.opaque = YES;
    layer.borderColor = [UIColor redColor].CGColor;
    layer.cornerRadius = 12.0f;
    layer.borderWidth = 2.0;
    layer.masksToBounds = YES;
    
    return layer;
}

//- (CALayer *) createMonaLisaLayer
//{
//    UIImage *monaLisa = [UIImage imageNamed:@"396px-Mona_Lisa.png"];
//    
//    CALayer *layer = [CALayer layer];
//    layer.bounds = CGRectIntegral(CGRectMake(0, 0, monaLisa.size.width * 2, monaLisa.size.height * 2));
//    layer.position =  CGPointMake( 200, 100);
//    layer.anchorPoint = CGPointMake(0,0); // top left
//    
//    layer.backgroundColor = [UIColor colorWithRed:204/255.0 green:107/255.0 blue:191/255.0 alpha:0.4].CGColor;
//    
//    CALayer *imageLayer = [CALayer new];
//
//    imageLayer.frame = CGRectMake(0, 0, monaLisa.size.width * 2, monaLisa.size.height * 2);
//    imageLayer.contents = (id)monaLisa.CGImage;
//    [layer addSublayer:imageLayer];
//    
//    self.monaLisaLayer = imageLayer;
//    
//    layer.opaque = YES;
//    layer.borderColor = [UIColor redColor].CGColor;
//    layer.borderWidth = 2.0;
//    
//    return layer;
//}

#pragma mark view controller methods
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
    self.monaLisaFrameLayer = [self createMonaLisaLayer];
    [self.view.layer addSublayer: self.monaLisaFrameLayer];
    
    self.overlayLayer = [OverlayLayer new];
    [self.view.layer addSublayer:  self.overlayLayer];
    
    self.contentsGravityValueLabel.text = [NSString stringWithFormat:@"contentsGravity = %@",self.monaLisaFrameLayer.contentsGravity];
    
    [self changeContentsRect];
    
    [self.overlayLayer setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
