//
//  UITextField+HLTextField.m
//  TBBUITextField Format
//
//  Created by tangbinbin on 16/7/19.
//  Copyright © 2016年 tangbinbin. All rights reserved.
//

#import "UITextField+HLNumberFormatTextField.h"

@implementation UITextField (HLTextField)

/**
 *  输入号码格式化
 *  参数 textField UITextField控件
 *  参数 range 文本范围
 *  参数 string 字符串
 *  参数 type 文本框输入号码类型（身份证，手机号，银行卡）
 */
+ (BOOL)numberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string textFieldType:(kTextFieldType)type
{
    NSLog(@"%@",NSStringFromRange(range));
    if (textField) {
        NSString *text = textField.text;
        //删除
        if([string isEqualToString:@""]){
            
            //删除一位
            if(range.length == 1){
                //最后一位,遇到空格则多删除一次
                if (range.location == text.length-1 ) {
//                    if ([text characterAtIndex:text.length-1] == ' ') {
//                        [textField deleteBackward];
//                    }
              
                    return YES;
                }
                //从中间删除
                else{
                    NSInteger offset = range.location;

                    if (range.location < text.length && [text characterAtIndex:range.location] == ' ' && [textField.selectedTextRange isEmpty]) {
                        [textField deleteBackward];
                 
                        offset --;
                    }
                    
                    [textField deleteBackward];
  
                    textField.text = [self insertString:textField.text withTextFieldType:type];
                    UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                    
                    textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                    return NO;
                }
            }
            else if (range.length > 1) {
                BOOL isLast = NO;
                //如果是从最后一位开始删除
                if(range.location + range.length == textField.text.length ){
                    isLast = YES;
                }
                [textField deleteBackward];
                textField.text = [self insertString:textField.text withTextFieldType:type];
                
                NSInteger offset = range.location;

                [self shouldChangeCharactersInRange:range textFieldType:type locationOffset:offset];

                if (isLast) {
                    //光标直接在最后一位了
                }else{
                    UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                    textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                }
                
                return NO;
            }
            
            else{
                return YES;
            }
        }else if(string.length >0){
            
            
            if (type == kIDCardNoTextFieldType) {
                //限制输入字符个数
                if (([self whiteSpaseString:textField.text].length + string.length - range.length > 18) ) {
                    return NO;
                }
  
            }else if (type == kPhoneNumberTextFieldType){
               
                //限制输入字符个数
                if (([self whiteSpaseString:textField.text].length + string.length - range.length > 11) ) {
                    return NO;
                }
                
            }else{
                
                //限制输入字符个数
                if (([self whiteSpaseString:textField.text].length + string.length - range.length > 24) ) {
                    return NO;
                }
 
            }

            [textField insertText:string];
            textField.text = [self insertString:textField.text withTextFieldType:type];
            //设置光标偏移量
            NSInteger offset = range.location + string.length;
             [self shouldChangeCharactersInRange:range textFieldType:type locationOffset:offset];

            if (type == kIDCardNoTextFieldType) {
                if (range.location == 6 || range.location  == 15) {
                    offset ++;
                }
            }else if (type == kPhoneNumberTextFieldType){
                if (range.location == 3 || range.location  == 8) {
                    offset ++;
                }
                
            }else{
                
                if (range.location == 4 || range.location  == 9 || range.location == 14 || range.location  == 19 || range.location == 24 || range.location == 29) {
                    offset ++;
                }
                
            }
            UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
            textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
            return NO;
        }else{
            return YES;
        }
        
    }
    
    return YES;

}

//输入相应位数后面增加空格
+(NSString*)insertString:(NSString*)string withTextFieldType:(kTextFieldType)type
{
    if (!string) {
        return nil;
    }
    NSMutableString* tStr = [NSMutableString stringWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
    if (type == kIDCardNoTextFieldType) {
        //身份证号
        if (tStr.length >6) {
            [tStr insertString:@" " atIndex:6];
        }if (tStr.length > 15) {
            [tStr insertString:@" " atIndex:15];
            
        }
    }else if (type == kPhoneNumberTextFieldType){
    
        //手机号
        if (tStr.length >3) {
            [tStr insertString:@" " atIndex:3];
        }if (tStr.length > 8) {
            [tStr insertString:@" " atIndex:8];
            
        }
        
    }else{
    
        //银行卡号
        if (tStr.length >4) {
            [tStr insertString:@" " atIndex:4];
        }if (tStr.length > 9) {
            [tStr insertString:@" " atIndex:9];
            
        } if (tStr.length >14) {
            [tStr insertString:@" " atIndex:14];
        }if (tStr.length > 19) {
            [tStr insertString:@" " atIndex:19];
            
        }if (tStr.length >24) {
            [tStr insertString:@" " atIndex:24];
        }if (tStr.length >29) {
            [tStr insertString:@" " atIndex:29];
        }
        
    }
    
    return  tStr;
}

//设置光标位置
+(void)shouldChangeCharactersInRange:(NSRange)range  textFieldType:(kTextFieldType)type locationOffset:(NSInteger)offset{

    if (type == kIDCardNoTextFieldType) {
        if (range.location == 6 || range.location  == 15) {
            offset ++;
        }
    }else if (type == kPhoneNumberTextFieldType){
        if (range.location == 3 || range.location  == 8) {
            offset ++;
        }
        
    }else{
        
        if (range.location == 4 || range.location  == 9 || range.location == 14 || range.location  == 19 || range.location  == 24) {
            offset ++;
        }
        
    }
}
//去除空格
+(NSString*)whiteSpaseString:(NSString*)string
{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}


@end
