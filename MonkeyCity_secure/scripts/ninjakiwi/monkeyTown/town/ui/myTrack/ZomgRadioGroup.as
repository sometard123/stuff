package ninjakiwi.monkeyTown.town.ui.myTrack
{
   import assets.ui.ZomgRadioGroupClip;
   
   public class ZomgRadioGroup extends MyTrackRadioGroup
   {
      
      public static const NORMAL:int = 0;
      
      public static const MOAB_CLUSTER:int = 1;
      
      public static const BFB_CLUSTER:int = 2;
      
      public static const DDT:int = 3;
       
      
      private var _clip:ZomgRadioGroupClip;
      
      public function ZomgRadioGroup(param1:ZomgRadioGroupClip)
      {
         super(param1);
         this._clip = param1;
         addTickBox(createTickBox(param1.tick1),NORMAL,NORMAL,true);
         addTickBox(createTickBox(param1.tick2),MOAB_CLUSTER,MOAB_CLUSTER);
         addTickBox(createTickBox(param1.tick3),BFB_CLUSTER,BFB_CLUSTER);
         addTickBox(createTickBox(param1.tick4),DDT,DDT);
         reset();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this._clip = null;
      }
   }
}
