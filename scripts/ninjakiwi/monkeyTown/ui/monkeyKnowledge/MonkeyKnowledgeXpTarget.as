package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.KnowledgeInfoBook;
   import assets.ui.MonkeyKnowledgeXpTargetClip;
   import assets.ui.TravellingMerchantIconClip;
   import com.greensock.TweenLite;
   import com.greensock.easing.Back;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeBuffData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePath;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePortraitData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeTree;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class MonkeyKnowledgeXpTarget
   {
       
      
      private var _clip:MonkeyKnowledgeXpTargetClip;
      
      private var _book:KnowledgeInfoBook;
      
      private var _progressClip:MovieClip;
      
      private var _progressTweenTime:Number = 0.5;
      
      private var _mkTree:MonkeyKnowledgeTree;
      
      private var _currentPathID:String;
      
      private var _isRevealed:Boolean = true;
      
      private var _clipHomeY:int;
      
      private var _buffData:MonkeyKnowledgeBuffData;
      
      private var _bookButton:ButtonControllerBase;
      
      public const knowledgeBookClickedSignal:Signal = new Signal(String);
      
      private const DisplayUtil:LGDisplayListUtil = LGDisplayListUtil.getInstance();
      
      private var _path:MonkeyKnowledgePath = null;
      
      public function MonkeyKnowledgeXpTarget(param1:MonkeyKnowledgeXpTargetClip)
      {
         this._mkTree = MonkeyKnowledgeTree.getInstance();
         this._buffData = MonkeyKnowledgeBuffData.getInstance();
         super();
         this._clip = param1;
         this._clipHomeY = param1.y;
         this.init();
      }
      
      private function init() : void
      {
         this.DisplayUtil.setPlayStateOfAllChildMovieClips(this._clip,false,true,true);
         this._book = this._clip.book;
         this._book.assignXPGlow.visible = false;
         this._progressClip = this._clip.book.progressBar.barInner;
         this._bookButton = new ButtonControllerBase(this._book);
         this._bookButton.setClickFunction(this.onBookClicked);
         MonkeyKnowledgeCard.cardFlipComplete.add(this.onCardFlipComplete);
         MonkeyKnowledgeCard.cardTransmutedSignal.add(this.onCardTransmuted);
         DustBurst.reachedTargetSignal.add(this.onParticleReachedTarget);
         this.hide(0);
      }
      
      private function onBookClicked() : void
      {
         this.knowledgeBookClickedSignal.dispatch(this._currentPathID);
      }
      
      public function hide(param1:Number = 0.3) : void
      {
         var time:Number = param1;
         if(!this._isRevealed)
         {
            return;
         }
         var stageHeight:Number = MonkeySystem.getInstance().flashStage.stageHeight;
         this._isRevealed = false;
         TweenLite.to(this._clip,time,{
            "y":stageHeight + this._clip.height + 10,
            "ease":Back.easeIn,
            "onComplete":function():void
            {
               _clip.visible = false;
            }
         });
      }
      
      public function reveal(param1:Number = 0.3) : void
      {
         if(this._isRevealed)
         {
            return;
         }
         this._clip.visible = true;
         this._isRevealed = true;
         var _loc2_:Number = MonkeySystem.getInstance().flashStage.stageHeight;
         TweenLite.to(this._clip,param1,{
            "y":this._clipHomeY,
            "ease":Back.easeOut
         });
      }
      
      public function syncToPath(param1:MonkeyKnowledgePath) : void
      {
         if(param1.id == MonkeyKnowledgeCard.WILDCARD)
         {
            this.hide();
            return;
         }
         this._path = param1;
         this.reveal();
         if(this.DisplayUtil.hasLabel(this._book.titleClip,param1.id))
         {
            this._book.titleClip.gotoAndStop(param1.id);
         }
         else
         {
            this._book.titleClip.gotoAndStop(0);
         }
         if(param1.id !== this._currentPathID)
         {
            this.whiteBurst();
         }
         this._currentPathID = param1.id;
         this._book.rankNumberClip.rankTextField.text = param1.displayRank;
         this.syncNextRank(param1.displayRank + 1,param1.id);
         TweenLite.killTweensOf(this._progressClip);
         this._progressClip.scaleX = param1.displayRankProgress;
         var _loc2_:Class = MonkeyKnowledgePortraitData.getClass(param1.id,MonkeyKnowledge.COMMON);
         var _loc3_:MovieClip = new _loc2_();
         _loc3_.scaleY = _loc4_;
         _loc3_.scaleX = _loc4_;
         _loc3_.y = 5;
         this._book.avatar.removeChildren();
         this._book.avatar.addChild(_loc3_);
         this.syncTabs(param1);
      }
      
      public function reSync() : void
      {
         var _loc1_:MonkeyKnowledgePath = null;
         if(this._path !== null)
         {
            _loc1_ = this._mkTree.getPath(this._path.id);
            this.syncToPath(_loc1_);
         }
         else
         {
            this.hide();
         }
      }
      
      private function onParticleReachedTarget() : void
      {
         this._progressClip.gotoAndPlay(2);
      }
      
      private function syncNextRank(param1:int, param2:String) : void
      {
         if(param1 <= 15)
         {
            this._clip.nextRankField.text = param1.toString();
            this._clip.nextRankDescriptionField.text = this._buffData.getPathDefinition(param2).getRankDescription(param1);
         }
         else
         {
            this._clip.nextRankField.text = "!";
            this._clip.nextRankDescriptionField.text = "Maximum rank achieved!";
         }
      }
      
      private function syncTabs(param1:MonkeyKnowledgePath) : void
      {
         this._book.bookStates.gotoAndStop(1);
         if(param1.displayRank > 5)
         {
            this._book.bookStates.gotoAndStop(2);
         }
         if(param1.displayRank > 10)
         {
            this._book.bookStates.gotoAndStop(3);
         }
      }
      
      private function onCardFlipComplete(param1:String) : void
      {
         if(param1 == MonkeyKnowledgeCard.BOUNTY_CARD)
         {
            return;
         }
         var _loc2_:MonkeyKnowledgePath = this._mkTree.getPath(param1);
         this.syncToPath(_loc2_);
      }
      
      private function onCardTransmuted(param1:MonkeyKnowledgeToken) : void
      {
         var path:MonkeyKnowledgePath = null;
         var debugger:int = 0;
         var token:MonkeyKnowledgeToken = param1;
         if(token.type === MonkeyKnowledgeCard.BOUNTY_CARD)
         {
            if(token.subType === MonkeyKnowledgeCard.BOUNTY_SECRET_CARD)
            {
               this.hide();
            }
            return;
         }
         var id:String = token.type;
         path = this._mkTree.getPath(id);
         var pathBeforeUpdate:MonkeyKnowledgePath = path.clone();
         this._path = path;
         path.displayPoints = path.displayPoints + token.points;
         if(path.displayPoints > path.points)
         {
            debugger = 0;
         }
         this.syncToPath(pathBeforeUpdate);
         if(path.displayRank > pathBeforeUpdate.displayRank)
         {
            with({})
            {
               
               onComplete = function():void
               {
                  TownUI.getInstance().monkeyKnowledgeLevelUpPopup.syncToPath(path);
                  TownUI.getInstance().monkeyKnowledgeLevelUpPopup.reveal();
                  _book.rankNumberClip.rankTextField.text = path.displayRank;
                  _progressClip.scaleX = 0;
                  syncNextRank(path.displayRank + 1,path.id);
                  TweenLite.to(_progressClip,_progressTweenTime * 0.5,{"scaleX":path.displayRankProgress});
               };
            }
            TweenLite.to(this._progressClip,this._progressTweenTime * 0.5,{
               "scaleX":1,
               "delay":1,
               "onComplete":function():void
               {
                  TownUI.getInstance().monkeyKnowledgeLevelUpPopup.syncToPath(path);
                  TownUI.getInstance().monkeyKnowledgeLevelUpPopup.reveal();
                  _book.rankNumberClip.rankTextField.text = path.displayRank;
                  _progressClip.scaleX = 0;
                  syncNextRank(path.displayRank + 1,path.id);
                  TweenLite.to(_progressClip,_progressTweenTime * 0.5,{"scaleX":path.displayRankProgress});
               }
            });
         }
         else
         {
            TweenLite.to(this._progressClip,this._progressTweenTime,{
               "scaleX":path.displayRankProgress,
               "delay":1
            });
         }
      }
      
      private function whiteBurst() : void
      {
         var values:Object = null;
         values = {"intensity":255};
         var onUpdate:Function = function():void
         {
            var _loc1_:ColorTransform = new ColorTransform(1,1,1,1,values.intensity,values.intensity,values.intensity,0);
            _clip.transform.colorTransform = _loc1_;
         };
         var fadeDownTime:Number = 0.5;
         TweenLite.to(values,fadeDownTime,{
            "intensity":0,
            "onUpdate":onUpdate
         });
      }
   }
}
