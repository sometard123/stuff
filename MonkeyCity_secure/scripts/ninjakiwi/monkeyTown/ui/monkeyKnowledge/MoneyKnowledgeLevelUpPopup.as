package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.MonkeyKnowledgeLevelUpPopupClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeBuffData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePath;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePathDefinition;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePortraitData;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class MoneyKnowledgeLevelUpPopup extends HideRevealView
   {
       
      
      private var _clip:MonkeyKnowledgeLevelUpPopupClip;
      
      private var _okButton:ButtonControllerBase;
      
      private var _buffData:MonkeyKnowledgeBuffData;
      
      public function MoneyKnowledgeLevelUpPopup(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new MonkeyKnowledgeLevelUpPopupClip();
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         this._buffData = MonkeyKnowledgeBuffData.getInstance();
         super(param1,param2);
         this.init();
      }
      
      private function init() : void
      {
         enableDefaultOnResize(this._clip);
         addChild(this._clip);
         this._okButton.setClickFunction(hide);
      }
      
      public function syncToPath(param1:MonkeyKnowledgePath) : void
      {
         var _loc2_:MonkeyKnowledgePathDefinition = this._buffData.getPathDefinition(param1.id);
         this._clip.eventDescriptionField.htmlText = _loc2_.name.toUpperCase() + "<br/>is now Rank " + param1.displayRank;
         this.syncCurrentRank(param1.displayRank,param1.id);
         this.syncNextRank(param1.displayRank + 1,param1.id);
         var _loc3_:Class = MonkeyKnowledgePortraitData.getClass(param1.id,MonkeyKnowledge.COMMON);
         var _loc4_:MovieClip = new _loc3_();
         this._clip.avatar.removeChildren();
         this._clip.avatar.addChild(_loc4_);
      }
      
      private function syncCurrentRank(param1:int, param2:String) : void
      {
         this._clip.currentRankDescriptionField.text = this._buffData.getPathDefinition(param2).getRankDescription(param1);
      }
      
      private function syncNextRank(param1:int, param2:String) : void
      {
         if(param1 <= 15)
         {
            this._clip.nextRankTitleField.text = "Next Rank: " + param1.toString();
            this._clip.nextRankDescriptionField.text = this._buffData.getPathDefinition(param2).getRankDescription(param1);
         }
         else
         {
            this._clip.nextRankTitleField.text = "Next Rank:";
            this._clip.nextRankDescriptionField.text = "Maximum rank achieved!";
         }
      }
   }
}
