package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.town.ModalBlockerClip;
   import com.greensock.TweenLite;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import org.osflash.signals.Signal;
   
   public class ModalBlocker extends MovieClip
   {
      
      private static const _clipPool:Vector.<ModalBlockerClip> = Vector.<ModalBlockerClip>([new ModalBlockerClip(),new ModalBlockerClip()]);
      
      private static const _modalList:Vector.<ModalWindowElement> = new Vector.<ModalWindowElement>();
      
      public static var instance:ModalBlocker;
       
      
      private var _stage:Stage;
      
      public const stateChangedSignal:Signal = new Signal(Boolean);
      
      public function ModalBlocker()
      {
         super();
         if(instance != null)
         {
            throw new Error("Error: Instantiation failed: Use ModalBlocker.getInstance() instead of new.");
         }
      }
      
      private static function getClip() : ModalBlockerClip
      {
         var _loc1_:ModalBlockerClip = null;
         if(_clipPool.length > 0)
         {
            _loc1_ = _clipPool.pop();
         }
         else
         {
            _loc1_ = new ModalBlockerClip();
         }
         _loc1_.mouseEnabled = true;
         _loc1_.mouseChildren = true;
         _loc1_.visible = true;
         _loc1_.alpha = 0;
         return _loc1_;
      }
      
      private static function recycleClip(param1:ModalBlockerClip) : void
      {
         if(param1 != null)
         {
            param1.mouseEnabled = false;
            param1.mouseChildren = false;
            param1.visible = false;
            _clipPool.push(param1);
         }
      }
      
      public static function getInstance() : ModalBlocker
      {
         if(instance == null)
         {
            instance = new ModalBlocker();
         }
         return instance;
      }
      
      public function setStage(param1:Stage) : void
      {
         this._stage = param1;
         this._stage.addEventListener(Event.RESIZE,this.resizeHandler);
         this.resizeHandler(null);
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < _modalList.length)
         {
            _modalList[_loc2_].clip.width = this._stage.stageWidth;
            _modalList[_loc2_].clip.height = this._stage.stageHeight;
            _loc2_++;
         }
      }
      
      public function reveal(param1:Object, param2:DisplayObjectContainer, param3:Number = 0.5) : void
      {
         var _loc4_:ModalBlockerClip = getClip();
         var _loc5_:ModalWindowElement = new ModalWindowElement(param1,param2,_loc4_);
         _modalList.push(_loc5_);
         var _loc6_:int = 0;
         while(_loc6_ < _modalList.length)
         {
            if(_modalList[_loc6_].key != param1)
            {
               if(_modalList[_loc6_].clip.visible == true)
               {
                  _modalList[_loc6_].clip.visible = false;
                  _loc5_.backupClip = _modalList[_loc6_].clip;
                  break;
               }
            }
            _loc6_++;
         }
         param2.addChild(_loc4_);
         TweenLite.killTweensOf(this);
         TweenLite.to(_loc4_,param3,{"alpha":0.4});
         this.stateChangedSignal.dispatch(true);
         if(this._stage)
         {
            this.resizeHandler();
         }
      }
      
      public function hide(param1:Object, param2:Number = 0.5) : void
      {
         var _loc3_:ModalWindowElement = null;
         var _loc4_:int = 0;
         while(_loc4_ < _modalList.length)
         {
            if(_modalList[_loc4_].key == param1)
            {
               _loc3_ = _modalList[_loc4_];
               break;
            }
            _loc4_++;
         }
         if(_loc3_ != null)
         {
            if(_loc3_.backupClip != null)
            {
               _loc3_.backupClip.visible = true;
               this.deleteModalWindowElement(_loc3_);
            }
            else
            {
               TweenLite.killTweensOf(_loc3_.clip);
               TweenLite.to(_loc3_.clip,param2,{"alpha":0});
               TweenLite.delayedCall(param2,this.onHideComplete,[_loc3_]);
            }
         }
      }
      
      private function onHideComplete(param1:ModalWindowElement) : void
      {
         if(param1.container && param1.clip && param1.container.contains(param1.clip))
         {
            param1.container.removeChild(param1.clip);
         }
         this.deleteModalWindowElement(param1);
         this.stateChangedSignal.dispatch(false);
      }
      
      private function deleteModalWindowElement(param1:ModalWindowElement) : void
      {
         var _loc2_:int = _modalList.indexOf(param1);
         if(_loc2_ > -1)
         {
            _modalList.splice(_loc2_,1);
         }
         var _loc3_:int = 0;
         while(_loc3_ < _modalList.length)
         {
            if(_modalList[_loc3_].backupClip == param1.clip)
            {
               _modalList[_loc3_].backupClip = null;
            }
            _loc3_++;
         }
         param1.backupClip = null;
         recycleClip(param1.clip);
         param1.clip = null;
      }
   }
}
