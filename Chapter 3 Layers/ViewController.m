//
//  ViewController.m
//  Chapter 3 Layers
//
//  Created by Daniel Wallace [DATACOM] on 6/05/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *drawingView;

@property (strong,nonatomic) UIImageView *smiley;
@property (strong, nonatomic) CALayer *lay11;


// Manipulating the layer heirarchy
@property (weak, nonatomic) UIView *layerHierarchyContainer;

@property (strong, nonatomic) CALayer *layer0;
@property (strong, nonatomic) CALayer *layer1;
@property (strong, nonatomic) CALayer *layer2;

@property (strong, nonatomic) CALayer *layerToInsertAndRemove;
@property (strong, nonatomic) CALayer *layerToInsertAndRemoveAtIndexZero;
@property (strong, nonatomic) CALayer *layerToInsertAndRemoveAtIndexOne;
@property (strong, nonatomic) CALayer *layerToInsertAndRemoveAtIndexTwo;
@property (strong, nonatomic) CALayer *layerToInsertAndRemoveAtIndexThree;
@property (strong, nonatomic) CALayer *layerToInsertBelow;
@property (strong, nonatomic) CALayer *layerToInsertAbove;

@property (weak, nonatomic) IBOutlet UISegmentedControl *insertBelowSublayer;
@property (weak, nonatomic) IBOutlet UISegmentedControl *insertAboveSublayer;

@end

@implementation ViewController

- (IBAction)zPositionChanged:(UISegmentedControl *)sender {
    
    self.smiley.layer.zPosition = sender.selectedSegmentIndex;
}


- (IBAction)replaceSublayerWithRandomColoredLayer:(UISegmentedControl *)sender {
    
    NSInteger layerIndexToReplace = sender.selectedSegmentIndex;
    
    CALayer *layerToReplace = self.layerHierarchyContainer.layer.sublayers[layerIndexToReplace];
    
    CALayer *replacementLayer = [self makeLayerOfSize: layerToReplace.frame.size.height atPosition: layerToReplace.frame.origin.x withColor:[self randomColor]];
    
    [self.layerHierarchyContainer.layer replaceSublayer: layerToReplace with:replacementLayer];
    
    switch (layerIndexToReplace)
    {
        case 0:
            self.layer0 = replacementLayer;
            break;
        case 1:
            self.layer1 = replacementLayer;
            break;
        case 2:
            self.layer2 = replacementLayer;
            break;
        default:
            NSLog(@"ERROR - no layer to replace.");
            break;
    }
}

- (IBAction)insertLayerAbove:(UISwitch *)sender {
    
    if(sender.on){
        self.layerToInsertAbove = [self makeLayerOfSize: 120.0 atPosition: 20.0 withColor:[UIColor greenColor]];
        NSInteger layerIndex = self.insertAboveSublayer.selectedSegmentIndex;
        [self.layerHierarchyContainer.layer insertSublayer: self.layerToInsertAbove
                                                     above: self.layerHierarchyContainer.layer.sublayers[layerIndex]];
    }else{
        [self.layerToInsertAbove removeFromSuperlayer];
    }
}

- (IBAction)insertLayerBelow:(UISwitch *)sender {
 
    if(sender.on){
        self.layerToInsertBelow = [self makeLayerOfSize: 120.0 atPosition: 0.0 withColor:[UIColor redColor]];
        NSInteger layerIndex = self.insertBelowSublayer.selectedSegmentIndex;
        [self.layerHierarchyContainer.layer insertSublayer: self.layerToInsertBelow
                                                     below: self.layerHierarchyContainer.layer.sublayers[layerIndex]];
    }else{
        [self.layerToInsertBelow removeFromSuperlayer];
    }
}

- (IBAction)insertLayerAtIndex0:(UISwitch *)sender
{
    if(sender.on){
        self.layerToInsertAndRemoveAtIndexZero = [self makeLayerOfSize: 120.0 atPosition: 0.0 withColor:[UIColor purpleColor]];
        [self.layerHierarchyContainer.layer insertSublayer: self.layerToInsertAndRemoveAtIndexZero atIndex: 0];
    }else{
        [self.layerToInsertAndRemoveAtIndexZero removeFromSuperlayer];
    }
}

- (IBAction)insertLayerAtIndex1:(UISwitch *)sender
{
    if(sender.on){
        self.self.layerToInsertAndRemoveAtIndexOne = [self makeLayerOfSize: 120.0 atPosition:20.0 withColor:[UIColor greenColor]];
        [self.layerHierarchyContainer.layer insertSublayer: self.layerToInsertAndRemoveAtIndexOne atIndex: 1];
    }else{
        [self.layerToInsertAndRemoveAtIndexOne removeFromSuperlayer];
    }
}

- (IBAction)insertLayerAtIndex2:(UISwitch *)sender
{
    if(sender.on){
        self.layerToInsertAndRemoveAtIndexTwo = [self makeLayerOfSize: 120.0 atPosition:40.0 withColor:[UIColor magentaColor]];
        [self.layerHierarchyContainer.layer insertSublayer: self.layerToInsertAndRemoveAtIndexTwo atIndex: 2];
    }else{
        [self.layerToInsertAndRemoveAtIndexTwo removeFromSuperlayer];
    }
}

