package ninjakiwi.monkeyTown.town.ui.attack.crates
{
   import com.codecatalyst.promise.Promise;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class CratesTickBoxes
   {
      
      public static const MAX_NUMBER_OF_OWNED_CRATES:int = 50;
       
      
      private var _clip:MovieClip;
      
      private var _box1:CrateTickBox;
      
      private var _box2:CrateTickBox;
      
      private var _box3:CrateTickBox;
      
      private var _maxCrates:TextField;
      
      private var _boxes:Array;
      
      private var _cratesAvailable:int;
      
      public function CratesTickBoxes(param1:MovieClip)
      {
         super();
         this._clip = param1;
         this.init();
      }
      
      public function setCratesAvailable(param1:int) : void
      {
         var _loc2_:CrateTickBox = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._boxes.length)
         {
            _loc2_ = this._boxes[_loc3_];
            if(_loc3_ < param1)
            {
               _loc2_.setEnabled(true);
            }
            else
            {
               _loc2_.setEnabled(false);
            }
            _loc3_++;
         }
         this._cratesAvailable = param1;
         this.updateCratesAvailableField(this._cratesAvailable);
      }
      
      public function get cratesTicked() : int
      {
         var _loc2_:CrateTickBox = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._boxes.length)
         {
            _loc2_ = this._boxes[_loc3_];
            if(_loc2_.ticked)
            {
               _loc1_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get cratesTickedArray() : Array
      {
         var _loc3_:CrateTickBox = null;
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < this._boxes.length)
         {
            _loc3_ = this._boxes[_loc4_];
            if(_loc3_.ticked)
            {
               _loc1_++;
            }
            _loc2_.push(_loc3_.ticked);
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function setCratesTicked(param1:int) : void
      {
         var _loc2_:CrateTickBox = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._boxes.length)
         {
            _loc2_ = this._boxes[_loc3_];
            if(_loc3_ < param1)
            {
               _loc2_.ticked = true;
            }
            else
            {
               _loc2_.ticked = false;
            }
            _loc3_++;
         }
         this.updateCratesAvailableField(this._cratesAvailable - param1);
      }
      
      private function init() : void
      {
         var _loc1_:CrateTickBox = null;
         this._box1 = new CrateTickBox(this._clip.crate1);
         this._box2 = new CrateTickBox(this._clip.crate2);
         this._box3 = new CrateTickBox(this._clip.crate3);
         this._boxes = [this._box1,this._box2,this._box3];
         var _loc2_:int = 0;
         while(_loc2_ < this._boxes.length)
         {
            _loc1_ = this._boxes[_loc2_];
            _loc1_.index = _loc2_;
            _loc1_.stateChangedSignal.add(this.onTickBoxStateChanged);
            _loc2_++;
         }
         this._maxCrates = this._clip.maxCrates;
         this._cratesAvailable = 0;
      }
      
      private function onTickBoxStateChanged(param1:Boolean, param2:int) : void
      {
         if(param1)
         {
            this.setCratesTicked(param2 + 1);
         }
         else
         {
            this.setCratesTicked(0);
         }
      }
      
      private function updateCratesAvailableField(param1:int) : void
      {
         this._maxCrates.text = param1.toString() + "/" + MAX_NUMBER_OF_OWNED_CRATES.toString();
      }
      
      private function getCrateSelectionState() : Array
      {
         return [this._box1.ticked,this._box2.ticked,this._box3.ticked];
      }
   }
}
