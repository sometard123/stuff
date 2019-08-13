package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.KnowledgeTestPanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeBuffData;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePath;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePathDefinition;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgeTree;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class MonkeyKnowledgeTestPanel extends HideRevealView
   {
       
      
      private var _clip:KnowledgeTestPanelClip;
      
      private var _contentContainer:Sprite;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _resetButton:ButtonControllerBase;
      
      private var _knowledgeTree:MonkeyKnowledgeTree;
      
      private var _buffData:MonkeyKnowledgeBuffData;
      
      private var _boxes:Vector.<TestPanelInfoBox>;
      
      public function MonkeyKnowledgeTestPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new KnowledgeTestPanelClip();
         this._contentContainer = new Sprite();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._resetButton = new ButtonControllerBase(this._clip.resetButton);
         this._knowledgeTree = MonkeyKnowledgeTree.getInstance();
         this._buffData = MonkeyKnowledgeBuffData.getInstance();
         this._boxes = new Vector.<TestPanelInfoBox>();
         super(param1,param2);
         this.build();
         isModal = true;
         this._closeButton.setClickFunction(hide);
         this._resetButton.setClickFunction(this.resetAll);
      }
      
      private function resetAll() : void
      {
         MonkeyKnowledgeTree.getInstance().resetAndSave();
         this.syncAll();
      }
      
      private function build() : void
      {
         var _loc1_:Vector.<MonkeyKnowledgePath> = null;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:MonkeyKnowledgePath = null;
         var _loc11_:MonkeyKnowledgePathDefinition = null;
         var _loc12_:TestPanelInfoBox = null;
         addChild(this._clip);
         addChild(this._contentContainer);
         this._contentContainer.x = this._clip.contentArea.x;
         this._contentContainer.y = this._clip.contentArea.y;
         this._clip.contentArea.visible = false;
         _loc1_ = this._knowledgeTree.allPaths;
         var _loc2_:int = 3;
         var _loc3_:int = 320;
         _loc4_ = 50;
         var _loc5_:int = Math.ceil(_loc1_.length * 0.5);
         this._contentContainer.mask = this._clip.contentMask;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         while(_loc7_ < 2)
         {
            _loc8_ = _loc7_ * _loc3_;
            _loc9_ = 0;
            while(_loc9_ < _loc5_)
            {
               _loc10_ = _loc1_[_loc6_];
               _loc11_ = this._buffData.getPathDefinition(_loc10_.id);
               _loc12_ = new TestPanelInfoBox(_loc10_,_loc11_);
               _loc12_.x = _loc8_;
               _loc12_.y = Math.floor(_loc9_ * _loc4_);
               this._contentContainer.addChild(_loc12_);
               this._boxes.push(_loc12_);
               _loc6_++;
               if(_loc6_ >= _loc1_.length)
               {
                  break;
               }
               _loc9_++;
            }
            _loc7_++;
         }
         this._clip.scrollBar.visible = false;
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         this.syncAll();
      }
      
      private function syncAll() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._boxes.length)
         {
            this._boxes[_loc1_].sync();
            _loc1_++;
         }
      }
   }
}
