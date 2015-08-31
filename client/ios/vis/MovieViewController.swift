//
//  MovieViewController.swift
//  vis
//
//  Created by Qing Sheng on 15/8/5.
//  Copyright (c) 2015年 Sheng Qing. All rights reserved.
//

import UIKit
import MediaPlayer


class MovieViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var cateLbl: UILabel!
    @IBOutlet weak var ScBtn: UIButton!
    @IBOutlet weak var FxBtn: UIButton!
    @IBOutlet weak var HcBtn: UIButton!
    
    var service = MovieService()
    
    var movie:Movie?{
        didSet {
            
//            updateView()
        }
    }

    @IBOutlet weak var image: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.title = movie?.title
        
        var url = NSURL(string: "http://182.92.153.230/file/" + movie!.image)
        image.sd_setImageWithURL(url)
        
        
        self.titleLbl.text = movie?.title
//        cateLbl.text = movie!.category + " / " + (movie!.length / 60) + "'" + (movie!.length / 60) + "\""
        cateLbl.text = "\(movie!.category)  /  \(movie!.length / 60)' \(movie!.length % 60)\""
//        self.descLbl.text = movie?.description
        var txt = NSMutableAttributedString(string: movie!.desc)
        var style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        txt.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, count(movie!.desc)))
//        txt.addAttributes(style, range: NSMakeRange(0, count(movie!.description)))
        descLbl.attributedText = txt
        
//        descLbl.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
//        descLbl.numberOfLines = 0
//        descLbl.frame = CGRectMake(0, 0, 200, 600)
//        descLbl.sizeToFit()
        
        let singleTap = UITapGestureRecognizer(target: self, action: "playMovie")
        singleTap.numberOfTapsRequired = 1
        image.userInteractionEnabled = true
        image.addGestureRecognizer(singleTap)
        
        
        ScBtn.setImage(UIImage(named: "收藏"), forState: UIControlState.Normal)
        ScBtn.setImage(UIImage(named: "已收藏"), forState: UIControlState.Selected)
        HcBtn.setImage(UIImage(named: "缓存"), forState: UIControlState.Normal)
        HcBtn.setImage(UIImage(named: "已缓存"), forState: UIControlState.Selected)
        
        if(service.checkShoucang(movie!)){
            ScBtn.selected = true
        }
        if(service.checkHuancun(movie!)){
            HcBtn.selected = true
        }
        
    }
    
    var playerVC:MPMoviePlayerViewController?
    
    func playMovie(){
        var urlStr = "http://182.92.153.230/file/" + movie!.video;
//        var urlStr = "http://www.sheng00.com/jwplayer/video.mp4"
        var url = NSURL(string: urlStr)
        
        
        playerVC = MPMoviePlayerViewController(contentURL: url)
        
        
        NSNotificationCenter.defaultCenter().removeObserver(playerVC!, name: MPMoviePlayerPlaybackDidFinishNotification, object: playerVC!.moviePlayer)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "movieFinishedCallback", name: MPMoviePlayerPlaybackDidFinishNotification, object: playerVC!.moviePlayer)
        
        playerVC!.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        presentViewController(playerVC!, animated: true, completion: {})
        
        
        var landscapeTransform = CGAffineTransformMakeRotation(CGFloat(M_PI_2));
        playerVC!.moviePlayer.view.transform = landscapeTransform;
        
        playerVC!.moviePlayer.movieSourceType = MPMovieSourceType.File
        playerVC!.moviePlayer.prepareToPlay()
        playerVC!.moviePlayer.play()

        
    }
    
    func movieFinishedCallback(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MPMoviePlayerPlaybackDidFinishNotification, object: playerVC!.moviePlayer)
        dismissMoviePlayerViewControllerAnimated()
    }
    
    func doneButtonClick(){
        println("doneButtonClick")
    }
    
    func share(){
        var url = "http://182.92.153.230/\(movie!.id)"
        //wechat
        UMSocialWechatHandler.setWXAppId("wx6edc904b2fb2ca36", appSecret: "3457e00b56a26d4399f7fda669f3a037", url: url)
//        UMSocialData.defaultData().extConfig.wechatTimelineData.title = movie!.title
        
        //qq
        UMSocialQQHandler.setQQWithAppId("1104708147", appKey:"BEvrXcIO5hMusbWv" ,url:url);
        
        
//        UMSocialConfig.hiddenNotInstallPlatforms([UMShareToQQ,UMShareToWechatTimeline,UMShareToWechatSession, UMShareToSina])
        
        var shareTypes:NSArray = [UMShareToQQ,UMShareToWechatTimeline,UMShareToWechatSession, UMShareToSina];
        
        UMSocialData.defaultData().title = movie!.title
        UMSocialData.defaultData().extConfig.qqData.title = movie!.title
        UMSocialData.defaultData().extConfig.wechatSessionData.title = movie!.title
        UMSocialData.defaultData().extConfig.sinaData.shareText = movie!.desc + " " + url
        
        UMSocialSnsService.presentSnsIconSheetView(self,
            appKey:"55c32328e0f55ae881000579",
            shareText:movie?.desc,
            shareImage:image.image,
            shareToSnsNames:shareTypes as [AnyObject],
            delegate:nil);

    }
    
