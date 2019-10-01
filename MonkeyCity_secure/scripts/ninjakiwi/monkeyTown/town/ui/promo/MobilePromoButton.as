package ninjakiwi.monkeyTown.town.ui.promo
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Back;
   import com.greensock.easing.Cubic;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.town.townMap.TrackData;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class MobilePromoButton extends Sprite
   {
       
      
      protected var _clip:MovieClip;
      
      protected var _iosPromoButton:ButtonControllerBase;
      
      protected var _androidPromoButton:ButtonControllerBase;
      
      protected const DisplayUtil:LGDisplayListUtil = LGDisplayListUtil.getInstance();
      
      protected var _appButtons:MovieClip;
      
      protected var _promoImage:MovieClip;
      
      public function MobilePromoButton(param1:MovieClip)
      {
         this._clip = new MovieClip();
         super();
         this._clip = param1;
         this._appButtons = this._clip.appStoreButtons;
         this._promoImage = this._clip.image;
         this.init();
      }
      
      protected function init() : void
      {
         addChild(this._clip);
         this._iosPromoButton = new ButtonControllerBase(this._appButtons.btnAppStore);
         this._iosPromoButton.setClickFunction(this.onClickApple);
         this._androidPromoButton = new ButtonControllerBase(this._appButtons.btnGooglePlay);
         this._androidPromoButton.setClickFunction(this.onClickAndroid);
         this._appButtons.alpha = 0;
         this._appButtons.scaleY = _loc1_;
         this._appButtons.scaleX = _loc1_;
         this._clip.addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
         this._clip.addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
      }
      
      protected function onClickApple() : void
      {
         navigateToURL(new URLRequest(Constants.APPLE_STORE_BMC_URL),"_blank");
      }
      
      protected function onClickAndroid() : void
      {
         navigateToURL(new URLRequest(Constants.ANDROID_STORE_BMC_URL),"_blank");
      }
      
      public function hide(param1:Number = 0.5) : void
      {
         this._clip.x = -this._clip.width;
         this._clip.visible = false;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._clip,false,true,true);
      }
      
      public function reveal(param1:Number = 0.5) : void
      {
         this._clip.visible = true;
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._clip,true,true,true);
         this._clip.gotoAndStop(1);
         this._appButtons.btnAppStore.gotoAndStop(1);
         this._appButtons.btnGooglePlay.gotoAndStop(1);
         TweenLite.to(this._clip,param1,{
            "x":0,
            "ease":Cubic.easeOut
         });
      }
      
      protected function onMouseOver(param1:MouseEvent = null) : void
      {
         TweenLite.to(this._appButtons,0.3,{
            "scaleX":1,
            "scaleY":1,
            "alpha":1,
            "ease":Back.easeOut
         });
         TweenLite.to(this._promoImage,0.3,{
            "scaleX":0,
            "scaleY":0,
            "alpha":0,
            "ease":Back.easeOut
         });
      }
      
      protected function onMouseOut(param1:MouseEvent = null) : void
      {
         TweenLite.to(this._appButtons,0.3,{
            "scaleX":0,
            "scaleY":0,
            "alpha":0,
            "ease":Back.easeOut
         });
         TweenLite.to(this._promoImage,0.3,{
            "scaleX":1,
            "scaleY":1,
            "alpha":1,
            "ease":Back.easeOut
         });
      }
   }
}
