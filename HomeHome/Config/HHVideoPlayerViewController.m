//
//  HHVideoPlayerViewController.m
//  HomeHome
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "HHVideoPlayerViewController.h"
#import "SCPlayer.h"
#import "SCVideoPlayerView.h"
@interface HHVideoPlayerViewController ()
{
    /* 视频播放器 */
    SCPlayer *_player;
    
    UIView *_playerBackView;

}
@end

@implementation HHVideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"视频播放";
    [self initPlayer];

}


- (void)initPlayer
{
    _playerBackView = [[UIView alloc]initWithFrame:self.view.bounds];
    _playerBackView.backgroundColor = VTColor(241, 241, 241);
    //_playerBackView.alpha = 0.8;
    [self.view addSubview:_playerBackView];
    
    _player = [SCPlayer player];
    SCVideoPlayerView *playerView = [[SCVideoPlayerView alloc] initWithPlayer:_player];
    playerView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    CGFloat yy = (kScreenH - (kScreenW))/2;
    playerView.backgroundColor = VTColor(241, 241, 241);
    
    playerView.frame = CGRectMake(0, yy, kScreenW, kScreenW);
    playerView.backgroundColor = VTColor(241, 241, 241);
    
    playerView.autoresizingMask = self.view.autoresizingMask;
    [self.view addSubview:playerView];
    _player.loopEnabled = YES;
    
    
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:self.url];
    [_player setItem:item];
    [_player play];
    
//    NSString *path = [_url absoluteString];
//    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
//    
//    
//    UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    //void (^completion)(NSString *, NSError *) = self.videoCompletion;
    //self.videoCompletion = nil;
//    
//    if (completion != nil) {
//        completion(videoPath, error);
//    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    //[self _didEnd];
    
//    void (^completion)(NSError *) = self.imageCompletion;
//    self.imageCompletion = nil;
    
//    if (completion != nil) {
//        completion(error);
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
