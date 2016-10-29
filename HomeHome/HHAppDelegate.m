//
//  HHAppDelegate.m
//  HomeHome
//
//  Created by Victor on 16/1/5.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "HHAppDelegate+RootController.h"
#import "HHAppDelegate.h"
#import "HHAppDelegate+AppLifeCircle.h"
#import "HHAppDelegate+AppService.h"
#import "HHImageInfo.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "HHVideoPlayerViewController.h"
#import "SZLoginViewController.h"
#import "VTJpushTools.h"
@interface HHAppDelegate ()

@property (nonatomic,strong)NSMutableArray *imageArr;

@property (nonatomic,assign)NSInteger imageIndex;

@end
@implementation HHAppDelegate

+ (UINavigationController *)rootNavigationController
{
    HHAppDelegate *app = (HHAppDelegate *)[UIApplication sharedApplication].delegate;
    return (UINavigationController *)app.window.rootViewController;

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setAppWindows];
    [self setTabbarController];
    [self setRootViewController];
    
    [self configurationLaunchUserOption];
    
    [self registerBugly];
    
    [self registerMob];
    
    [self registerUmeng];
    
    [VTJpushTools setupWithOptions:launchOptions];
    
    [self upLoadMessageAboutUser];
    
    [self checkAppUpDataWithshowOption:NO];
    
    [SZNotificationCenter addObserver:self selector:@selector(phontoBroserPush:) name:kPushPhotoBrowserNotifitationName object:nil];
    [SZNotificationCenter addObserver:self selector:@selector(playCallBackVideo:) name:kPresentVideoPlayerNotifitationName object:nil];
    [self.window makeKeyAndVisible];
    

    return YES;
}

- (void)login
{
    SZLoginViewController *reg = [[SZLoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:reg];
    [self.window.rootViewController presentViewController:nav animated:YES completion:^{
        
    }];
}

- (void)playCallBackVideo:(NSNotification *)note
{
    [SZNotificationCenter postNotificationName:@"interrupteAudioPlay" object:nil];
    
    NSURL *url = note.object;
    NSLog(@"本地videoUrl = %@",url);
    HHVideoPlayerViewController *vide = [[HHVideoPlayerViewController alloc]init];
    vide.url = url;
    
    [[HHAppDelegate rootNavigationController]pushViewController:vide animated:YES];


    //    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=9.0)
    //    {
    //        AVPlayerViewController * avplayer =[[AVPlayerViewController alloc]init];
    //        avplayer.player = [[AVPlayer alloc] initWithURL:url];
    //        [self.window.rootViewController presentViewController:avplayer animated:YES completion:^{
    //        }];
    //        return;
    //
    //    }
    
    //    MPMoviePlayerViewController *moviePlayer = [ [ MPMoviePlayerViewController alloc]initWithContentURL:url];//本地的
    //    [self.window.rootViewController presentViewController:moviePlayer animated:YES completion:^{
    //    }];
}


- (void)phontoBroserPush:(NSNotification *)note
{
    self.imageArr = [NSMutableArray arrayWithCapacity:0];
    [self.imageArr removeAllObjects];
    
    NSDictionary *dic = note.object;
    NSArray *arr = dic[@"imageInfo"];
    NSInteger index = [dic[@"index"] integerValue];
    self.imageIndex = index;
    for(HHImageInfo *info in arr)
    {
        //[self.imageArr addObject:info.url];
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:info.url]];
        photo.caption = info.desc;
        [self.imageArr addObject:photo];
    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc]initWithDelegate:self];
    browser.zoomPhotosToFill = YES;
    
    browser.displayNavArrows = YES;
    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.autoPlayOnAppear = YES;
    [browser setCurrentPhotoIndex:index];
    [[HHAppDelegate rootNavigationController]pushViewController:browser animated:YES];
}


#pragma mark - ImageClick.delegate

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected
{
    
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return self.imageArr.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index<_imageArr.count)
    {
        return [_imageArr objectAtIndex:index];
    }
    return nil;
}

- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index
{
    return [NSString stringWithFormat:@"%lu of %lu",index+1,(unsigned long)_imageArr.count];
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index
{
    
}


- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser
{
    NSLog(@"退出查看");
}



- (void)setUpWindows
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    [MLTransition validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypePan];
    
    [self.window makeKeyAndVisible];
}

- (void)clearBadgeValue
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


@end
