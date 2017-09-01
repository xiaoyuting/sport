//
//  RequestManager.h
//  网络请求
//
//  Created by 雨停 on 2017/4/19.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RequestManagerShear  [RequestManager shareRequestManager]

#define NetWeak          __weak __typeof(self) weakSelf = self 

/*过期属性或方法名提醒*/
#define BANetManagerDeprecated(instead) __deprecated_msg(instead)
/* 判断是否有网*/
#ifndef ifHaveNetWork
#define ifHaveNetWork   [RequestManager t_ifHaveNetwork]
#endif
/*判断是否为手机网络*/
#ifndef if3GOr4GNetwork
#define if3GOr4GNetWork  [RequestManager t_if3GOr4GNetwork]
#endif
/*判断是否为WIFI网络 */
#ifndef ifWifiNetWork 
#define ifWifiNetWork [RequestManager t_ifWiFiNetwork]
#endif
 
/*! 使用枚举NS_ENUM:区别可判断编译器是否支持新式枚举,支持就使用新的,否则使用旧的 */
typedef NS_ENUM(NSInteger,NetWorkStatus) {
    /*! 未知网络 */
    NetworkStatusUnknown           = 0,
    /*! 没有网络 */
    NetworkStatusNotReachable,
    /*! 手机 3G/4G 网络 */
    NetworkStatusReachableViaWWAN,
    /*! wifi 网络 */
    NetworkStatusReachableViaWiFi
};
/*！定义请求类型的枚举 */
typedef NS_ENUM(NSUInteger, HttpRequestType)
{
    /*! get请求 */
    HttpRequestTypeGet = 0,
    /*! post请求 */
    HttpRequestTypePost,
    /*! put请求 */
    HttpRequestTypePut,
    /*! delete请求 */
    HttpRequestTypeDelete
};


/*! 实时监测网络状态的 block */
typedef void(^NetworkStatusBlock)(NetWorkStatus status);

/*! 定义请求成功的 block */
typedef void( ^ ResponseSuccess)(id response);
/*! 定义请求失败的 block */
typedef void( ^ ResponseFail)(NSError *error);

/*! 定义上传进度 block */
typedef void( ^ UploadProgress)(int64_t bytesProgress,
int64_t totalBytesProgress);
/*! 定义下载进度 block */
typedef void( ^ DownloadProgress)(int64_t bytesProgress,
int64_t totalBytesProgress);

/*!
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask URLSessionTask;

@interface RequestManager : NSObject
/*! 获取当前网络状态 */
@property (nonatomic, assign) NetWorkStatus netWorkStatu;

/*!
 *  获得全局唯一的网络请求实例单例方法
 *
 *  @return 网络请求类BANetManager单例
 */
+ (RequestManager *)shareRequestManager;

#pragma mark - 网络请求的类方法 --- get / post / put / delete
/*!
 *  网络请求方法,block回调
 *
 *  @param type         get / post
 *  @param urlString    请求的地址
 *  @param parameters    请求的参数
 *  @param successBlock 请求成功的回调
 *  @param failureBlock 请求失败的回调
 *  @param progress 进度
 */
+ (URLSessionTask *)requestWithType:(HttpRequestType)type
                               urlString:(NSString *)urlString
                              parameters:(NSDictionary *)parameters
                            successBlock:(ResponseSuccess)successBlock
                            failureBlock:(ResponseFail)failureBlock
                                progress:(DownloadProgress)progress;

/*!
 *  上传图片(多图)
 *
 *  @param parameters   上传图片预留参数---视具体情况而定 可移除
 *  @param imageArray   上传的图片数组
 *  @param fileName     上传的图片数组fileName
 *  @param urlString    上传的url
 *  @param successBlock 上传成功的回调
 *  @param failureBlock 上传失败的回调
 *  @param progress     上传进度
 */
+ (URLSessionTask *)uploadImageWithUrlString:(NSString *)urlString
                                       parameters:(NSDictionary *)parameters
                                       imageArray:(NSArray *)imageArray
                                         fileName:(NSString *)fileName
                                     successBlock:(ResponseSuccess)successBlock
                                      failurBlock:(ResponseFail)failureBlock
                                   upLoadProgress:(UploadProgress)progress;

/*!
 *  视频上传
 *
 *  @param parameters   上传视频预留参数---视具体情况而定 可移除
 *  @param videoPath    上传视频的本地沙河路径
 *  @param urlString     上传的url
 *  @param successBlock 成功的回调
 *  @param failureBlock 失败的回调
 *  @param progress     上传的进度
 */
