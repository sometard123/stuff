package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import assets.ui.KnowledgeTestInfoBox;
   import flash.display.Sprite;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePath;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePathDefinition;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class TestPanelInfoBox extends Sprite
   {
       
      
      private var _clip:KnowledgeTestInfoBox;
      
      private var _path:MonkeyKnowledgePath;
      
      private var _minusButton:ButtonControllerBase;
      
      private var _plusButton:ButtonControllerBase;
      
      private var _definition:MonkeyKnowledgePathDefinition;
      
      public function TestPanelInfoBox(param1:MonkeyKnowledgePath, param2:MonkeyKnowledgePathDefinition)
      {
         this._clip = new KnowledgeTestInfoBox();
         super();
         addChild(this._clip);
         this._path = param1;
         this._definition = param2;
         this._clip.title;
         this._minusButton = new ButtonControllerBase(this._clip.minusButton);
         this._plusButton = new ButtonControllerBase(this._clip.plusButton);
         this._minusButton.setClickFunction(this.reduceRank);
         this._plusButton.setClickFunction(this.increaseRank);
         this._clip.title.text = this._definition.name;
         this.sync();
      }
      
      private function reduceRank() : void
      {
         this._path.setRank(this._path.rank - 1);
         this.sync();
      }
      
      private function increaseRank() : void
      {
         this._path.setRank(this._path.rank + 1);
         this.sync();
      }
      
      public function sync() : void
      {
         this._clip.rankTextField.text = this._path.rank.toString();
      }
   }
}
