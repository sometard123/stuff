package ninjakiwi.monkeyTown.town.ui.myTrack
{
   import assets.ui.TrackDifficultyRadioGroupClip;
   
   public class DifficultyRadioGroup extends MyTrackRadioGroup
   {
       
      
      private var _clip:TrackDifficultyRadioGroupClip;
      
      public function DifficultyRadioGroup(param1:TrackDifficultyRadioGroupClip)
      {
         super(param1);
         this._clip = param1;
         addTickBox(createTickBox(param1.tick1),2,2,true);
         addTickBox(createTickBox(param1.tick2),3,3);
         addTickBox(createTickBox(param1.tick3),4,4);
         addTickBox(createTickBox(param1.tick4),5,5);
         reset();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this._clip = null;
      }
   }
}
