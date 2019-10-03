package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.io.WildCardPad;
   import assets.ui.CardFrontNoAnimation;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePortraitData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import org.osflash.signals.Signal;
   
   public class WildCardFront extends Sprite
   {
      
      public static var showWildCardDustBurstSignal:Signal = new Signal(WildCardFront);
       
      
      private var _clip:CardFrontNoAnimation;
      
      public var token:MonkeyKnowledgeToken = null;
      
      public var DisplayUtil:LGDisplayListUtil;
      
      public function WildCardFront(param1:MonkeyKnowledgeToken)
      {
         this._clip = new CardFrontNoAnimation();
         this.DisplayUtil = LGDisplayListUtil.getInstance();
         super();
         this.token = param1;
         this.build(param1);
      }
      
      private function build(param1:MonkeyKnowledgeToken) : void
      {
         addChild(new WildCardPad());
         addChild(this._clip);
         if(this.DisplayUtil.hasLabel(this._clip.cardTitle,param1.type))
         {
            this._clip.cardTitle.gotoAndStop(param1.type);
         }
         else
         {
            this._clip.cardTitle.visible = false;
         }
         this._clip.aztecLines.gotoAndStop(1);
         this._clip.cardTitle.gotoAndStop(1);
         this._clip.banner.gotoAndStop(1);
         var _loc2_:Class = MonkeyKnowledgePortraitData.getClassByToken(param1);
         var _loc3_:MovieClip = new _loc2_();
         this._clip.portraitContainer.addChild(_loc3_);
         if(_loc3_.above)
         {
            this._clip.portraitContainerAbove.addChild(_loc3_.above);
         }
         _loc3_.x = this._clip.portraitContainer.placeholder.x;
         _loc3_.y = this._clip.portraitContainer.placeholder.y;
         this._clip.portraitContainer.removeChild(this._clip.portraitContainer.placeholder);
         this._clip.portraitContainerAbove.removeChild(this._clip.portraitContainerAbove.placeholder);
         this._clip.backgroundColor.gotoAndStop(param1.quality);
         this._clip.banner.gotoAndStop(param1.quality);
         this._clip.aztecLines.gotoAndStop(param1.quality);
         this._clip.aztecLines.mask = this._clip.diagonalMask;
         this._clip.pointsDisplay.textField.text = param1.points;
         this._clip.cardTitle.gotoAndStop("WildCard");
      }
      
      public function transmuteCard(param1:DisplayObjectContainer) : void
      {
         this.spawnCollectAnimation(param1);
         showWildCardDustBurstSignal.dispatch(this);
         this._clip.visible = false;
      }
      
      public function spawnCollectAnimation(param1:DisplayObjectContainer) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:Object = MonkeyKnowledgeCard.sfxData[this.token.quality];
         _loc3_ = new _loc2_.collectClass();
         _loc3_.x = this.x;
         _loc3_.y = this.y;
         this.parent.addChild(_loc3_);
         this.DisplayUtil.reparentAndPreserveGlobalPosition(_loc3_,param1);
      }
      
      public function get particlesPerBurst() : int
      {
         var _loc1_:Object = MonkeyKnowledgeCard.sfxData[this.token.quality];
         if(_loc1_ !== null)
         {
            return _loc1_.particlesPerBurst;
         }
         return 50;
      }
   }
}
