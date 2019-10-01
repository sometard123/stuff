package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.MonkeyKnowledgeOpenPackAnimation;
   import assets.ui.MonkeyKnowledgeOpenPacksScreenClip;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePath;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeTree;
   import ninjakiwi.monkeyTown.monkeyKnowledge.UnopenedPack;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class MonkeyKnowledgeOpenPacksScreen extends HideRevealView
   {
      
      private static const PACK_Y_SPACING:int = 85;
      
      public static var instance:MonkeyKnowledgeOpenPacksScreen = null;
       
      
      private var _clip:MonkeyKnowledgeOpenPacksScreenClip;
      
      private var _openPackAnimation:MonkeyKnowledgeOpenPackAnimation;
      
      private var _buyPacksButton:ButtonControllerBase;
      
      private var _makePackButton:ButtonControllerBase;
      
      private var _cheatButton:ButtonControllerBase;
      
      private var _floatingButtons:MovieClip;
      
      private var _openPackButton:ButtonControllerBase;
      
      private var _openAncientPackButton:ButtonControllerBase;
      
      private var _openWildcardPackButton:ButtonControllerBase;
      
      private var _knowledgePanelOpenButton:ButtonControllerBase;
      
      private var _centerScreen:Point;
      
      private var _packExplosionContainer:Sprite;
      
      private const DisplayUtil:LGDisplayListUtil = LGDisplayListUtil.getInstance();
      
      private var _explodingBox:ExplodingBoxAnimation;
      
      private var _explodingBoxAncient:ExplodingBoxAnimation;
      
      private var _explodingBoxWild:ExplodingBoxAnimation;
      
      private var _testCheatsScreen:MonkeyKnowledgeTestPanel;
      
      private var _unopenedPack:UnopenedPack;
      
      private var _dustBurstEffects:DustBurstEffects;
      
      private var _knowledgeXpTarget:MonkeyKnowledgeXpTarget;
      
      private var _secretXPTarget:MonkeyKnowledgeSecretXPTarget;
      
      private var _tutorialPane:MonkeyKnowledgeTutorialPanel;
      
      private var _popupLayer:Sprite;
      
      private var _getMorePacksTip:MonkeyKnowlegeMorePacksTip;
      
      public var monkeyKnowledgePanel:MonkeyKnowledgePanel;
      
      private var _noPacksCheckTimeout:uint = 0;
      
      private var _packButtons:Array;
      
      private var _unFlippedCards:int = 0;
      
      private var _remainingCards:int = 0;
      
      private var _isOpeningPack:Boolean = false;
      
      public function MonkeyKnowledgeOpenPacksScreen(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new MonkeyKnowledgeOpenPacksScreenClip();
         this._openPackAnimation = new MonkeyKnowledgeOpenPackAnimation();
         this._buyPacksButton = new ButtonControllerBase(this._clip.buyPacksButton);
         this._makePackButton = new ButtonControllerBase(this._clip.getPackButton);
         this._cheatButton = new ButtonControllerBase(this._clip.cheatButton);
         this._floatingButtons = this._clip.floatingButtons;
         this._openPackButton = new ButtonControllerBase(this._clip.floatingButtons.openPackButton);
         this._openAncientPackButton = new ButtonControllerBase(this._clip.floatingButtons.openAncientPackButton);
         this._openWildcardPackButton = new ButtonControllerBase(this._clip.floatingButtons.openWildcardPackButton);
         this._knowledgePanelOpenButton = new ButtonControllerBase(this._clip.floatingButtons.knowledgePanelOpenButton);
         this._centerScreen = new Point(this._clip.centerScreenMarker.x,this._clip.centerScreenMarker.y);
         this._packExplosionContainer = new Sprite();
         this._explodingBox = new ExplodingBoxAnimation();
         this._explodingBoxAncient = new ExplodingBoxAnimation(MonkeyKnowledgePack.ANCIENT_PACK);
         this._explodingBoxWild = new ExplodingBoxAnimation(MonkeyKnowledgePack.WILDCARD_PACK);
         this._dustBurstEffects = new DustBurstEffects();
         this._knowledgeXpTarget = new MonkeyKnowledgeXpTarget(this._clip.knowledgeXpTarget);
         this._secretXPTarget = new MonkeyKnowledgeSecretXPTarget(this._clip.secretBookXpTarget);
         this._popupLayer = new Sprite();
         this._packButtons = [{
            "button":this._openPackButton,
            "dataKey":"unopenedPacks"
         },{
            "button":this._openAncientPackButton,
            "dataKey":"unopenedAncientPacks"
         },{
            "button":this._openWildcardPackButton,
            "dataKey":"unopenedWildcardPacks"
         }];
         super(param1,param2);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._openPackAnimation,false,true,true);
         this.init();
         instance = this;
         this._clip.removeChild(this._clip.getPackButton);
         this._clip.removeChild(this._clip.cheatButton);
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
      }
      
      private function init() : void
      {
         addChild(this._clip);
         this.enableCloseButton(this._clip.closeButton);
         isModal = true;
         this._testCheatsScreen = new MonkeyKnowledgeTestPanel(this);
         this._clip.removeChild(this._clip.centerScreenMarker);
         this._clip.removeChild(this._clip.xpGoal);
         this._packExplosionContainer.x = this._centerScreen.x;
         this._packExplosionContainer.y = this._centerScreen.y;
         this._openPackButton.setClickFunction(function():void
         {
            openPack(MonkeyKnowledgePack.STANDARD_PACK);
         });
         this._openAncientPackButton.setClickFunction(function():void
         {
            openPack(MonkeyKnowledgePack.ANCIENT_PACK);
         });
         this._openWildcardPackButton.setClickFunction(function():void
         {
            openPack(MonkeyKnowledgePack.WILDCARD_PACK);
         });
         this._getMorePacksTip = new MonkeyKnowlegeMorePacksTip(this._clip);
         this._clip.addChild(this._packExplosionContainer);
         this._knowledgePanelOpenButton.setClickFunction(this.openKnowledgePanel);
         this._knowledgeXpTarget.knowledgeBookClickedSignal.add(this.onXPTargetBookClickedSignal);
         addChild(this._popupLayer);
         addChild(this._dustBurstEffects);
         this.monkeyKnowledgePanel = new MonkeyKnowledgePanel(this._popupLayer);
         MonkeyCityMain.globalResetSignal.add(this.onGlobalReset);
         MonkeyKnowledgeCard.showDustBurstSignal.add(this.showDustBurst);
         MonkeyKnowledgeCard.showSecretDustBurstSignal.add(this.showSecretDustBurst);
         MonkeyKnowledgeCard.showPoofSignal.add(this.showDustPoof);
         WildCardFront.showWildCardDustBurstSignal.add(this.showWildCardDustBurst);
         MonkeyKnowledgeCard.requestAssignWildcardSignal.add(this.onRequestAssignMonkeyKnowledgeCard);
         MonkeyKnowledgeCard.cardFirstClicked.add(this.onCardFirstClickedSignal);
         MonkeyKnowledgeCard.cardFlipComplete.add(this.onCardFlippedSignal);
         MonkeyKnowledgeCard.cardTransmutedSignal.add(this.onCardTransmutedSignal);
         MonkeyKnowledgeCard.requestAssignWildcardSignal.add(this.onCardTransmutedSignal);
         MonkeyKnowledge.syncUIElementSignal.add(this.onSyncUIElementSignal);
         this._buyPacksButton.setClickFunction(this.openBuyPacksPanel);
      }
      
      private function onGlobalReset(... rest) : void
      {
         this.clear();
         this._clip.visible = true;
         this._clip.alpha = 1;
      }
      
      private function onCardTransmutedSignal(... rest) : void
      {
         _loc2_._remainingCards = _loc3_;
         if(this._remainingCards <= 0)
         {
            this._isOpeningPack = false;
            this.unlockPacksButtons();
            this.checkForNoPacksLeft();
         }
         this._knowledgeXpTarget.reSync();
      }
      
      private function openBuyPacksPanel() : void
      {
         PanelManager.getInstance().showFreePanel(TownUI.getInstance().knowledgePackSalePanel);
      }
      
      private function onCardFirstClickedSignal(... rest) : void
      {
      }
      
      private function onCardFlippedSignal(... rest) : void
      {
         _loc2_._unFlippedCards = _loc3_;
         if(this._unFlippedCards === 0)
         {
            if(this._unopenedPack.pack.packQuality === MonkeyKnowledgePack.WILDCARD_PACK)
            {
               this.unlockPacksButtons();
            }
         }
      }
      
      private function onXPTargetBookClickedSignal(param1:String) : void
      {
         var _loc2_:MonkeyKnowledgePath = MonkeyKnowledgeTree.getInstance().getPath(param1);
         this.sleep();
         TownUI.getInstance().monkeyKnowledgeInfoPanel.sync(_loc2_);
         TownUI.getInstance().monkeyKnowledgeInfoPanel.reveal();
         TownUI.getInstance().monkeyKnowledgeInfoPanel.hideStartSignal.addOnce(this.wake);
      }
      
      private function sleep(... rest) : void
      {
         this._clip.visible = false;
      }
      
      private function wake(... rest) : void
      {
         this._clip.visible = true;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this._dustBurstEffects.update();
      }
      
      private function onRequestAssignMonkeyKnowledgeCard(param1:MonkeyKnowledgeCard) : void
      {
         MonkeyKnowledgeTree.getInstance().placeWildcardOnTop(param1.token);
         param1.hasBeenTransmuted = true;
         this.openKnowledgePanel();
      }
      
      private function openKnowledgePanel() : void
      {
         this.monkeyKnowledgePanel.reveal();
         this.monkeyKnowledgePanel.closeSignal.addOnce(this.onChildPanelHide);
         TweenLite.to(this._clip,0.3,{
            "alpha":0,
            "onComplete":function():void
            {
               _clip.visible = false;
            }
         });
      }
      
      private function onChildPanelHide(... rest) : void
      {
         this._clip.visible = true;
         TweenLite.to(this._clip,0.3,{"alpha":1});
         this._knowledgeXpTarget.reSync();
      }
      
      private function clear() : void
      {
         this.DisplayUtil.removeAllChildren(this._packExplosionContainer);
         this._explodingBox.cancel();
         this._explodingBoxAncient.cancel();
         this._explodingBoxWild.cancel();
         if(this._unopenedPack !== null)
         {
            this._unopenedPack.cardSpread.destroyRemainingCards();
         }
         this._dustBurstEffects.clear();
         clearTimeout(this._noPacksCheckTimeout);
         this.showGetMorePacksTip(false);
         this._remainingCards = 0;
         this._isOpeningPack = false;
         this._knowledgeXpTarget.hide();
         this._secretXPTarget.hide();
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         var _loc2_:MKPTester = null;
         super.reveal(param1);
         this._isOpeningPack = false;
         this.clear();
         MonkeyCityMain.getInstance().worldView.ultraPause = true;
         this.syncToMonkeyKnowledge();
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         if(!MonkeyKnowledge.getInstance().hasSeenTutorial)
         {
            MonkeyKnowledge.getInstance().hasSeenTutorial = true;
            this._tutorialPane = new MonkeyKnowledgeTutorialPanel(this);
            this._tutorialPane.reveal();
         }
         this.showGetMorePacksTip();
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(param1);
         this.clear();
         MonkeyCityMain.getInstance().worldView.ultraPause = false;
      }
      
      private function addTestPack() : void
      {
         MonkeyKnowledge.getInstance().unopenedPacks++;
         MonkeyKnowledge.getInstance().unopenedAncientPacks++;
         MonkeyKnowledge.getInstance().unopenedWildcardPacks++;
         this.syncToMonkeyKnowledge();
      }
      
      private function onSyncUIElementSignal(param1:String, param2:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         switch(param1)
         {
            case MonkeyKnowledgePack.STANDARD_PACK_KEY:
               _loc3_ = parseInt(this._floatingButtons.openPackButton.gem.numberField.text);
               this._floatingButtons.openPackButton.gem.numberField.text = _loc3_ + int(param2);
               this._floatingButtons.openPackButton.gem.visible = true;
               break;
            case MonkeyKnowledgePack.ANCIENT_PACK_KEY:
               _loc4_ = parseInt(this._floatingButtons.openAncientPackButton.gem.numberField.text);
               this._floatingButtons.openAncientPackButton.gem.numberField.text = _loc4_ + int(param2);
               this._floatingButtons.openAncientPackButton.gem.visible = true;
               break;
            case MonkeyKnowledgePack.WILDCARD_PACK_KEY:
               _loc5_ = parseInt(this._floatingButtons.openWildcardPackButton.gem.numberField.text);
               this._floatingButtons.openWildcardPackButton.gem.numberField.text = _loc5_ + int(param2);
               this._floatingButtons.openWildcardPackButton.gem.visible = true;
         }
      }
      
      private function syncToMonkeyKnowledge(... rest) : void
      {
         var _loc2_:MonkeyKnowledgeTree = MonkeyKnowledgeTree.getInstance();
         _loc2_.syncDisplayData();
         var _loc3_:int = MonkeyKnowledge.getInstance().unopenedPacks;
         this._floatingButtons.openPackButton.gem.numberField.text = _loc3_;
         var _loc4_:int = MonkeyKnowledge.getInstance().unopenedAncientPacks;
         this._floatingButtons.openAncientPackButton.gem.numberField.text = _loc4_;
         var _loc5_:int = MonkeyKnowledge.getInstance().unopenedWildcardPacks;
         this._floatingButtons.openWildcardPackButton.gem.numberField.text = _loc5_;
         var _loc6_:int = _loc3_ + _loc4_ + _loc5_;
         if(_loc3_ < 1)
         {
            this._floatingButtons.openPackButton.gem.visible = false;
         }
         else
         {
            this._floatingButtons.openPackButton.gem.visible = true;
         }
         if(_loc4_ < 1)
         {
            this._floatingButtons.openAncientPackButton.gem.visible = false;
         }
         else
         {
            this._floatingButtons.openAncientPackButton.gem.visible = true;
         }
         if(_loc5_ < 1)
         {
            this._floatingButtons.openWildcardPackButton.gem.visible = false;
         }
         else
         {
            this._floatingButtons.openWildcardPackButton.gem.visible = true;
         }
         if(this._remainingCards < 1)
         {
            this.unlockPacksButtons();
         }
         this.checkForNoPacksLeft();
      }
      
      private function checkForNoPacksLeft() : void
      {
         if(this._isOpeningPack)
         {
            return;
         }
         var _loc1_:int = MonkeyKnowledge.getInstance().unopenedPacks;
         var _loc2_:int = MonkeyKnowledge.getInstance().unopenedAncientPacks;
         var _loc3_:int = MonkeyKnowledge.getInstance().unopenedWildcardPacks;
         var _loc4_:int = _loc1_ + _loc2_ + _loc3_;
         if(_loc4_ < 1)
         {
            this.showGetMorePacksTip();
         }
         else if(this._getMorePacksTip.isRevealed)
         {
            this.showGetMorePacksTip(false);
         }
      }
      
      private function showGetMorePacksTip(param1:Boolean = true) : void
      {
         if(true === param1)
         {
            this._getMorePacksTip.reveal();
            this._buyPacksButton.target.visible = false;
            this._buyPacksButton.target.alpha = 0;
         }
         else
         {
            this._getMorePacksTip.hide();
            this._buyPacksButton.target.visible = true;
            TweenLite.to(this._buyPacksButton.target,0.3,{"alpha":1});
         }
      }
      
      private function unlockPacksButtons() : void
      {
         var _loc2_:Object = null;
         var _loc3_:ButtonControllerBase = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this._packButtons.length)
         {
            _loc2_ = this._packButtons[_loc1_];
            _loc3_ = _loc2_.button;
            _loc4_ = MonkeyKnowledge.getInstance()[_loc2_.dataKey];
            if(_loc4_ == 0)
            {
               _loc3_.lock(3);
            }
            else
            {
               _loc3_.unlock(1);
            }
            _loc1_++;
         }
      }
      
      private function openPack(param1:int) : void
      {
         var _loc2_:ExplodingBoxAnimation = null;
         this._isOpeningPack = true;
         this.showGetMorePacksTip(false);
         if(this._unopenedPack !== null)
         {
            this._unopenedPack.cardSpread.dissolveRemainingCards();
         }
         this.DisplayUtil.removeAllChildren(this._packExplosionContainer);
         switch(param1)
         {
            case MonkeyKnowledgePack.ANCIENT_PACK:
               _loc2_ = this._explodingBoxAncient;
               MonkeyKnowledge.getInstance().unopenedAncientPacks--;
               break;
            case MonkeyKnowledgePack.WILDCARD_PACK:
               _loc2_ = this._explodingBoxWild;
               MonkeyKnowledge.getInstance().unopenedWildcardPacks--;
               break;
            default:
               _loc2_ = this._explodingBox;
               MonkeyKnowledge.getInstance().unopenedPacks--;
         }
         this.syncToMonkeyKnowledge();
         this._unopenedPack = new UnopenedPack(param1);
         this._unopenedPack.pack.award();
         this._packExplosionContainer.addChild(_loc2_);
         _loc2_.reveal();
         _loc2_.explodeSignal.addOnce(this.onBoxExplode);
         this._knowledgeXpTarget.hide();
         this._secretXPTarget.hide();
         this._openPackButton.lock(3);
         this._openAncientPackButton.lock(3);
         this._openWildcardPackButton.lock(3);
         MCSound.getInstance().playSound(MCSound.KNOWLEDGE_REVEAL_CHEST_OPEN_1);
         this._remainingCards = 4;
         this._unFlippedCards = 4;
      }
      
      private function onBoxExplode() : void
      {
         this._packExplosionContainer.addChild(this._unopenedPack.cardSpread);
         this._packExplosionContainer.addChild(this._explodingBox);
         this._unopenedPack.cardSpread.playSpreadAnimation();
      }
      
      private function playOpenPackAnimation() : void
      {
         this._openPackAnimation.x = Math.floor(stage.stageWidth / 2);
         this._openPackAnimation.y = Math.floor(stage.stageHeight / 2);
         this._clip.addChild(this._openPackAnimation);
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._openPackAnimation,true,true,true);
      }
      
      private function getCardRectangle(param1:MonkeyKnowledgeCard) : Rectangle
      {
         var _loc2_:Rectangle = param1.getCardRect();
         _loc2_.x = _loc2_.x + this._packExplosionContainer.x;
         _loc2_.y = _loc2_.y + this._packExplosionContainer.y;
         return _loc2_;
      }
      
      private function getWildCardRectangle(param1:WildCardFront) : Rectangle
      {
         var _loc2_:Rectangle = new Rectangle(param1.x - MonkeyKnowledgeCard.CARD_WIDTH * 0.5,param1.y - MonkeyKnowledgeCard.CARD_HEIGHT * 0.5 + param1.parent.parent.y,MonkeyKnowledgeCard.CARD_WIDTH,MonkeyKnowledgeCard.CARD_HEIGHT);
         return _loc2_;
      }
      
      private function showSecretDustBurst(param1:MonkeyKnowledgeCard) : void
      {
         this.showDustBurst(param1,"secret");
      }
      
      private function showDustBurst(param1:MonkeyKnowledgeCard, param2:String = "default") : void
      {
         var _loc3_:Rectangle = this.getCardRectangle(param1);
         this._dustBurstEffects.goal.x = this._clip.xpGoal.x;
         this._dustBurstEffects.goal.y = this._clip.xpGoal.y;
         MCSound.getInstance().playSound(MCSound.KNOWLEDGE_CARD_BURST);
         this._dustBurstEffects.go(_loc3_,param1.particlesPerBurst,DustBurst.GOAL_MODE_LOWER_LEFT_CORNER,param2);
      }
      
      private function showWildCardDustBurst(param1:WildCardFront) : void
      {
         var _loc2_:Rectangle = this.getWildCardRectangle(param1);
         this._dustBurstEffects.goal.x = MonkeyKnowledgePanel.xpGoal.x;
         this._dustBurstEffects.goal.y = MonkeyKnowledgePanel.xpGoal.y;
         MCSound.getInstance().playSound(MCSound.KNOWLEDGE_CARD_BURST);
         this._dustBurstEffects.go(_loc2_,param1.particlesPerBurst,DustBurst.GOAL_MODE_FREE);
      }
      
      private function showDustPoof(param1:MonkeyKnowledgeCard) : void
      {
         var _loc2_:Rectangle = this.getCardRectangle(param1);
         this._dustBurstEffects.poof(_loc2_,param1.particlesPerBurst);
      }
      
      public function isCardFlipped(param1:MonkeyKnowledgeToken) : Boolean
      {
         if(this._unopenedPack == null)
         {
            return false;
         }
         return this._unopenedPack.cardSpread.isCardFlipped(param1);
      }
      
      public function isCardTransmuted(param1:MonkeyKnowledgeToken) : Boolean
      {
         if(this._unopenedPack == null)
         {
            return true;
         }
         return this._unopenedPack.cardSpread.isCardTransmuted(param1);
      }
   }
}
