//
//  WGEnum.h
//  factory
//
//  Created by Qing Chen on 2018/4/8.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kGenderMale = 1
    , kGenderFemale = 2
}KLGender;

typedef NS_ENUM(NSInteger, TCommonLoginType){//公共账号类型
    TLoginByPhone                       = 0,
    TCommonLoginByWeibo                 = 1,
    TCommonLoginByQQ                    = 2,
    TCommonLoginByWeixin                = 3,
};

typedef NS_ENUM(NSInteger, ZZShareType){//分享类型
    ZZShareWeixin                       = 0,
    ZZShareWeixinQuest                  = 1,
    ZZShareWeibo                        = 2,
    ZZShareQQ                           = 3,
    ZZShareQQZone                       = 4,
    ZZShareLink                         = 5,
};

//上传文件的类型
typedef NS_ENUM(NSInteger, KLUploadFileType){
    KLUpload_File_Image       = 1,
    KLUpload_File_Voice,
    KLUpload_File_Video
};

//上传图片的用途
typedef NS_ENUM(NSInteger, TUploadImageUse){
    TUploadImageUseForAvatar       = 1,
    TUploadImageUseForAlbum        = 2,
    TUploadImageUseForVideo        = 3,
};
//支付类型
typedef NS_ENUM(NSInteger, XMPayType){//公共账号类型
    XMPayTypeWeixin                           = 1,//微信支付
    XMPayTypeAlipay                           = 2,//支付宝支付
};

//错误类型
typedef NS_ENUM (NSInteger, TErrorCode) {
    
    //-----系统错误 0-10
    ERR_NO_ERROR = 0,
    ERR_INVALID_PARAMETER = 1,
    ERR_SERVER_EXCEPTION = 2,
    ERR_USER_NOT_LOGIN = 3,
    ERR_USER_OTHER_LOGIN = 4,
    ERR_NOT_NEED_INTERCEPTOR = 5,
    ERR_BIND_GETUI_FAILED = 6,
    ERR_USER_KEY_NULL = 7,
    ERR_USER_UID_NULL = 8,
    ERR_USER_IN_SYSTEM_BLACKLIST = 9,
    ERR_USER_DISABLED = 10,//账号被禁
    
    //---------用户相关错误信息 51－100
    ERR_REG_NICKNAME_EXIST = 51,//注册昵称已存在
    ERR_REG_PHONE_EXIST = 75,//注册手机号码已存在
    ERR_REG_COMMON_ACCOUNT_EXIST = 53,//公共账号已被其他人绑定
    ERR_LOGIN_PHONE_NOT_EXIST = 54,//登录手机不存在
    ERR_LOGIN_WRONG_PASSWORD = 72,//密码不正确
    ERR_LOGIN_COMMON_ACCOUNT_NOT_REG = 71,//公共账号还没有注册
    ERR_LOGIN_USER_NOT_EXIST = 57,//相关用户不存在
    ERR_BIND_PHONE_EXIST = 58,//手机已被其他账号绑定
    ERR_BIND_COMMON_ACCOUNT_EXIST = 59,//公共账号已被其他账号绑定
    ERR_CAPTCHA_NOT_MATCH = 60,//验证码不匹配
    ERR_NICKNAME_CONTAIN_SPECIAL_CHAR = 61,//昵称包含特殊字符
    ERR_PHONE_INVALID = 62,//手机号码格式不对
    ERR_KEYWORD_INPUT_INVALID = 63,//关键字包含特殊字符
    ERR_REPORT_USER = 64,//举报用户失败
    ERR_REG_FAILED = 65,//注册失败
    ERR_CANNOT_GET_CAPTCHA = 66, //无法短时间内获取验证码
    ERR_GET_CAPTCHA_PER_DAY_LIMIT = 67, //每天同一手机号获取验证码的数量
    ERR_SEND_CAPTCHA = 68, //发送验证码失败
    ERR_HALF_HOUR_CAPTCHA_LIMIT = 69, //半小时内提交发送次数过多
    ERR_CAPTCHA_BLACK_IP = 70, //此ip已加入获取验证码的黑名单
    
    // ---------------上传文件相关错误信息 101-200
    ERR_FILE_EMPTY = 101,// 上传的文件为空
    ERR_UPLOAD_FAILED = 102,// 文件上传失败
    
    // ----------------计时学习相关错误
    ERR_HAS_ADDED_LEARNING_CATEGORY = 201,//ERR_HAS_ADDED_LEARNING_CATEGORY = 201;//已经添加了学习记录
    ERR_FINISH_TIMING_CLIENT_TIME = 202,//完成计时时客户端时间修改了
    ERR_FINISH_TIMING_TIME_NOT_ENOUGH = 203,//完成计时时时间不够
    ERR_HAS_NOT_ADDED_LEARNING_CATEGORY = 204,//还没有添加学习目标
    
};

//私信发送状态
typedef NS_ENUM(NSInteger,ZZChatConditionType){
    ZZChatConditionTypeNormal = 0,//发送成功或未发送
    ZZChatConditionTypeSending = 1,//发送中
    ZZChatConditionTypeFail = 2,//发送失败
};

//聊天cell边角变圆
typedef enum{
    KLChatCellRoundTypeTop       = 0,    //上圆角
    KLChatCellRoundTypeMiddle,          //无圆角
    KLChatCellRoundTypeBottom,           //下圆角
    KLChatCellRoundTypeBoth             //两边圆角
}KLChatCellRoundType;

@interface WGEnum : NSObject

@end
