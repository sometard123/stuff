package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.btdmodule.SkullMarker;
   import com.greensock.TweenLite;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   
   public class BossHealthbar
   {
       
      
      private var _clip:MovieClip;
      
      private var healthBarMask:MovieClip;
      
      private var dreadShieldMask:MovieClip;
      
      private var healthBarSkulls:Vector.<SkullMarker>;
      
      public function BossHealthbar(param1:MovieClip)
      {
         super();
         this._clip = param1;
         this.healthBarMask = this._clip.barMask;
         this.dreadShieldMask = this._clip.shieldMask;
         param1.bar.mask = this.healthBarMask;
         param1.dreadShieldBar.mask = this.dreadShieldMask;
         this.healthBarSkulls = new Vector.<SkullMarker>();
         this.healthBarSkulls.push(new SkullMarker());
         this.healthBarSkulls.push(new SkullMarker());
         this.healthBarSkulls.push(new SkullMarker());
         var _loc2_:int = 0;
         while(_loc2_ < this.healthBarSkulls.length)
         {
            this.healthBarSkulls[_loc2_].x = this.healthBarMask.x + this.healthBarMask.width * 0.25 * (_loc2_ + 1);
            this.healthBarSkulls[_loc2_].y = this.healthBarMask.y + 18 - _loc2_ * 2;
            this._clip.addChild(this.healthBarSkulls[_loc2_]);
            _loc2_++;
         }
         param1.addChild(param1.dreadShieldBar);
      }
      
      public function setHealthbarVisible(param1:Boolean, param2:Boolean = false) : void
      {
         this._clip.visible = param1;
         this.setShieldVisible(param2);
         if(param1 == true)
         {
            this.resetSkulls();
            this._clip.alpha = 0;
            TweenLite.to(this._clip,0.5,{"alpha":1});
         }
         else
         {
            this._clip.alpha = 1;
         }
      }
      
      public function setHealthBarProgress(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > 1)
         {
            param1 = 1;
         }
         this.healthBarMask.scaleX = param1;
      }
      
      public function setBossLevel(param1:int) : void
      {
         this._clip.levelField.text = param1.toString();
      }
      
      public function resetSkulls() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.healthBarSkulls.length)
         {
            this.healthBarSkulls[_loc1_].gotoAndStop(1);
            _loc1_++;
         }
      }
      
      public function explodeSkull(param1:int) : void
      {
         if(this.healthBarSkulls.length > param1)
         {
            this.healthBarSkulls[param1].gotoAndStop(2);
         }
      }
      
      public function setBossIcon(param1:String) : void
      {
         if(this.hasLabel(this._clip.bossIcon,param1))
         {
            this._clip.bossIcon.gotoAndStop(param1);
         }
         else
         {
            this._clip.bossIcon.gotoAndStop(1);
         }
      }
      
      public function setShieldHealth(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > 1)
         {
            param1 = 1;
         }
         this.dreadShieldMask.scaleX = param1;
      }
      
      public function setShieldVisible(param1:Boolean) : void
      {
         this._clip.dreadShieldBar.visible = param1;
      }
      
      private function hasLabel(param1:MovieClip, param2:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc5_:FrameLabel = null;
         var _loc4_:int = param1.currentLabels.length;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.currentLabels[_loc3_];
            if(_loc5_.name == param2)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
   }
}
