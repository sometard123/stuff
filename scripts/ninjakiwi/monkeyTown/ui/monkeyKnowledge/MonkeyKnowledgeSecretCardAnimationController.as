package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.BlackBackgroundBlocker;
   import assets.ui.BountySecretTransmuteFlipAnimation;
   import assets.ui.SecretCardExplosionClip;
   import assets.ui.SecretCardExplosionLeadupClip;
   import assets.ui.SecretCardRaysClip;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import fl.motion.AdjustColor;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePortraitData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.SecretAwarder;
   import ninjakiwi.monkeyTown.net.Squeeze;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   import ninjakiwi.monkeyTown.pvp.PvPMain;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.townMap.TrackData;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.ModalBlocker;
   import ninjakiwi.monkeyTown.ui.PlayOnceClip;
   import org.osflash.signals.Signal;
   
   public class MonkeyKnowledgeSecretCardAnimationController
   {
      
      public static const SHUDDER_OUT_FRAMES:int = 60;
       
      
      private var _card:MonkeyKnowledgeCard = null;
      
      private var _allAvatars:Vector.<MovieClip>;
      
      private var _spinSpeedStart:Number = 5;
      
      private var _pauseTimeStart:Number = 15;
      
      private var _spinSpeedMax:Number = 1;
      
      private var _pauseTimeMax:Number = 1;
      
      private var _spinSpeedAccelarate:Number = 1.1;
      
      private var _pauseTimeAccelarate:Number = 1.1;
      
      private var _spinSpeed:Number;
      
      private var _pauseTime:Number;
      
      private var _blackBackground:BlackBackgroundBlocker;
      
      private var _currentID:String = null;
      
      private var _awardCounter:int = 0;
      
      private var allAvatarIDs:Array = null;
      
      private var _colorFilter:AdjustColor;
      
      private var _effectColorMatrixFilter:ColorMatrixFilter;
      
      private var _rays:SecretCardRaysClip;
      
      public function MonkeyKnowledgeSecretCardAnimationController(param1:MonkeyKnowledgeCard)
      {
         this._allAvatars = new Vector.<MovieClip>();
         this._spinSpeed = this._spinSpeedStart;
         this._pauseTime = this._pauseTimeStart;
         this._blackBackground = new BlackBackgroundBlocker();
         this._colorFilter = new AdjustColor();
         this._rays = new SecretCardRaysClip();
         super();
         this._card = param1;
         this.init();
      }
      
      private function init() : void
      {
         var _loc4_:String = null;
         var _loc5_:Class = null;
         var _loc6_:MovieClip = null;
         this.allAvatarIDs = MonkeyKnowledgePortraitData.allAvatarIDs.slice();
         var _loc1_:int = this.allAvatarIDs.indexOf("ActiveAbility");
         this.allAvatarIDs.splice(_loc1_,1);
         this.allAvatarIDs.push("ActiveAbility");
         var _loc2_:int = this.allAvatarIDs.indexOf(MonkeyKnowledgeCard.WILDCARD);
         this.allAvatarIDs.splice(_loc2_,1);
         var _loc3_:int = 0;
         while(_loc3_ < this.allAvatarIDs.length)
         {
            _loc4_ = this.allAvatarIDs[_loc3_];
            _loc5_ = MonkeyKnowledgePortraitData.getClass(_loc4_,MonkeyKnowledge.LEGENDARY);
            _loc6_ = new _loc5_();
            this._allAvatars.push(_loc6_);
            _loc3_++;
         }
      }
      
      public function start() : void
      {
         this._awardCounter = 0;
         this._card.hasBeenTransmuted = true;
         this._card._behindCardContainer.addChild(this._rays);
         this._blackBackground.width = 3000;
         this._blackBackground.height = 3000;
         this._blackBackground.alpha = 0;
         this._card.parent.addChild(this._blackBackground);
         this._card.parent.addChild(this._card);
         var _loc1_:Number = 1.5;
         TweenLite.to(this._blackBackground,0.5,{
            "alpha":0.65,
            "ease":Cubic.easeOut
         });
         TweenLite.to(this._card,0.7,{
            "x":0,
            "y":0,
            "scaleX":_loc1_,
            "scaleY":_loc1_,
            "ease":Cubic.easeOut
         });
         var _loc2_:Number = this.allAvatarIDs.length;
         this._spinSpeed = this._spinSpeedStart;
         this._pauseTime = this._pauseTimeStart;
         if(this._card._secretCrackle.parent !== null && this._card._secretCrackle.parent.contains(this._card._secretCrackle))
         {
            this._card._secretCrackle.parent.removeChild(this._card._secretCrackle);
         }
         this.showNextAvatar();
      }
      
      private function showNextAvatar() : void
      {
         this.startFlip();
      }
      
      private function displayNextAvatar() : void
      {
         var _loc1_:MovieClip = this._allAvatars.shift();
         this._currentID = this.allAvatarIDs[this._awardCounter++];
         this.addAvatarToCard(_loc1_,this._currentID);
      }
      
      private function startFlip() : void
      {
         TweenLite.to(this._card._front,this._spinSpeed,{
            "scaleX":0,
            "onComplete":this.midFlip,
            "useFrames":true
         });
         MCSound.getInstance().playSound(MCSound["SECRET_BONUS5"],0.4);
      }
      
      private function midFlip() : void
      {
         this.displayNextAvatar();
         this.spawnLightning();
         TweenLite.to(this._card._front,this._spinSpeed,{
            "scaleX":1,
            "onComplete":this.postFlip,
            "useFrames":true
         });
      }
      
      private function postFlip() : void
      {
         var explosion:PlayOnceClip = null;
         var paramObject:Object = null;
         var flipAnimation:BountySecretTransmuteFlipAnimation = new BountySecretTransmuteFlipAnimation();
         this._card._cardContainer.addChild(flipAnimation);
         var spam:Spam250 = new Spam250();
         spam.x = this._card.x;
         spam.y = this._card.y - this._card._back.height * 0.5 * this._card.scaleY;
         spam.go();
         this._card.parent.addChild(spam);
         if(this._allAvatars.length > 0)
         {
            this._spinSpeed = this._spinSpeed / this._spinSpeedAccelarate;
            this._pauseTime = this._pauseTime / this._pauseTimeAccelarate;
            if(this._spinSpeed < this._spinSpeedMax)
            {
               this._spinSpeed = this._spinSpeedMax;
            }
            if(this._pauseTime < this._pauseTimeMax)
            {
               this._pauseTime = this._pauseTimeMax;
            }
            TweenLite.delayedCall(this._pauseTime,this.showNextAvatar,null,true);
         }
         else
         {
            TweenLite.delayedCall(SHUDDER_OUT_FRAMES,this.poof,null,true);
            MCSound.getInstance().playSound(MCSound.KNOWLEDGE_REVEAL_CARD_RARE);
            this._card.simpleShudder();
            explosion = new PlayOnceClip(new SecretCardExplosionLeadupClip());
            this._card._cardContainer.addChild(explosion);
            MCSound.getInstance().playSound(MCSound.SECRET_FLIPPED,0.3);
            this.initColorTransforms();
            paramObject = {"brightness":0};
            TweenLite.to(paramObject,SHUDDER_OUT_FRAMES,{
               "brightness":100,
               "onUpdate":function():void
               {
                  _colorFilter.brightness = paramObject.brightness;
                  applyColourFilters();
               },
               "useFrames":true
            });
         }
         var didRankUp:Boolean = SecretAwarder.updatePath(this._currentID);
         if(didRankUp)
         {
            this.spawnRankUpSpam();
         }
      }
      
      private function initColorTransforms() : void
      {
         this._colorFilter.hue = 0;
         this._colorFilter.saturation = 0;
         this._colorFilter.brightness = 0;
         this._colorFilter.contrast = 0;
         this.applyColourFilters();
      }
      
      private function applyColourFilters() : void
      {
         var _loc1_:Array = null;
         if(null === this._card._front)
         {
            return;
         }
         _loc1_ = this._colorFilter.CalculateFinalFlatArray();
         var _loc2_:ColorMatrixFilter = new ColorMatrixFilter(_loc1_);
         this._card._front.filters = [_loc2_];
      }
      
      private function spawnRankUpSpam() : void
      {
         var _loc1_:RankUpSpam = new RankUpSpam();
         _loc1_.x = this._card.x;
         _loc1_.y = this._card.y + this._card._back.height * 0.3 * this._card.scaleY;
         _loc1_.scaleX = _loc1_.scaleY = this._card.scaleY;
         _loc1_.go();
         this._card.parent.addChild(_loc1_);
      }
      
      private function spawnLightning() : void
      {
         var _loc3_:LightningBolt = null;
         var _loc1_:int = 3 + Math.random() * 2;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = new LightningBolt();
            _loc3_.x = this._card.x;
            _loc3_.y = this._card.y;
            this._card._behindCardContainer.addChild(_loc3_);
            _loc3_.go();
            _loc2_++;
         }
      }
      
      private function poof() : void
      {
         ModalBlocker.getInstance().hide(this._card);
         TweenLite.to(this._blackBackground,0.5,{
            "alpha":0,
            "ease":Cubic.easeOut,
            "onComplete":function():void
            {
               _blackBackground.parent.removeChild(_blackBackground);
               _blackBackground = null;
            }
         });
         this._rays.stop();
         this._rays.parent.removeChild(this._rays);
         this._rays = null;
         this._card.showSecretDustBurst();
         MCSound.getInstance().playSound(MCSound.SECRET_EXPLODE);
         var explosion:PlayOnceClip = new PlayOnceClip(new SecretCardExplosionClip());
         explosion.x = this._card.x;
         explosion.y = this._card.y;
         explosion.scaleX = explosion.scaleY = this._card.scaleX;
         this._card.parent.addChild(explosion);
         MonkeyKnowledgeCard.cardTransmutedSignal.dispatch(this._card.token);
         this._card.hasBeenTransmuted = true;
         this._card.release();
      }
      
      private function addAvatarToCard(param1:MovieClip, param2:String) : void
      {
         this._card._front.portraitContainer.removeChildren();
         this._card._front.portraitContainerAbove.removeChildren();
         if(this.hasLabel(this._card._front.cardTitle,param2))
         {
            this._card._front.cardTitle.gotoAndStop(param2);
         }
         this._card._front.portraitContainer.addChild(param1);
         if(param1.above)
         {
            this._card._front.portraitContainerAbove.addChild(param1.above);
         }
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
