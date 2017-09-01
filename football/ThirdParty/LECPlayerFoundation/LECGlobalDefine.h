//
//  LECGlobalDefine.h
//  LECPlayerSDK
//
//  Created by 侯迪 on 9/13/15.
//  Copyright (c) 2015 letv. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(int, LECPlayerMediaType) {
    LECPlayerMediaTypeRTMP,
    LECPlayerMediaTypeHLS,
    LECPlayerMediaTypeFLV
};



typedef NS_ENUM(NSInteger, LECBusinessLine){
    LECBusinessLineCloud = 0,//默认云直播点播服务
    LECBusinessLineSaas = 1//Saas服务
};


typedef NS_ENUM(NSInteger, LECActivityStatus) {
    LECActivityStatusUnknown = -1,
    LECActivityStatusUnStarted = 0,//未开始
    LECActivityStatusLiving = 1,//正在直播
    LECActivityStatusSuspending = 2,//中断
    LECActivityStatusEnd = 3//结束
};
/**
 *  直播用，点播不用
 */
typedef NS_ENUM(NSInteger, LECWaterMarkPosition) {
    LECWaterMarkPositionNone = 0,
    LECWaterMarkPositionLeftTop = 1,
    LECWaterMarkPositionRightTop = 2,
    LECWaterMarkPositionLeftBottom = 3,
    LECWaterMarkPositionRightBottom = 4
};
