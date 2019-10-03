package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.LightningBoltClip;
   import com.greensock.TweenLite;
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.UpgradeableBuilding;
   
   public class LightningBolt extends Sprite
   {
      
      private static const FRAME_LIST:Array = [1,5,9];
       
      
      private var _clip:LightningBoltClip;
      
      private const DURATION:Number = 3;
      
      private const CARD_WIDTH:Number = 121;
      
      private const CARD_HEIGHT:Number = 167;
      
      public function LightningBolt()
      {
         this._clip = new LightningBoltClip();
         super();
         this._clip.stop();
      }
      
      public function go() : void
      {
         TweenLite.delayedCall(Math.floor(Math.random() * 20),this.trigger,null,true);
      }
      
      private function trigger() : void
      {
         this.addChild(this._clip);
         this._clip.gotoAndStop(this.getRandomFrame());
         this._clip.x = this.CARD_WIDTH * 0.25;
         this.rotation = (Math.random() - 0.5) * 360;
         this._clip.scaleX = this._clip.scaleY = 0.8 - Math.random() * 0.2;
         this._clip.scaleY = Math.random() < 0.5?Number(1):Number(-1);
         TweenLite.delayedCall(3,this.release,null,true);
      }
      
      private function getRandomFrame() : int
      {
         return FRAME_LIST[int(Math.random() * FRAME_LIST.length)];
      }
      
      private function release() : void
      {
         if(this.parent !== null && this.parent.contains(this))
         {
            this.parent.removeChild(this);
         }
         this.removeChild(this._clip);
         this._clip = null;
      }
   }
}
