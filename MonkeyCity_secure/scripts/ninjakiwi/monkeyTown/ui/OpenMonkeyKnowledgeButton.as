package ninjakiwi.monkeyTown.ui
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class OpenMonkeyKnowledgeButton
   {
       
      
      private var _button:ButtonControllerBase;
      
      private var _clip:MovieClip;
      
      public function OpenMonkeyKnowledgeButton(param1:MovieClip)
      {
         super();
         this._clip = param1;
         this._button = new ButtonControllerBase(this._clip);
         MonkeyKnowledge.getInstance().dataPopulatedSignal.add(this.sync);
         MonkeyKnowledge.getInstance().unopenedPacksChangedSignal.add(this.sync);
         MonkeyKnowledge.getInstance().unopenedAncientPacksChangedSignal.add(this.sync);
         MonkeyKnowledge.getInstance().unopenedWildcardPacksChangedSignal.add(this.sync);
         this._button.setClickFunction(TownUI.getInstance().monkeyKnowledgeOpenPacksScreen.reveal);
         this._clip.addEventListener(MouseEvent.ROLL_OVER,this.onRollover);
         this._clip.addEventListener(MouseEvent.ROLL_OUT,this.onRollout);
      }
      
      private function onRollover(param1:Event) : void
      {
         this._clip.idol.gotoAndStop(1);
      }
      
      private function onRollout(param1:Event) : void
      {
         this.sync();
      }
      
      private function sync(... rest) : void
      {
         var _loc2_:int = MonkeyKnowledge.getInstance().unopenedPacks + MonkeyKnowledge.getInstance().unopenedAncientPacks + MonkeyKnowledge.getInstance().unopenedWildcardPacks;
         var _loc3_:MovieClip = this._clip.idol.idolInner;
         if(_loc2_ === 0)
         {
            _loc3_.gem.visible = this._clip.gemHover.visible = _loc3_.numberField.visible = false;
            this._clip.idol.gotoAndStop(1);
         }
         else
         {
            _loc3_.gem.visible = this._clip.gemHover.visible = _loc3_.numberField.visible = true;
            _loc3_.numberField.text = _loc2_;
            this._clip.idol.gotoAndPlay(50);
         }
      }
      
      public function get clip() : MovieClip
      {
         return this._clip;
      }
   }
}