//    func share2(){
//        var url = "http://182.92.153.230/\(movie!.id)"
//        var shareParames = NSMutableDictionary()
//        
//        shareParames.SSDKSetupShareParamsByText(movie?.description,
//            images : image.image,
//            url : NSURL(string: url),
//            title : movie?.title,
//            type : SSDKContentType.Auto)
//        
//        //2.进行分享
//        ShareSDK.showShareActionSheet(self.view,
//            items: nil,
//            shareParams: shareParames) { (
//                state : SSDKResponseState,
//                platformType : SSDKPlatformType,
//                userdata : [NSObject : AnyObject]!,
//                contentEnity : SSDKContentEntity!,
//                error : NSError!, Bool end) -> Void in
//            
//            switch state{
//                
//            case SSDKResponseState.Success: println("分享成功")
//            case SSDKResponseState.Fail:    println("分享失败,错误描述:\(error)")
//            case SSDKResponseState.Cancel:  println("分享取消")
//                
//            default:
//                break
//            }
//        }
//
////        ShareSDK.share(SSDKPlatformType.TypeSinaWeibo, parameters: shareParames) { (state : SSDKResponseState, userData : [NSObject : AnyObject]!, contentEntity :SSDKContentEntity!, error : NSError!) -> Void in
////            
////            switch state{
////                
////            case SSDKResponseState.Success:
////                println("分享成功")
////                let alert = UIAlertView(title: "分享成功", message: "分享成功", delegate: self, cancelButtonTitle: "取消")
////                alert.show()
////            case SSDKResponseState.Fail:    println("分享失败,错误描述:\(error)")
////            case SSDKResponseState.Cancel:  println("分享取消")
////                
////            default:
////                break
////            }
////        }
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        if let movieName = movie?.title{
            MobClick.beginLogPageView(movieName)
        }
    }
    override func viewWillDisappear(animated: Bool){
        super.viewWillDisappear(animated)
        if let movieName = movie?.title{
            MobClick.endLogPageView(movieName)
        }
    }
    

    @IBAction func Shoucang(sender: UIButton) {
        sender.selected = !sender.selected
        if(sender.selected){
            service.addShoucang(movie!)
        }else{
            service.deleteShoucang(movie!)
        }
    }

    
    @IBAction func shareBtnPressed(sender: UIButton) {
        share()
//        service.addShoucang(movie!)
//        service.deleteShoucang(movie!)
//        var list = service.getShoucang()
//        for item in list {
//            println(item.title)
//        }
    }

    @IBAction func Huancun(sender: UIButton) {
        sender.selected = !sender.selected
        if(sender.selected){
            service.addHuancun(movie!)
        }else{
            service.deleteHuancun(movie!)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
