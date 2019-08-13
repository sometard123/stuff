package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.monkeyKnowledge.KnowledgeBounty;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   
   public class MonkeyKnowledgeSecretXPTarget
   {
       
      
      private var _clip:MovieClip;
      
      private var homePosition:Point;
      
      private const TWEEN_DISTANCE:Number = 200;
      
      private var isRevealed:Boolean = false;
      
      private var _timeOfLastFlash:Number = 0;
      
      public function MonkeyKnowledgeSecretXPTarget(param1:MovieClip)
      {
         this.homePosition = new Point();
         super();
         this._clip = param1;
         this.homePosition.x = this._clip.x;
         this.homePosition.y = this._clip.y;
         MonkeyKnowledgeCard.cardTransmutedSignal.add(this.onCardTransmuted);
         DustBurst.reachedTargetSignal.add(this.onParticleReachedTarget);
         this._clip.flashAnimation.gotoAndStop("hidden");
         this.hide(0);
      }
      
      private function onParticleReachedTarget() : void
      {
         var _loc1_:Number = getTimer();
         if(_loc1_ - this._timeOfLastFlash > 50)
         {
            this.flash();
         }
      }
      
      private function onStageClick(param1:MouseEvent) : void
      {
         this.hide();
      }
      
      public function reveal(param1:Number = 0.4) : void
      {
         if(this.isRevealed)
         {
            return;
         }
         this._clip.visible = true;
         TweenLite.to(this._clip,param1,{
            "y":this.homePosition.y,
            "ease":Cubic.easeInOut
         });
         MonkeySystem.getInstance().flashStage.addEventListener(MouseEvent.CLICK,this.onStageClick);
         DustBurst.reachedTargetSignal.add(this.onParticleReachedTarget);
         this._clip.flashAnimation.gotoAndStop("hidden");
         this.isRevealed = true;
      }
      
      public function hide(param1:Number = 0.2) : void
      {
         var time:Number = param1;
         MonkeySystem.getInstance().flashStage.removeEventListener(MouseEvent.CLICK,this.onStageClick);
         DustBurst.reachedTargetSignal.remove(this.onParticleReachedTarget);
         TweenLite.to(this._clip,time,{
            "y":this.homePosition.y + this.TWEEN_DISTANCE,
            "ease":Cubic.easeInOut,
            "onComplete":function():void
            {
               _clip.visible = false;
            }
         });
         this.isRevealed = false;
      }
      
      private function onCardTransmuted(param1:MonkeyKnowledgeToken) : void
      {
         if(param1.subType === KnowledgeBounty.BOUNTY_SECRET_TYPE)
         {
            this.reveal();
         }
      }
      
      private function flash() : void
      {
         this._timeOfLastFlash = getTimer();
         this._clip.flashAnimation.gotoAndPlay(1);
      }
   }
}
