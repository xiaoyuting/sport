//
//  LECPlayer.h
//  LECPlayerSDK
//
//  Created by 侯迪 on 9/13/15.
//  Copyright (c) 2015 letv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LECStreamRateItem.h"
#import "LECPlayerOption.h"


@class LECPlayer;

typedef NSInteger LECPlayerPlayOperation;

static LECPlayerPlayOperation LECPlayerPlayOperationRegister = 0;
static LECPlayerPlayOperation LECPlayerPlayOperationUnregister = 1;
static LECPlayerPlayOperation LECPlayerPlayOperationPrepare = 2;
static LECPlayerPlayOperation LECPlayerPlayOperationPlay = 3;
static LECPlayerPlayOperation LECPlayerPlayOperationPause = 4;
static LECPlayerPlayOperation LECPlayerPlayOperationResume = 5;
static LECPlayerPlayOperation LECPlayerPlayOperationStop = 6;
static LECPlayerPlayOperation LECPlayerPlayOperationSeek = 7;
static LECPlayerPlayOperation LECPlayerPlayOperationSwitch = 8;

//播放器事件执行队列状态
typedef NS_ENUM(int, LCProcStatus){
    LCProcStatusUnstart = 0,
    LCProcStatusTodo = 1,
    LCProcStatusInProgressing = 2,
    LCProcStatusFinished = 3
};

typedef NS_ENUM(int, LECPanoramaGyroOrientation) {
    LECPanoramaGyroOrientationNone,                 //关闭全景陀螺仪
    LECPanoramaGyroOrientationPortrait,
    LECPanoramaGyroOrientationPortraitUpsideDown,
    LECPanoramaGyroOrientationLandscapeLeft,
    LECPanoramaGyroOrientationLandscapeRight
};

//enum播放状态
typedef NS_ENUM(int, LECPlayerPlayEvent) {
    LECPlayerPlayEventPrepareDone = 0,//准备结束
    LECPlayerPlayEventEOS = 1,//播放结束
    LECPlayerPlayEventGetVideoSize,//视频源Size
    LECPlayerPlayEventRenderFirstPic,//获取到第一帧
    LECPlayerPlayEventBufferStart,//开始缓冲
    LECPlayerPlayEventBufferEnd,//缓冲结束
    LECPlayerPlayEventSeekComplete,//seek结束
    LECPlayerPlayEventPlayError = 100,//播放出错
    LECPlayerPlayEventDisplayError,
    LECPlayerPlayEventSuspend,//直播结束
    LECPlayerPlayEventNotStarted//直播未开始
};

typedef NS_ENUM(int, LECPlayerPlayStatus) {
    LECPlayerPlayStatusUnInit = 0,//未初始化
    LECPlayerPlayStatusInit = 1,//初始化
    LECPlayerPlayStatusPrepared = 2,//准备播放
    LECPlayerPlayStatusPlaying = 3,//播放中
    LECPlayerPlayStatusPaused = 4,//暂停
    LECPlayerPlayStatusStoped = 5,//停止
    LECPlayerPlayStatusEOS = 6,//结束
    LECPlayerPlayStatusError = 7//出错
};

typedef NS_ENUM(int, LECPlayerContentType) {
    LECPlayerContentTypeUnknow = 0,     //未初始化等
    LECPlayerContentTypeAdv = 1,        //广告
    LECPlayerContentTypeFeature = 2     //正片
};

typedef NS_ENUM(int, LECPlayerCodecCoreType) {
    LECPlayerCodecCoreTypeUndefine = 0,
    LECPlayerCodecCoreTypeCustomPlayer = 1,
    LECPlayerCodecCoreTypeAVPlayer = 2
};

typedef NS_ENUM(int, LECPanoramaType) {
    LECPanoramaTypeUndefine = 0, // 默认
    LECPanoramaTypeNormalRect = 1, // 普通视频
    LECPanoramaTypePanorama = 2, // 单目
    LECPanoramaTypeVR = 3 // 双目
};

@protocol LECPlayerDelegate <NSObject>

@optional

/*内容类型变换回调*/
- (void) lecPlayer:(LECPlayer *) player contentTypeChanged:(LECPlayerContentType) contentType;

/*播放器播放状态*/
- (void) lecPlayer:(LECPlayer *) player
       playerEvent:(LECPlayerPlayEvent) playerEvent;

/*播放器播放时间回调*/
- (void) lecPlayer:(LECPlayer *) player
          position:(int64_t) position
     cacheDuration:(int64_t) cacheDuration
          duration:(int64_t) duration;


/**
 返回试看信息
 @param player 播放器
 @param buy 是否是试看  YES：试看  NO：非试看
 @param tryLookTime 试看时长
 */
- (void)lecPlayer:(LECPlayer *)player needbuy:(BOOL)buy tryLookTime:(int)tryLookTime;

@end

@protocol LECPlayerRecordDelegate <NSObject>

- (void)lecPlayerRecordFinished:(LECPlayer *) player;           //异常打断时会返回

@end

@protocol LECPlayerDatasource <NSObject>

@optional
- (BOOL) needDisableIdleTimeWhenFinishPlayerWithPlayer:(LECPlayer *) player;

@end

@interface LECPlayer : NSObject

