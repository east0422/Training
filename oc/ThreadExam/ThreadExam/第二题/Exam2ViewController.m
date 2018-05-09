//
//  Exam2ViewController.m
//  ThreadExam
//
//  Created by dfang on 2018-5-9.
//  Copyright © 2018年 east. All rights reserved.
//

#import "Exam2ViewController.h"

@interface Exam2ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *mergeImageView;

@end

@implementation Exam2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)downClicked:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSURL *imageUrl = [NSURL URLWithString:@"https://www.baidu.com/img/bd_logo1.png"];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        UIImage *image = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView1.image = image;
            self.imageView1.layer.borderColor = [UIColor grayColor].CGColor;
            self.imageView1.layer.borderWidth = 1;
            NSLog(@"image1 down finished");
        });
    });
    dispatch_async(queue, ^{
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"male.png" ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView2.image = image;
            self.imageView2.layer.borderColor = [UIColor grayColor].CGColor;
            self.imageView2.layer.borderWidth = 1;
             NSLog(@"image2 down finished");
        });
    });
}

- (IBAction)mergeClicked:(UIButton *)sender {
    CGSize drawSize = self.mergeImageView.frame.size;
    UIGraphicsBeginImageContext(drawSize);
    
    CGRect image1Rect = CGRectMake(0, 0, drawSize.width/2, drawSize.height);
    [self.imageView1.image drawInRect:image1Rect blendMode:kCGBlendModeNormal alpha:1];
    CGRect image2Rect = CGRectMake(drawSize.width/2, 0, drawSize.width/2, drawSize.height);
    [self.imageView2.image drawInRect:image2Rect blendMode:kCGBlendModeNormal alpha:1];
    
    UIImage *mergeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.mergeImageView.image = mergeImage;
    self.mergeImageView.layer.borderColor = [UIColor grayColor].CGColor;
    self.mergeImageView.layer.borderWidth = 1;
    
    [self saveImage:mergeImage andImageName:@"temp.png"];
}

- (void)saveImage:(UIImage *)image andImageName:(NSString *)imageName {
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *imagePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    NSLog(@"%@",imagePath);
    [imageData writeToFile:imagePath atomically:true];
}

@end
