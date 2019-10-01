package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import asses.ui.KnowledgeCardSide;
   import assets.ui.AltCashSpam;
   import assets.ui.BountyCardFlipLeadin;
   import assets.ui.BountyPostFlip;
   import assets.ui.BountySecretCardFlipLeadin;
   import assets.ui.BountySecretLightningLoop;
   import assets.ui.BountySecretPostFlip;
   import assets.ui.CommonCardFlipLeadin;
   import assets.ui.CommonPackOpenSFX;
   import assets.ui.CommonPostFlip;
   import assets.ui.FlashForwardClip;
   import assets.ui.KnowledgeCardBack;
   import assets.ui.KnowledgeCardFront;
   import assets.ui.LegandaryCardFlipLeadin;
   import assets.ui.LegendaryCollect;
   import assets.ui.LegendaryPostFlip;
   import assets.ui.RareCardFlipLeadin;
   import assets.ui.RarePostFlip;
   import assets.ui.UncommonCardFlipLeadin;
   import assets.ui.UncommonPostFlip;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import com.greensock.easing.Quart;
   import com.lgrey.utils.LGDisplayListUtil;
   import com.ninjakiwi.gateway.login.LoginInfo;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.monkeyKnowledge.KnowledgeBounty;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeBuffData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePathDefinition;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePortraitData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeTree;
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendRewardDef;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.Awarder;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.MilestoneRewardInfoBox;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   import treefortress.sound.SoundInstance;
   
   public class MonkeyKnowledgeCard extends Sprite
   {
      
      static const flipTime:Number = 0.5;
      
      static const COMMON_LEADIN_CLASS:Class = CommonCardFlipLeadin;
      
      static const UNCOMMON_LEADIN_CLASS:Class = UncommonCardFlipLeadin;
      
      static const RARE_LEADIN_CLASS:Class = RareCardFlipLeadin;
      
      static const LEGENDARY_LEADIN_CLASS:Class = LegandaryCardFlipLeadin;
      
      static const BOUNTY_LEADIN_CLASS:Class = BountyCardFlipLeadin;
      
      static const BOUNTY_SECRET_LEADIN_CLASS:Class = BountySecretCardFlipLeadin;
      
      static const COMMON_POST_FLIP_CLASS:Class = CommonPostFlip;
      
      static const UNCOMMON_POST_FLIP_CLASS:Class = UncommonPostFlip;
      
      static const RARE_POST_FLIP_CLASS:Class = RarePostFlip;
      
      static const LEGENDARY_POST_FLIP_CLASS:Class = LegendaryPostFlip;
      
      static const BOUNTY_POST_FLIP_CLASS:Class = BountyPostFlip;
      
      static const BOUNTY_SECRET_POST_FLIP_CLASS:Class = BountySecretPostFlip;
      
      static const LEGENDARY_COLLECT_CLASS:Class = LegendaryCollect;
      
      public static const WILDCARD:String = "WildCard";
      
      public static const BOUNTY_CARD:String = "BountyCard";
      
      public static const BOUNTY_SECRET_CARD:String = KnowledgeBounty.BOUNTY_SECRET_TYPE;
      
      static const COMMON_LEADIN_FRAMES:int = 7;
      
      static const UNCOMMON_LEADIN_FRAMES:int = 28;
      
      static const RARE_LEADIN_FRAMES:int = 25;
      
      static const LEGENDARY_LEADIN_FRAMES:int = 35;
      
      public static const cardFirstClicked:Signal = new Signal(String);
      
      public static const cardFlipBegin:Signal = new Signal(String);
      
      public static const cardFlipComplete:Signal = new Signal(String);
      
      public static const cardTransmutedSignal:Signal = new Signal(MonkeyKnowledgeToken);
      
      public static const showDustBurstSignal:Signal = new Signal(MonkeyKnowledgeCard);
      
      public static const showSecretDustBurstSignal:Signal = new Signal(MonkeyKnowledgeCard);
      
      public static const showPoofSignal:Signal = new Signal(MonkeyKnowledgeCard);
      
      public static const requestAssignWildcardSignal:Signal = new Signal(MonkeyKnowledgeCard);
      
      public static var sfxData:Object = {
         MonkeyKnowledge.COMMON.valueOf():{
            "leadinClass":COMMON_LEADIN_CLASS,
            "postFlipClass":COMMON_POST_FLIP_CLASS,
            "collectClass":COMMON_POST_FLIP_CLASS,
            "color":11456559,
            "tintAmount":0.85,
            "particlesPerBurst":30,
            "shudderRangeMax":2,
            "shudderFrames":13,
            "flipSound":MCSound.KNOWLEDGE_REVEAL_CARD_COMMON
         },
         MonkeyKnowledge.UNCOMMON.valueOf():{
            "leadinClass":UNCOMMON_LEADIN_CLASS,
            "postFlipClass":UNCOMMON_POST_FLIP_CLASS,
            "collectClass":UNCOMMON_POST_FLIP_CLASS,
            "color":14563127,
            "tintAmount":0.85,
            "particlesPerBurst":50,
            "shudderRangeMax":5,
            "shudderFrames":20,
            "flipSound":MCSound.KNOWLEDGE_REVEAL_CARD_UNCOMMON
         },
         MonkeyKnowledge.RARE.valueOf():{
            "leadinClass":RARE_LEADIN_CLASS,
            "postFlipClass":RARE_POST_FLIP_CLASS,
            "collectClass":RARE_POST_FLIP_CLASS,
            "color":8599518,
            "tintAmount":0.85,
            "particlesPerBurst":100,
            "shudderRangeMax":8,
            "shudderFrames":35,
            "flipSound":MCSound.KNOWLEDGE_REVEAL_CARD_RARE
         },
         MonkeyKnowledge.LEGENDARY.valueOf():{
            "leadinClass":LEGENDARY_LEADIN_CLASS,
            "postFlipClass":LEGENDARY_POST_FLIP_CLASS,
            "collectClass":LEGENDARY_COLLECT_CLASS,
            "color":16764718,
            "tintAmount":0.85,
            "particlesPerBurst":200,
            "shudderRangeMax":12,
            "shudderFrames":45,
            "flipSound":MCSound.KNOWLEDGE_REVEAL_CARD_LEGENDARY
         },
         MonkeyKnowledgeCard.BOUNTY_CARD.valueOf():{
            "leadinClass":BOUNTY_LEADIN_CLASS,
            "postFlipClass":BOUNTY_POST_FLIP_CLASS,
            "collectClass":BOUNTY_POST_FLIP_CLASS,
            "color":39423,
            "tintAmount":0.85,
            "particlesPerBurst":200,
            "shudderRangeMax":12,
            "shudderFrames":45,
            "flipSound":MCSound.BOUNTY_FLIPPED
         },
         KnowledgeBounty.BOUNTY_SECRET_TYPE.valueOf():{
            "leadinClass":BOUNTY_SECRET_LEADIN_CLASS,
            "postFlipClass":BOUNTY_SECRET_POST_FLIP_CLASS,
            "collectClass":BOUNTY_SECRET_POST_FLIP_CLASS,
            "color":6183,
            "tintAmount":0.99,
            "particlesPerBurst":250,
            "shudderRangeMax":16,
            "shudderFrames":MonkeyKnowledgeSecretCardAnimationController.SHUDDER_OUT_FRAMES,
            "flipSound":MCSound.SECRET_FLIPPED
         }
      };
      
      public static const CARD_WIDTH:int = 121;
      
      public static const CARD_HEIGHT:int = 167;
       
      
      private var _loopingSounds:Vector.<SoundInstance>;
      
      var _secretCrackle:BountySecretLightningLoop;
      
      public var token:MonkeyKnowledgeToken;
      
      var _cardContainer:Sprite;
      
      var _behindCardContainer:Sprite;
      
      var _back:KnowledgeCardBack;
      
      var _front:KnowledgeCardFront;
      
      var _side:KnowledgeCardSide;
      
      var _flipButton:ButtonControllerBase;
      
      const DisplayUtil:LGDisplayListUtil = LGDisplayListUtil.getInstance();
      
      var _colorTransform:ColorTransform;
      
      public var hasBeenTransmuted:Boolean = false;
      
      public var isFlipped:Boolean = false;
      
      private var _tweens:Array;
      
      var secretAnimation:MonkeyKnowledgeSecretCardAnimationController;
      
      public var hasBeenReleased:Boolean;
      
      public function MonkeyKnowledgeCard(param1:MonkeyKnowledgeToken)
      {
         this._loopingSounds = new Vector.<SoundInstance>();
         this._cardContainer = new Sprite();
         this._behindCardContainer = new Sprite();
         this._back = new KnowledgeCardBack();
         this._front = new KnowledgeCardFront();
         this._side = new KnowledgeCardSide();
         this._flipButton = new ButtonControllerBase(this._back);
         this._colorTransform = new ColorTransform();
         this._tweens = [];
         super();
         this.token = param1;
         this.buildView();
      }
      
      function buildView() : void
      {
         var that:MonkeyKnowledgeCard = null;
         addChild(this._behindCardContainer);
         addChild(this._cardContainer);
         this._cardContainer.addChild(this._back);
         this._cardContainer.useHandCursor = true;
         this._front.gotoAndStop(0);
         that = this;
         this._flipButton.setClickFunction(function onFlipClicked():void
         {
            _flipButton.destroy();
            if(that.parent)
            {
               that.parent.addChild(that);
            }
            isFlipped = true;
            onClickedShake();
            preFlipShudder();
            spawnLeadin();
            cardFirstClicked.dispatch(token.type);
            playFlipSound();
         });
         var pathDefinition:MonkeyKnowledgePathDefinition = MonkeyKnowledgeBuffData.getInstance().getPathDefinition(this.token.type);
         if(this.DisplayUtil.hasLabel(this._front.cardTitle,this.token.type))
         {
            this._front.cardTitle.gotoAndStop(this.token.type);
         }
         else
         {
            this._front.cardTitle.visible = false;
         }
         var avatarClass:Class = MonkeyKnowledgePortraitData.getClassByToken(this.token);
         var avatar:MovieClip = new avatarClass();
         this._front.portraitContainer.addChild(avatar);
         if(avatar.above)
         {
            this._front.portraitContainerAbove.addChild(avatar.above);
         }
         avatar.x = this._front.portraitContainer.placeholder.x;
         avatar.y = this._front.portraitContainer.placeholder.y;
         this._front.portraitContainer.removeChild(this._front.portraitContainer.placeholder);
         this._front.portraitContainerAbove.removeChild(this._front.portraitContainerAbove.placeholder);
         this._front.portraitContainerAbove.mask = this._front.maskAboveLayer;
         this._front.rarityTitle.gotoAndStop(this.token.quality);
         this._front.backgroundColor.gotoAndStop(this.token.quality);
         this._front.banner.gotoAndStop(this.token.quality);
         this._front.aztecLines.gotoAndStop(this.token.quality);
         this._front.aztecLines.mask = this._front.diagonalMask;
         this._front.pointsDisplay.textField.text = this.token.points;
         this._front.addEventListener(MouseEvent.CLICK,this.onClick);
         this._front.mouseEnabled = false;
         this._front.mouseChildren = false;
         this._front.useHandCursor = true;
         this._front.buttonMode = true;
         this._front.descriptionField.htmlText = "";
         if(this.token.type === BOUNTY_CARD)
         {
            this.setupBountyCard();
         }
      }
      
      function setupBountyCard() : void
      {
         this._front.pointsDisplay.visible = false;
         this._front.dropdownValueBackground.visible = false;
      }
      
      function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         this._front.removeEventListener(MouseEvent.CLICK,this.onClick);
         if(this.token.type == MonkeyKnowledgeCard.WILDCARD)
         {
            this._tweens.push(TweenLite.to(this,0.5,{
               "x":400,
               "y":100,
               "onComplete":function():void
               {
                  visible = false;
               }
            }));
            requestAssignWildcardSignal.dispatch(this);
         }
         else if(this.token.type == MonkeyKnowledgeCard.BOUNTY_CARD)
         {
            if(this.token.subType == MonkeyKnowledgeCard.BOUNTY_SECRET_CARD)
            {
               this.activateSecret();
            }
            else
            {
               this.poof();
               MCSound.getInstance().playSound(MCSound.KNOWLEDGE_CARD_POOF);
               cardTransmutedSignal.dispatch(this.token);
               this.dispatchBountyUIUpdateSignal();
            }
         }
         else
         {
            this.transmuteCard();
         }
      }
      
      function dispatchBountyUIUpdateSignal() : void
      {
         var _loc1_:Awarder = KnowledgeBounty.getAwarderByID(this.token.subType);
         _loc1_.dispatchUISyncSignal();
      }
      
      function onClickedShake() : void
      {
         var scaleTo:Number = 1.2;
         this._tweens.push(TweenLite.to(this._cardContainer,0,{
            "useFrames":true,
            "scaleX":scaleTo,
            "scaleY":scaleTo,
            "ease":Cubic.easeOut,
            "onComplete":function onComplete():void
            {
               _tweens.push(TweenLite.to(_cardContainer,10,{
                  "useFrames":true,
                  "scaleX":1,
                  "scaleY":1,
                  "ease":Cubic.easeIn
               }));
            }
         }));
         this.spawnFlashForward();
      }
      
      function simpleShudder() : void
      {
         var rangeObject:Object = null;
         var rangeMax:Number = this.shudderRangeMax;
         rangeObject = {"range":0};
         this._tweens.push(TweenLite.to(rangeObject,this.shudderFrames,{
            "useFrames":true,
            "range":rangeMax,
            "onUpdate":function onUpdate():void
            {
               if(_cardContainer == null)
               {
                  return;
               }
               var _loc1_:* = Math.random() * 99999;
               _cardContainer.x = Math.sin(_loc1_) * rangeObject.range;
               _cardContainer.y = Math.cos(_loc1_) * rangeObject.range;
            },
            "ease":Cubic.easeIn
         }));
      }
      
      function preFlipShudder() : void
      {
         var rangeObject:Object = null;
         var rangeMax:Number = this.shudderRangeMax;
         rangeObject = {"range":0};
         this._tweens.push(TweenLite.to(rangeObject,this.shudderFrames,{
            "useFrames":true,
            "range":rangeMax,
            "onUpdate":function onUpdate():void
            {
               var _loc1_:* = Math.random() * 99999;
               _cardContainer.x = Math.sin(_loc1_) * rangeObject.range;
               _cardContainer.y = Math.cos(_loc1_) * rangeObject.range;
            },
            "onComplete":function onComplete():void
            {
               startFlip();
               shudderOut();
            },
            "ease":Cubic.easeIn
         }));
         var tint:uint = sfxData[this.token.quality].color;
         this._tweens.push(TweenLite.to(this._back,this.shudderFrames,{
            "useFrames":true,
            "colorTransform":{
               "tint":tint,
               "tintAmount":sfxData[this.token.quality].tintAmount
            },
            "ease":Cubic.easeIn
         }));
      }
      
      function shudderOut() : void
      {
         var rangeObject:Object = null;
         rangeObject = {"range":this.shudderRangeMax};
         with({})
         {
            
            onComplete = function():void
            {
               _cardContainer.x = 0;
               _cardContainer.y = 0;
            };
         }
         this._tweens.push(TweenLite.to(rangeObject,flipTime,{
            "range":0,
            "onUpdate":function onUpdate():void
            {
               var _loc1_:* = Math.random() * 99999;
               _cardContainer.x = Math.sin(_loc1_) * rangeObject.range;
               _cardContainer.y = Math.cos(_loc1_) * rangeObject.range;
            },
            "onComplete":function():void
            {
               _cardContainer.x = 0;
               _cardContainer.y = 0;
            },
            "ease":Cubic.easeOut
         }));
         this._front.transform.colorTransform = new ColorTransform(1,1,1,1,255,255,255,0);
         this._tweens.push(TweenLite.to(this._front,10,{
            "colorTransform":{
               "tint":16777215,
               "tintAmount":0
            },
            "ease":Cubic.easeIn,
            "useFrames":true
         }));
      }
      
      public function spawnLeadin() : void
      {
         var data:Object = null;
         data = sfxData[this.token.quality];
         this._tweens.push(TweenLite.delayedCall(this.shudderFrames - data.leadinFrames,function():void
         {
            var _loc1_:* = new data.leadinClass();
            _cardContainer.addChild(_loc1_);
         },null,true));
      }
      
      function spawnCashSpam() : void
      {
         var _loc1_:AltCashSpam = new AltCashSpam();
         _loc1_.x = this.x;
         _loc1_.y = this.y;
         _loc1_.rewardCash.xpAmount.text = "$" + this.token.points * 100;
         this.parent.addChild(_loc1_);
      }
      
      public function spawnSFX() : void
      {
         var _loc1_:MovieClip = new CommonPackOpenSFX();
         this._cardContainer.addChild(_loc1_);
      }
      
      public function spawnFlashForward() : void
      {
         var _loc1_:FlashForwardClip = new FlashForwardClip();
         this._cardContainer.addChild(_loc1_);
      }
      
      public function spawnPostFlipAnimation() : void
      {
         var _loc1_:Object = sfxData[this.token.quality];
         var _loc2_:MovieClip = new _loc1_.postFlipClass();
         _loc2_.mouseEnabled = false;
         _loc2_.mouseChildren = false;
         this._cardContainer.addChild(_loc2_);
      }
      
      public function spawnCollectAnimation() : void
      {
         var _loc1_:Object = sfxData[this.token.quality];
         var _loc2_:MovieClip = new _loc1_.collectClass();
         this._cardContainer.addChild(_loc2_);
      }
      
      public function startFlip() : void
      {
         this._back.scaleX = 1;
         this._tweens.push(TweenLite.to(this._back,flipTime * 0.5,{
            "scaleX":0.1,
            "ease":Quart.easeIn,
            "onComplete":this.showCardSide
         }));
         cardFlipBegin.dispatch(this.token.type);
      }
      
      public function showCardSide() : void
      {
         this._cardContainer.removeChild(this._back);
         this._cardContainer.addChild(this._side);
         this._tweens.push(TweenLite.to(this._front,1,{
            "useFrames":true,
            "onComplete":this.showCardFront
         }));
      }
      
      public function showCardFront() : void
      {
         this._front.gotoAndStop(0);
         this._cardContainer.removeChild(this._side);
         this._cardContainer.addChild(this._front);
         this._front.scaleX = 0.1;
         this._tweens.push(TweenLite.to(this._front,flipTime * 0.5,{
            "scaleX":1,
            "onComplete":this.onFlipComplete,
            "ease":Quart.easeOut
         }));
      }
      
      function onFlipComplete() : void
      {
         this._front.gotoAndPlay(1);
         this._front.dropdownValueBackground.gotoAndPlay(1);
         this._front.maskAboveLayer.gotoAndPlay(1);
         this._front.diagonalMask.gotoAndPlay(1);
         this._front.addEventListener(Event.COMPLETE,this.frontCardAnimationComplete);
         cardFlipComplete.dispatch(this.token.type);
         this.spawnPostFlipAnimation();
         this._tweens.push(TweenLite.delayedCall(10,function():void
         {
            if(_front === null)
            {
               return;
            }
            _front.mouseEnabled = true;
            _front.useHandCursor = true;
            _front.descriptionField.text = KnowledgeBounty.getDescriptionByID(token.subType);
            if(token.subType === BOUNTY_SECRET_CARD)
            {
               _secretCrackle = new BountySecretLightningLoop();
               _front.addChild(_secretCrackle);
            }
         },null,true));
      }
      
      function transmuteCard() : void
      {
         this.spawnCollectAnimation();
         this._front.visible = false;
         var _loc1_:int = MonkeyKnowledgeTree.getInstance().getRank(this.token.type);
         if(this.token.subType === BOUNTY_SECRET_CARD)
         {
            this.showSecretDustBurst();
         }
         else if(_loc1_ < MonkeyKnowledge.MAX_RANK)
         {
            this.showDustBurst();
         }
         else
         {
            this.poof();
            this.spawnCashSpam();
            this.giveAltCashReward();
         }
         cardTransmutedSignal.dispatch(this.token);
         this.hasBeenTransmuted = true;
         this.clearLoopingSounds();
      }
      
      public function clearLoopingSounds() : void
      {
         var _loc2_:SoundInstance = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._loopingSounds.length)
         {
            _loc2_ = this._loopingSounds[_loc1_];
            _loc2_.stop();
            _loc1_++;
         }
         this._loopingSounds.length = 0;
      }
      
      function giveAltCashReward() : void
      {
         ResourceStore.getInstance().monkeyMoney = ResourceStore.getInstance().monkeyMoney + this.token.points * 100;
      }
      
      function release() : void
      {
         if(this.hasBeenReleased)
         {
            return;
         }
         this.hasBeenReleased = true;
         this.killTweens();
         this._front.visible = false;
         this._front.removeChildren();
         this._back.removeChildren();
         this._front = null;
         this._back = null;
         this._cardContainer = null;
         this._side.removeChildren();
         this._side = null;
         this._flipButton = null;
         this._colorTransform = null;
         this.clearLoopingSounds();
      }
      
      private function killTweens() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._tweens.length)
         {
            this._tweens[_loc1_].kill();
            _loc1_++;
         }
         this._tweens.length = 0;
      }
      
      public function poof() : void
      {
         this.spawnCollectAnimation();
         showPoofSignal.dispatch(this);
         this.hasBeenTransmuted = true;
         this.release();
      }
      
      public function activateSecret() : void
      {
         this.secretAnimation = new MonkeyKnowledgeSecretCardAnimationController(this);
         this.secretAnimation.start();
      }
      
      function showDustBurst() : void
      {
         showDustBurstSignal.dispatch(this);
      }
      
      function showSecretDustBurst() : void
      {
         showSecretDustBurstSignal.dispatch(this);
      }
      
      function frontCardAnimationComplete(param1:Event) : void
      {
      }
      
      public function get particlesPerBurst() : int
      {
         var _loc1_:Object = sfxData[this.token.quality];
         if(_loc1_ !== null)
         {
            return _loc1_.particlesPerBurst;
         }
         return 50;
      }
      
      function get shudderRangeMax() : Number
      {
         var _loc1_:Object = sfxData[this.token.quality];
         if(_loc1_ !== null)
         {
            return _loc1_.shudderRangeMax;
         }
         return 8;
      }
      
      function get shudderFrames() : Number
      {
         var _loc1_:Object = sfxData[this.token.quality];
         if(_loc1_ !== null)
         {
            return _loc1_.shudderFrames;
         }
         return 45;
      }
      
      function playFlipSound() : void
      {
         var _loc2_:SoundInstance = null;
         var _loc1_:Object = sfxData[this.token.quality];
         if(_loc1_ !== null)
         {
            MCSound.getInstance().playSound(_loc1_.flipSound,0.6);
         }
         if(this.token.subType == BOUNTY_SECRET_CARD)
         {
            _loc2_ = MCSound.getInstance().playSound(MCSound.SECRET_CRACKLE_LOOP,1,true);
            if(_loc2_ !== null)
            {
               this._loopingSounds.push(_loc2_);
            }
         }
      }
      
      public function getCardRect() : Rectangle
      {
         return new Rectangle(x - CARD_WIDTH * 0.5,y - CARD_HEIGHT * 0.5,CARD_WIDTH,CARD_HEIGHT);
      }
   }
}
