package ninjakiwi.monkeyTown.town.data
{
   import assets.bloonIcons.BloonIconBlack;
   import assets.bloonIcons.BloonIconBlackRegen;
   import assets.bloonIcons.BloonIconBlue;
   import assets.bloonIcons.BloonIconBlueRegen;
   import assets.bloonIcons.BloonIconCamoBlack;
   import assets.bloonIcons.BloonIconCamoBlue;
   import assets.bloonIcons.BloonIconCamoCeramic;
   import assets.bloonIcons.BloonIconCamoGreen;
   import assets.bloonIcons.BloonIconCamoIce;
   import assets.bloonIcons.BloonIconCamoLead;
   import assets.bloonIcons.BloonIconCamoPink;
   import assets.bloonIcons.BloonIconCamoRainbow;
   import assets.bloonIcons.BloonIconCamoRed;
   import assets.bloonIcons.BloonIconCamoRegen;
   import assets.bloonIcons.BloonIconCamoYellow;
   import assets.bloonIcons.BloonIconCamoZebra;
   import assets.bloonIcons.BloonIconCeramic;
   import assets.bloonIcons.BloonIconCeramicRegen;
   import assets.bloonIcons.BloonIconDDT;
   import assets.bloonIcons.BloonIconDDTCamo;
   import assets.bloonIcons.BloonIconDDTRegen;
   import assets.bloonIcons.BloonIconGreen;
   import assets.bloonIcons.BloonIconGreenRegen;
   import assets.bloonIcons.BloonIconIceBlue;
   import assets.bloonIcons.BloonIconIceRegen;
   import assets.bloonIcons.BloonIconLead;
   import assets.bloonIcons.BloonIconLeadRegen;
   import assets.bloonIcons.BloonIconMoab;
   import assets.bloonIcons.BloonIconMoabCamo;
   import assets.bloonIcons.BloonIconMoabCluster;
   import assets.bloonIcons.BloonIconMoabClusterCamo;
   import assets.bloonIcons.BloonIconMoabClusterRegen;
   import assets.bloonIcons.BloonIconMoabRed;
   import assets.bloonIcons.BloonIconMoabRedCamo;
   import assets.bloonIcons.BloonIconMoabRedCluster;
   import assets.bloonIcons.BloonIconMoabRedClusterCamo;
   import assets.bloonIcons.BloonIconMoabRedClusterRegen;
   import assets.bloonIcons.BloonIconMoabRedRegen;
   import assets.bloonIcons.BloonIconMoabRegen;
   import assets.bloonIcons.BloonIconPink;
   import assets.bloonIcons.BloonIconPinkRegen;
   import assets.bloonIcons.BloonIconRainbow;
   import assets.bloonIcons.BloonIconRainbowRegen;
   import assets.bloonIcons.BloonIconRed;
   import assets.bloonIcons.BloonIconYellow;
   import assets.bloonIcons.BloonIconYellowRegen;
   import assets.bloonIcons.BloonIconZebra;
   import assets.bloonIcons.BloonIconZebraRegen;
   import assets.bloonIcons.BloonIconZomg;
   import assets.bloonIcons.BloonIconZomgCamo;
   import assets.bloonIcons.BloonIconZomgRegen;
   import assets.bloonIcons.BloonsIconRegenRed;
   import assets.bloonIcons.MissionSymbol;
   import flash.utils.getQualifiedClassName;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
   
   public class BloonIconData
   {
      
      private static var _strongestBloonClip:BitClipCustom = new BitClipCustom();
      
      private static var _difficultyRankPips:BitClipCustom;
      
      private static var _animationClassNames:Object = {};
      
      public static const bloonIconClasses:Object = {
         "" + Constants.RED_BLOON:BloonIconRed,
         "" + Constants.BLUE_BLOON:BloonIconBlue,
         "" + Constants.GREEN_BLOON:BloonIconGreen,
         "" + Constants.YELLOW_BLOON:BloonIconYellow,
         "" + Constants.PINK_BLOON:BloonIconPink,
         "" + Constants.BLACK_BLOON:BloonIconBlack,
         "" + Constants.WHITE_BLOON:BloonIconIceBlue,
         "" + Constants.LEAD_BLOON:BloonIconLead,
         "" + Constants.ZEBRA_BLOON:BloonIconZebra,
         "" + Constants.RAINBOW_BLOON:BloonIconRainbow,
         "" + Constants.CERAMIC_BLOON:BloonIconCeramic,
         "" + Constants.RED_BLOON + "_" + Constants.CAMO:BloonIconCamoRed,
         "" + Constants.BLUE_BLOON + "_" + Constants.CAMO:BloonIconCamoBlue,
         "" + Constants.GREEN_BLOON + "_" + Constants.CAMO:BloonIconCamoGreen,
         "" + Constants.YELLOW_BLOON + "_" + Constants.CAMO:BloonIconCamoYellow,
         "" + Constants.PINK_BLOON + "_" + Constants.CAMO:BloonIconCamoPink,
         "" + Constants.BLACK_BLOON + "_" + Constants.CAMO:BloonIconCamoBlack,
         "" + Constants.WHITE_BLOON + "_" + Constants.CAMO:BloonIconCamoIce,
         "" + Constants.LEAD_BLOON + "_" + Constants.CAMO:BloonIconCamoLead,
         "" + Constants.ZEBRA_BLOON + "_" + Constants.CAMO:BloonIconCamoZebra,
         "" + Constants.RAINBOW_BLOON + "_" + Constants.CAMO:BloonIconCamoRainbow,
         "" + Constants.CERAMIC_BLOON + "_" + Constants.CAMO:BloonIconCamoCeramic,
         "" + Constants.RED_BLOON + "_" + Constants.REGEN:BloonsIconRegenRed,
         "" + Constants.BLUE_BLOON + "_" + Constants.REGEN:BloonIconBlueRegen,
         "" + Constants.GREEN_BLOON + "_" + Constants.REGEN:BloonIconGreenRegen,
         "" + Constants.YELLOW_BLOON + "_" + Constants.REGEN:BloonIconYellowRegen,
         "" + Constants.PINK_BLOON + "_" + Constants.REGEN:BloonIconPinkRegen,
         "" + Constants.BLACK_BLOON + "_" + Constants.REGEN:BloonIconBlackRegen,
         "" + Constants.WHITE_BLOON + "_" + Constants.REGEN:BloonIconIceRegen,
         "" + Constants.LEAD_BLOON + "_" + Constants.REGEN:BloonIconLeadRegen,
         "" + Constants.ZEBRA_BLOON + "_" + Constants.REGEN:BloonIconZebraRegen,
         "" + Constants.RAINBOW_BLOON + "_" + Constants.REGEN:BloonIconRainbowRegen,
         "" + Constants.CERAMIC_BLOON + "_" + Constants.REGEN:BloonIconCeramicRegen,
         "" + Constants.CAMO_REGEN:BloonIconCamoRegen,
         "" + Constants.MOAB_BLOON:BloonIconMoab,
         "" + Constants.BFB_BLOON:BloonIconMoabRed,
         "" + Constants.BOSS_BLOON:BloonIconZomg,
         "" + Constants.DDT_BLOON:BloonIconDDT,
         "" + Constants.MOAB_CLUSTER:BloonIconMoabCluster,
         "" + Constants.BFB_CLUSTER:BloonIconMoabRedCluster,
         "" + Constants.MOAB_BLOON + "_" + Constants.REGEN:BloonIconMoabRegen,
         "" + Constants.BFB_BLOON + "_" + Constants.REGEN:BloonIconMoabRedRegen,
         "" + Constants.BOSS_BLOON + "_" + Constants.REGEN:BloonIconZomgRegen,
         "" + Constants.DDT_BLOON + "_" + Constants.REGEN:BloonIconDDTRegen,
         "" + Constants.MOAB_CLUSTER + "_" + Constants.REGEN:BloonIconMoabClusterRegen,
         "" + Constants.BFB_CLUSTER + "_" + Constants.REGEN:BloonIconMoabRedClusterRegen,
         "" + Constants.MOAB_BLOON + "_" + Constants.CAMO:BloonIconMoabCamo,
         "" + Constants.BFB_BLOON + "_" + Constants.CAMO:BloonIconMoabRedCamo,
         "" + Constants.BOSS_BLOON + "_" + Constants.CAMO:BloonIconZomgCamo,
         "" + Constants.DDT_BLOON + "_" + Constants.CAMO:BloonIconDDTCamo,
         "" + Constants.MOAB_CLUSTER + "_" + Constants.CAMO:BloonIconMoabClusterCamo,
         "" + Constants.BFB_CLUSTER + "_" + Constants.CAMO:BloonIconMoabRedClusterCamo,
         "" + Constants.SPECIAL_MISSION_SYMBOL:MissionSymbol
      };
       
      
      public function BloonIconData()
      {
         super();
      }
      
      public static function getIconClassForBloon(param1:String) : Class
      {
         return bloonIconClasses[param1];
      }
      
      public static function getIconClassNameForBloon(param1:String) : String
      {
         var _loc2_:Class = bloonIconClasses[param1];
         if(_loc2_ !== null)
         {
            return getQualifiedClassName(_loc2_);
         }
         return null;
      }
      
      public static function getIconBitClipForBloonName(param1:String) : BitClipCustom
      {
         var _loc2_:String = null;
         if(!_strongestBloonClip.hasAnimation(param1))
         {
            _loc2_ = getIconClassNameForBloon(param1);
            _strongestBloonClip.addAnimation(_loc2_);
            _animationClassNames[param1] = _loc2_;
         }
         _strongestBloonClip.selectAnimation(_animationClassNames[param1]);
         return _strongestBloonClip;
      }
      
      public static function getDifficultyRankPips(param1:int) : BitClipCustom
      {
         if(_difficultyRankPips === null)
         {
            _difficultyRankPips = new BitClipCustom();
            _difficultyRankPips.addAnimation("assets.bloonIcons.DifficultyBarsTileClip","pips");
         }
         if(param1 > 5)
         {
            param1 = 5;
         }
         _difficultyRankPips.currentSubFrame = param1 + 1;
         _difficultyRankPips.gotoAndStop(param1 + 1);
         return _difficultyRankPips;
      }
   }
}
