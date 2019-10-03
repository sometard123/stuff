package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.KnowledgeInfoBook;
   import com.greensock.TweenLite;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeBuffData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePath;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePathDefinition;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePortraitData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeToken;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeTree;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.utils.Flatten;
   import org.osflash.signals.Signal;
   
   public class MonkeyKnowledgePathInfoBox extends Sprite
   {
      
      public static const clickedSignal:Signal = new Signal(MonkeyKnowledgePathInfoBox);
       
      
      private var _pathDefinition:MonkeyKnowledgePathDefinition = null;
      
      private var _path:MonkeyKnowledgePath = null;
      
      private var _clip:KnowledgeInfoBook;
      
      private var _buttonController:ButtonControllerBase;
      
      private var _buffData:MonkeyKnowledgeBuffData;
      
      private var _progressClip:MovieClip;
      
      private var _progressTweenTime:Number = 0.8;
      
      private var _mkTree:MonkeyKnowledgeTree;
      
      private var _assignXPGlowVisible:Boolean;
      
      private const DisplayUtil:LGDisplayListUtil = LGDisplayListUtil.getInstance();
      
      public function MonkeyKnowledgePathInfoBox(param1:MonkeyKnowledgePathDefinition, param2:MonkeyKnowledgePath, param3:KnowledgeInfoBook = null)
      {
         this._buffData = MonkeyKnowledgeBuffData.getInstance();
         this._mkTree = MonkeyKnowledgeTree.getInstance();
         super();
         if(this._clip == null)
         {
            this._clip = new KnowledgeInfoBook();
            addChild(this._clip);
         }
         else
         {
            this._clip = param3;
         }
         this._clip.assignXPGlow.visible = false;
         this._pathDefinition = param1;
         this._path = param2;
         this._buttonController = new ButtonControllerBase(this._clip);
         this._buttonController.setClickFunction(this.onClicked);
         this._clip.bookStates.gotoAndStop(1);
         this._path.changedSignal.add(this.syncToPath);
         this._progressClip = this._clip.progressBar.barInner;
         this.syncToPath(this._path);
      }
      
      private function onClicked() : void
      {
         clickedSignal.dispatch(this);
      }
      
      public function syncToPath(param1:MonkeyKnowledgePath = null) : void
      {
         if(param1 === null)
         {
            param1 = this._path;
         }
         if(this.DisplayUtil.hasLabel(this._clip.titleClip,param1.id))
         {
            this._clip.titleClip.gotoAndStop(param1.id);
         }
         else
         {
            this._clip.titleClip.gotoAndStop(0);
         }
         this._clip.rankNumberClip.rankTextField.text = param1.displayRank;
         this._clip.progressBar.barInner.scaleX = param1.displayRankProgress;
         var _loc2_:Class = MonkeyKnowledgePortraitData.getClass(param1.id,MonkeyKnowledge.COMMON);
         var _loc3_:MovieClip = new _loc2_();
         _loc3_.scaleX = _loc3_.scaleY = 0.8;
         _loc3_.y = 5;
         Flatten.flatten(_loc3_);
         this._clip.avatar.removeChildren();
         this._clip.avatar.addChild(_loc3_);
         this.syncTabs();
      }
      
      public function onCardTransmuted(param1:MonkeyKnowledgeToken, param2:String) : void
      {
         var path:MonkeyKnowledgePath = null;
         var token:MonkeyKnowledgeToken = param1;
         var pathID:String = param2;
         var id:String = pathID;
         path = this._mkTree.getPath(id);
         var pathBeforeUpdate:MonkeyKnowledgePath = path.clone();
         path.displayPoints = path.displayPoints + token.points;
         var flashDelay:Number = 0.3;
         TweenLite.delayedCall(flashDelay,function():void
         {
            DustBurst.reachedTargetSignal.add(onParticleReachedTarget);
         });
         TweenLite.delayedCall(flashDelay + this._progressTweenTime,function():void
         {
            DustBurst.reachedTargetSignal.remove(onParticleReachedTarget);
         });
         this.syncToPath(pathBeforeUpdate);
         if(path.displayRank > pathBeforeUpdate.displayRank)
         {
            with({})
            {
               
               onComplete = function():void
               {
                  TownUI.getInstance().monkeyKnowledgeLevelUpPopup.syncToPath(path);
                  TownUI.getInstance().monkeyKnowledgeLevelUpPopup.reveal();
                  _clip.rankNumberClip.rankTextField.text = path.displayRank;
                  _progressClip.scaleX = 0;
                  TweenLite.to(_progressClip,_progressTweenTime * 0.5,{"scaleX":path.displayRankProgress});
               };
            }
            TweenLite.to(this._progressClip,this._progressTweenTime * 0.5,{
               "scaleX":1,
               "delay":0.5,
               "onComplete":function():void
               {
                  TownUI.getInstance().monkeyKnowledgeLevelUpPopup.syncToPath(path);
                  TownUI.getInstance().monkeyKnowledgeLevelUpPopup.reveal();
                  _clip.rankNumberClip.rankTextField.text = path.displayRank;
                  _progressClip.scaleX = 0;
                  TweenLite.to(_progressClip,_progressTweenTime * 0.5,{"scaleX":path.displayRankProgress});
               }
            });
         }
         else
         {
            TweenLite.to(this._progressClip,this._progressTweenTime,{
               "scaleX":path.displayRankProgress,
               "delay":0.5
            });
         }
      }
      
      public function getXPDropTarget() : Point
      {
         return new Point(this.x + this._clip.progressBar.x,this.y + this._clip.progressBar.y);
      }
      
      private function onParticleReachedTarget() : void
      {
         this._progressClip.gotoAndPlay(2);
      }
      
      private function syncTabs() : void
      {
         this._clip.bookStates.gotoAndStop(1);
         if(this._path.rank > 5)
         {
            this._clip.bookStates.gotoAndStop(2);
         }
         if(this._path.rank > 10)
         {
            this._clip.bookStates.gotoAndStop(3);
         }
      }
      
      public function get path() : MonkeyKnowledgePath
      {
         return this._path;
      }
      
      public function get assignXPGlowVisible() : Boolean
      {
         return this._assignXPGlowVisible;
      }
      
      public function set assignXPGlowVisible(param1:Boolean) : void
      {
         this._assignXPGlowVisible = param1;
         this._clip.assignXPGlow.visible = param1;
      }
   }
}
