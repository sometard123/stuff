package ninjakiwi.monkeyTown.town.ui.bloon
{
   import assets.ui.BloonTypeIconClip;
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class BloonTypeIcon extends BloonTypeIconClip
   {
       
      
      public function BloonTypeIcon()
      {
         super();
      }
      
      public static function setBloonTypeOfTarget(param1:BloonTypeIconClip, param2:String) : void
      {
         if(param2 == Constants.RED_BLOON)
         {
            param1.gotoAndStop(1);
         }
         else if(param2 == Constants.BLUE_BLOON)
         {
            param1.gotoAndStop(2);
         }
         else if(param2 == Constants.GREEN_BLOON)
         {
            param1.gotoAndStop(3);
         }
         else if(param2 == Constants.YELLOW_BLOON)
         {
            param1.gotoAndStop(4);
         }
         else if(param2 == Constants.PINK_BLOON)
         {
            param1.gotoAndStop(5);
         }
         else if(param2 == Constants.BLACK_BLOON)
         {
            param1.gotoAndStop(6);
         }
         else if(param2 == Constants.WHITE_BLOON)
         {
            param1.gotoAndStop(7);
         }
         else if(param2 == Constants.ZEBRA_BLOON)
         {
            param1.gotoAndStop(8);
         }
         else if(param2 == Constants.LEAD_BLOON)
         {
            param1.gotoAndStop(9);
         }
         else if(param2 == Constants.RAINBOW_BLOON)
         {
            param1.gotoAndStop(10);
         }
         else if(param2 == Constants.CERAMIC_BLOON)
         {
            param1.gotoAndStop(11);
         }
         else if(param2 == Constants.MOAB_BLOON)
         {
            param1.gotoAndStop(12);
         }
         else if(param2 == Constants.BFB_BLOON)
         {
            param1.gotoAndStop(13);
         }
         else if(param2 == Constants.BOSS_BLOON)
         {
            param1.gotoAndStop(14);
         }
         else if(param2 == Constants.DDT_BLOON)
         {
            param1.gotoAndStop(15);
         }
         else
         {
            param1.gotoAndStop(14);
         }
      }
      
      public function setBloonType(param1:String) : void
      {
         BloonTypeIcon.setBloonTypeOfTarget(this,param1);
      }
   }
}
