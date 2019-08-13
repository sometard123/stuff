package ninjakiwi.monkeyTown.ui
{
   import assets.icons.PvPInfoBlackCobrasIcon;
   import assets.icons.PvPInfoBlueWolvesIcon;
   import assets.icons.PvPInfoDarkMatterIcon;
   import assets.icons.PvPInfoFalconsIcon;
   import assets.icons.PvPInfoIronPhoenixIcon;
   import assets.icons.PvPInfoKongIcon;
   import assets.icons.PvPInfoNightJackalsIcon;
   import assets.icons.PvPInfoRedStormIcon;
   import assets.icons.PvPInfoScorpionsIcon;
   import assets.icons.PvPInfoShiningBladeIcon;
   import assets.icons.PvPInfoTheWatchersIcon;
   import assets.icons.PvPInfoThunderBoltsIcon;
   import assets.icons.PvPInfoWhiteTigersIcon;
   import assets.icons.PvPInfoXiiiIcon;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class UIConstants
   {
      
      public static const clanIconsSmall:Object = {
         Constants.CLAN_SCORPIONS.toString():PvPInfoScorpionsIcon,
         Constants.CLAN_BLUE_WOLVES.toString():PvPInfoBlueWolvesIcon,
         Constants.CLAN_WHITE_TIGERS.toString():PvPInfoWhiteTigersIcon,
         Constants.CLAN_XIII.toString():PvPInfoXiiiIcon,
         Constants.CLAN_SHINING_BLADE.toString():PvPInfoShiningBladeIcon,
         Constants.CLAN_IRON_PHOENIX.toString():PvPInfoIronPhoenixIcon,
         Constants.CLAN_FALCONS.toString():PvPInfoFalconsIcon,
         Constants.CLAN_DARK_MATTER.toString():PvPInfoDarkMatterIcon,
         Constants.CLAN_THUNDERBOLTS.toString():PvPInfoThunderBoltsIcon,
         Constants.CLAN_BLACK_COBRAS.toString():PvPInfoBlackCobrasIcon,
         Constants.CLAN_THE_WATCHERS.toString():PvPInfoTheWatchersIcon,
         Constants.CLAN_RED_STORM.toString():PvPInfoRedStormIcon,
         Constants.CLAN_NIGHT_JACKALS.toString():PvPInfoNightJackalsIcon,
         "kong":PvPInfoKongIcon
      };
       
      
      public function UIConstants()
      {
         super();
      }
      
      public static function getClanIconSmall(param1:String) : MovieClip
      {
         var icon:MovieClip = null;
         var clan:String = param1;
         var iconClass:Class = clanIconsSmall[clan];
         try
         {
            icon = new iconClass();
         }
         catch(e:Error)
         {
            icon = new PvPInfoKongIcon();
         }
         return icon;
      }
   }
}
