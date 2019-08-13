package ninjakiwi.monkeyTown.town.ui.attack.crates
{
   import flash.display.MovieClip;
   
   public class CratesAvailableIndicator
   {
       
      
      private var _clip:MovieClip;
      
      private var crates:Array;
      
      public function CratesAvailableIndicator(param1:MovieClip)
      {
         this.crates = [];
         super();
         this._clip = param1;
         this.crates = [this._clip.crate1,this._clip.crate2,this._clip.crate3];
         this.setSelected(0);
      }
      
      public function setSelected(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.crates.length)
         {
            if(_loc2_ <= param1 - 1)
            {
               this.crates[_loc2_].gotoAndStop(1);
            }
            else
            {
               this.crates[_loc2_].gotoAndStop(3);
            }
            _loc2_++;
         }
      }
   }
}