- (IBAction)insertLayerAtIndex3:(UISwitch *)sender
{
    if(sender.on){
        self.layerToInsertAndRemoveAtIndexThree = [self makeLayerOfSize: 120.0 atPosition:60.0 withColor:[UIColor lightGrayColor]];
        [self.layerHierarchyContainer.layer insertSublayer: self.layerToInsertAndRemoveAtIndexThree atIndex: 3];
    }else{
        [self.layerToInsertAndRemoveAtIndexThree removeFromSuperlayer];
    }
}



- (IBAction)addRemoveSublayer:(UISwitch *)sender
{
    if(sender.on){
        if (!self.layerToInsertAndRemove){
            self.layerToInsertAndRemove = [self makeLayerToInsertAndRemove];
        }
        self.layerToInsertAndRemove = [self makeLayerToInsertAndRemove];
        [self.layer2 addSublayer: self.layerToInsertAndRemove];
    }else{
        [self.layerToInsertAndRemove removeFromSuperlayer];
    }
}

- (IBAction)maskToBoundsChanged:(UISwitch *)sender
{
    self.lay11.masksToBounds = !self.lay11.masksToBounds;
}

- (IBAction)hiddenChanged:(UISwitch *)sender {
    self.lay11.hidden = !self.lay11.hidden;
}



#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self drawThreeLayers];
    [self drawTwoLayersAndAView];
    [self drawThreeLayersToManipulateTheLayerHierarchy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark drawing

-(void) drawThreeLayersToManipulateTheLayerHierarchy
{
    UIView *layerHierarchyContainer = [[UIView alloc]initWithFrame:CGRectMake(43,420,300,300)];
    layerHierarchyContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:layerHierarchyContainer];
    
    self.layer0 = [CALayer new];
    self.layer0.frame = CGRectMake(10, 10, 100, 100);
    self.layer0.backgroundColor = [[UIColor blueColor] CGColor];
    [layerHierarchyContainer.layer addSublayer: self.layer0];
    
    self.layer1 = [CALayer new];
    self.layer1.frame = CGRectMake(50, 50, 100, 100);
    self.layer1.backgroundColor = [[UIColor orangeColor] CGColor];
    [layerHierarchyContainer.layer addSublayer: self.layer1];
    
    self.layer2 = [CALayer new];
    self.layer2.frame = CGRectMake(100, 100,100, 100);
    self.layer2.backgroundColor = [[UIColor yellowColor] CGColor];
    [layerHierarchyContainer.layer addSublayer: self.layer2];
    
    self.layerHierarchyContainer = layerHierarchyContainer;
}

-(void) drawTwoLayersAndAView
{
    self.lay11 = [CALayer new];
    self.lay11.frame = CGRectMake(413, 11, 132, 194);
    self.lay11.backgroundColor = [[UIColor colorWithRed: 1 green: .4 blue: 1 alpha: 1] CGColor];
    [self.drawingView.layer addSublayer:self.lay11];
    
    CALayer *lay21 = [CALayer new];
    lay21.frame = CGRectMake(41, 56, 132, 194);
    lay21.backgroundColor = [[UIColor colorWithRed: .5 green: 1 blue: 0 alpha: 1] CGColor];
    [self.lay11 addSublayer: lay21];
    
    UIImageView* smiley =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smileyiPhone"]];
    CGRect r = smiley.frame;
    r.origin = CGPointMake(460,76);
    smiley.frame = r;
    [self.drawingView addSubview:smiley];
    self.smiley = smiley; // for zPosition changes later.
    
    
    CALayer *lay31 = [CALayer new];
    lay31.frame = CGRectMake(343, 97, 160, 230);
    lay31.backgroundColor = [[UIColor colorWithRed: 1 green: 0 blue: 0 alpha: 1] CGColor];
    [self.drawingView.layer addSublayer:lay31];
}

-(void) drawThreeLayers
{
    CALayer *lay1 = [CALayer new];
    lay1.frame = CGRectMake(113, 11, 132, 194);
    lay1.backgroundColor = [[UIColor colorWithRed: 1 green: .4 blue: 1 alpha: 1] CGColor];
    [self.drawingView.layer addSublayer:lay1];
    
    CALayer *lay2 = [CALayer new];
    lay2.frame = CGRectMake(41, 56, 132, 194);
    lay2.backgroundColor = [[UIColor colorWithRed: .5 green: 1 blue: 0 alpha: 1] CGColor];
    [lay1 addSublayer:lay2];
    
    CALayer *lay3 = [CALayer new];
    lay3.frame = CGRectMake(43, 97, 160, 230);
    lay3.backgroundColor = [[UIColor colorWithRed: 1 green: 0 blue: 0 alpha: 1] CGColor];
    [self.drawingView.layer addSublayer:lay3];
}

#pragma mark utilities

-(CALayer *)makeLayerToInsertAndRemove
{
    CALayer *layerToInsertAndRemove = [CALayer new];
    layerToInsertAndRemove.backgroundColor = [[UIColor colorWithWhite:0 alpha:1] CGColor];
    layerToInsertAndRemove.frame = CGRectMake(40, 40, 120, 120);
    return layerToInsertAndRemove;
}

-(CALayer *)makeLayerOfSize:(CGFloat) size atPosition:(CGFloat) origin withColor: (UIColor *)color
{
    CALayer *layer = [CALayer new];
    layer.backgroundColor = [[color colorWithAlphaComponent:0.8] CGColor];
    layer.frame = CGRectMake(origin, origin, size, size);
    return layer;
}

-(UIColor *)randomColor
{
    CGFloat red = arc4random() % 256 / 255.0;
    CGFloat green = arc4random() % 256 / 255.0;
    CGFloat blue = arc4random() % 256 / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return color;
}

@end
