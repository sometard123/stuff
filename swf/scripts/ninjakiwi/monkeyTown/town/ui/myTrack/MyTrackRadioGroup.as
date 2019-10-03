package ninjakiwi.monkeyTown.town.ui.myTrack
{
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import ninjakiwi.monkeyTown.town.ui.RadioGroup;
   import ninjakiwi.monkeyTown.ui.buttons.TickBox;
   
   public class MyTrackRadioGroup extends RadioGroup
   {
      
      private static const disabledColour:ColorTransform = new ColorTransform(0.25,0.25,0.25,1,137,103,45);
      
      private static const enabledColour:ColorTransform = new ColorTransform();
       
      
      protected var _ticks:Vector.<TickBox>;
      
      private var _clip:MovieClip;
      
      public function MyTrackRadioGroup(param1:MovieClip)
      {
         this._ticks = new Vector.<TickBox>();
         super();
         this._clip = param1;
      }
      
      override public function destroy() : void
      {
         var _loc1_:TickBox = null;
         super.destroy();
         if(this._ticks != null)
         {
            for each(_loc1_ in this._ticks)
            {
               _loc1_.destroy();
            }
         }
         this._ticks = null;
         this._clip = null;
      }
      
      protected function createTickBox(param1:MovieClip) : TickBox
      {
         var _loc2_:TickBox = new TickBox(param1);
         this._ticks.push(_loc2_);
         return _loc2_;
      }
      
      override public function set enable(param1:Boolean) : void
      {
         super.enable = param1;
         if(param1 == true)
         {
            this._clip.transform.colorTransform = enabledColour;
         }
         else
         {
            this._clip.transform.colorTransform = disabledColour;
         }
      }
   }
}