+ (void)uploadVideoWithUrlString:(NSString *)urlString
                         parameters:(NSDictionary *)parameters
                          videoPath:(NSString *)videoPath
                       successBlock:(ResponseSuccess)successBlock
                       failureBlock:(ResponseFail)failureBlock
                     uploadProgress:(UploadProgress)progress;

/*!
 *  文件下载
 *
 *  @param parameters   文件下载预留参数---视具体情况而定 可移除
 *  @param savePath     下载文件保存路径
 *  @param urlString        请求的url
 *  @param successBlock 下载文件成功的回调
 *  @param failureBlock 下载文件失败的回调
 *  @param progress     下载文件的进度显示
 */
+ (URLSessionTask *)downLoadFileWithUrlString:(NSString *)urlString
                                        parameters:(NSDictionary *)parameters
                                          savaPath:(NSString *)savePath
                                      successBlock:(ResponseSuccess)successBlock
                                      failureBlock:(ResponseFail)failureBlock
                                  downLoadProgress:(DownloadProgress)progress;

/*              pragma mark - 网络状态监测        */
/*!
 *  开启实时网络状态监测，通过Block回调实时获取(此方法可多次调用)
 */
+ (void)startNetWorkMonitoringWithBlock:(NetworkStatusBlock)networkStatus;

/*!
 *  是否有网
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)t_ifHaveNetwork;

/*!
 *  是否是手机网络
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)t_if3GOr4GNetwork;

/*!
 *  是否是 WiFi 网络
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)t_ifWiFiNetwork;

#pragma mark - 取消 Http 请求
/*!
 *  取消所有 Http 请求
 */
+ (void)cancelAllRequest;

/*!
 *  取消指定 URL 的 Http 请求
 */
+ (void)cancelRequestWithURL:(NSString *)URL;


#pragma mark - 各版本过期方法名
#pragma mark version 2.0 过期方法名
/*+ (URLSessionTask *)requestWithType:(HttpRequestType)type
                               UrlString:(NSString *)urlString
                              Parameters:(NSDictionary *)parameters
                            SuccessBlock:(ResponseSuccess)successBlock
                            FailureBlock:(ResponseFail)failureBlock
                                progress:(DownloadProgress)progress BANetManagerDeprecated("该方法已过期,请使用最新方法：+ (BAURLSessionTask *)ba_requestWithType:(BAHttpRequestType)type urlString:(NSString *)urlString parameters:(NSDictionary *)parameters successBlock:(BAResponseSuccess)successBlock failureBlock:(BAResponseFail)failureBlock progress:(BADownloadProgress)progress");

+ (URLSessionTask *)uploadImageWithUrlString:(NSString *)urlString
                                       parameters:(NSDictionary *)parameters
                                       ImageArray:(NSArray *)imageArray
                                         FileName:(NSString *)fileName
                                     SuccessBlock:(ResponseSuccess)successBlock
                                      FailurBlock:(ResponseFail)failureBlock
                                   UpLoadProgress:(UploadProgress)progress BANetManagerDeprecated("该方法已过期,请使用最新方法：+ (BAURLSessionTask *)ba_uploadImageWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters imageArray:(NSArray *)imageArray fileName:(NSString *)fileName successBlock:(BAResponseSuccess)successBlock failurBlock:(BAResponseFail)failureBlock upLoadProgress:(BAUploadProgress)progress");

+ (void)uploadVideoWithUrlString:(NSString *)urlString
                         parameters:(NSDictionary *)parameters
                          VideoPath:(NSString *)videoPath
                       SuccessBlock:(ResponseSuccess)successBlock
                       FailureBlock:(ResponseFail)failureBlock
                     UploadProgress:(UploadProgress)progress BANetManagerDeprecated("该方法已过期,请使用最新方法：+ (void)ba_uploadVideoWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters videoPath:(NSString *)videoPath successBlock:(BAResponseSuccess)successBlock failureBlock:(BAResponseFail)failureBlock uploadProgress:(BAUploadProgress)progress");

+ (URLSessionTask *)downLoadFileWithUrlString:(NSString *)urlString
                                        parameters:(NSDictionary *)parameters
                                          SavaPath:(NSString *)savePath
                                      SuccessBlock:(ResponseSuccess)successBlock
                                      FailureBlock:(ResponseFail)failureBlock
                                  DownLoadProgress:(DownloadProgress)progress BANetManagerDeprecated("该方法已过期,请使用最新方法：+ (BAURLSessionTask *)ba_downLoadFileWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters savaPath:(NSString *)savePath successBlock:(BAResponseSuccess)successBlock failureBlock:(BAResponseFail)failureBlock downLoadProgress:(BADownloadProgress)progress");

*/
@end