/* 播放前需要先调用该方法注册播放器 */
- (BOOL) registerWithURLString:(NSString *) urlString completion:(void (^)(BOOL result))completion;
/* 异步方法需要等待block回调后才能进行其他操作 销毁播放器前，或重新注册前需要调用该方法*/
- (BOOL) unregister;
//在play前可先调用此方法开始缓冲，减少play时的起播时间；也可以直接play方法开始播放//async
- (BOOL) prepare;
//开始播放接口
- (BOOL) play;
//暂停播放接口
- (BOOL) pause;
//恢复播放接口
- (BOOL) resume;
//停止播放接口
- (BOOL) stop;
//seek到视频相应位置
- (BOOL) seekToPosition:(NSInteger) position;
//切换码率接口
- (BOOL) switchSelectStreamRateItem:(LECStreamRateItem *) selectStreamRateItem;
//检测某操作是否可以进行
- (BOOL) canDoOperation:(LECPlayerPlayOperation) playOperation;
//completionblock代表操作结束，可继续别的操作；该返回并不代表操作结果成功，播放状态需要根据回调决定
- (BOOL) prepareWithCompletion:(void (^)(BOOL))completion;
//async
- (BOOL) playWithCompletion:(void (^)())completion;
//async
- (BOOL) seekToPosition:(NSInteger) position completion:(void (^)())completion;
//async
- (BOOL) switchSelectStreamRateItem:(LECStreamRateItem *) selectStreamRateItem completion:(void (^)())completion;
//async: stop为异步方法，如果stop后需要立即进行其他播放操作，可新建player示例
- (BOOL) stopWithCompletion:(void (^)())completion;

- (BOOL) startRecordWithURL:(NSURL *) storageUrl;       //目前仅在基类支持，且仅支持rtmp
- (void) stopRecord;

- (BOOL) skipAd;
- (void) setADWithCustomUI:(BOOL)customUI;

/**
 截屏
 @param callback callback(返回截取到的图片)
 */
- (void)snapShotWithCallback:(void(^)(UIImage *image))callback;

@property (nonatomic, readonly) UIView *videoView;//承载视频的view，可通过contentMode设置视频拉抻方式
@property (nonatomic, assign) float volume;//播放器音量
@property (nonatomic, readonly) float actualVideoWidth;//在收到LECPlayerPlayEventGetVideoSize回调后，该值表示视频实际宽度
@property (nonatomic, readonly) float actualVideoHeight;//在收到LECPlayerPlayEventGetVideoSize回调后，该值表示视频实际高度
@property (nonatomic, readonly) NSArray *streamRatesList;//NSArray中item类型为LCStreamRateItem;在注册成功后，该值有效；注意在设置选中item时，要判断isEnabled属性
@property (nonatomic, readonly) LECStreamRateItem *selectedStreamRateItem;//该变量标示当前使用码率，该变量只读，需要切换码率请调用switchSelectStreamRateItem方法实现
@property (nonatomic, readonly) NSString *errorCode;//当播放失败时，可通过该属性获得错误码
@property (nonatomic, readonly) __block NSString *errorDescription;//当播放失败时，可通过该属性获得错误描述

@property (nonatomic, readonly) NSString *readableErrorDescription;
@property (nonatomic, weak) id<LECPlayerDelegate> delegate;
@property (nonatomic, weak) id<LECPlayerRecordDelegate> recordDelegate;
@property (nonatomic, weak) id<LECPlayerDatasource> datasource;
@property (nonatomic, readonly) int64_t position;//播放器当前播放时长
@property (nonatomic, readonly) int64_t duration;//视频总时长，对于直播来说是0
@property (nonatomic, readonly) LECPlayerPlayStatus playStatus;//播放器状态
@property (nonatomic, readonly) LECPlayerContentType contentType;//播放器内容类型，目前只有广告和正片两种类型
@property (nonatomic, readonly) BOOL isPanorama;
@property (nonatomic, assign) LECPanoramaType panoramaType;// 视频类别
@property (nonatomic, assign) LECPanoramaGyroOrientation panoramaGyroOrientation;     //设备方向，影响全景视频陀螺仪
@property (nonatomic, assign) float startPlayCacheDuration;     //起播缓冲duration，prepare前设置有效，0将采用默认值
@property (nonatomic, assign) float startBufferCacheDuration;   //开始缓冲duration，prepare前设置有效，0将采用默认值
@property (nonatomic, assign) float endBufferCacheDuration;     //结束缓冲duration，prepare前设置有效，0将采用默认值
@property (nonatomic, assign) float maxDelayDuration;           //直播时有效，大于该值的缓冲区数据会被丢弃，prepare前设置有效，0将采用默认值
@property (nonatomic, assign) float maxCacheDuration;           //最大缓冲区duration，prepare前设置有效，0将采用默认值
@property (nonatomic, assign) BOOL isRstpPreferTcp;             //是否使用tcp方式连接rtsp，prepare前设置有效
@property (nonatomic, assign) LECPlayerCodecCoreType codecCoreType;     //播放内核type，如果在注册前未指定(undefine)，则在注册完毕后自动选择；prepare前设置有效
@property (nonatomic, assign) BOOL ifADFinished;//广告是否已经播放完
@property (nonatomic, assign) BOOL autoPlayAfterInterrupt;
@property (nonatomic, readonly) NSInteger speed;                //单位Byte/s

@end
