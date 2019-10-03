package ninjakiwi.monkeyTown.monkeyKnowledge
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.getDefinitionByName;
   import ninjakiwi.monkeyTown.ui.buttons.TickBox;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeCard;
   
   public class MonkeyKnowledgePortraitData
   {
      
      public static const avatarClassNames:Object = {
         "DartMonkey":["assets.knowledgePortrait.DartMonkey1","assets.knowledgePortrait.DartMonkey2","assets.knowledgePortrait.DartMonkey3","assets.knowledgePortrait.DartMonkey4"],
         "BoomerangThrower":["assets.knowledgePortrait.BoomerangMonkey1","assets.knowledgePortrait.BoomerangMonkey2","assets.knowledgePortrait.BoomerangMonkey3","assets.knowledgePortrait.BoomerangMonkey4"],
         "BombTower":["assets.knowledgePortrait.BombTower1","assets.knowledgePortrait.BombTower2","assets.knowledgePortrait.BombTower3","assets.knowledgePortrait.BombTower4"],
         "TackTower":["assets.knowledgePortrait.TackTower1","assets.knowledgePortrait.TackTower2","assets.knowledgePortrait.TackTower3","assets.knowledgePortrait.TackTower4"],
         "SniperMonkey":["assets.knowledgePortrait.SniperMonkey1","assets.knowledgePortrait.SniperMonkey2","assets.knowledgePortrait.SniperMonkey3","assets.knowledgePortrait.SniperMonkey4"],
         "NinjaMonkey":["assets.knowledgePortrait.NinjaMonkey1","assets.knowledgePortrait.NinjaMonkey2","assets.knowledgePortrait.NinjaMonkey3","assets.knowledgePortrait.NinjaMonkey4"],
         "IceTower":["assets.knowledgePortrait.SnowMonkey1","assets.knowledgePortrait.SnowMonkey2","assets.knowledgePortrait.SnowMonkey3","assets.knowledgePortrait.SnowMonkey4"],
         "MonkeyApprentice":["assets.knowledgePortrait.Apprentice1","assets.knowledgePortrait.Apprentice2","assets.knowledgePortrait.Apprentice3","assets.knowledgePortrait.Apprentice4"],
         "SuperMonkey":["assets.knowledgePortrait.SuperMonkey1","assets.knowledgePortrait.SuperMonkey2","assets.knowledgePortrait.SuperMonkey3","assets.knowledgePortrait.SuperMonkey4"],
         "MortarTower":["assets.knowledgePortrait.MortarMonkey1","assets.knowledgePortrait.MortarMonkey2","assets.knowledgePortrait.MortarMonkey3","assets.knowledgePortrait.MortarMonkey4"],
         "DartlingGun":["assets.knowledgePortrait.DartlingGun1","assets.knowledgePortrait.DartlingGun2","assets.knowledgePortrait.DartlingGun3","assets.knowledgePortrait.DartlingGun4"],
         "SpikeFactory":["assets.knowledgePortrait.SpikeFactory1","assets.knowledgePortrait.SpikeFactory2","assets.knowledgePortrait.SpikeFactory3","assets.knowledgePortrait.SpikeFactory4"],
         "MonkeyAce":["assets.knowledgePortrait.MonkeyAce1","assets.knowledgePortrait.MonkeyAce2","assets.knowledgePortrait.MonkeyAce3","assets.knowledgePortrait.MonkeyAce4"],
         "GlueGunner":["assets.knowledgePortrait.GlueMonkey1","assets.knowledgePortrait.GlueMonkey2","assets.knowledgePortrait.GlueMonkey3","assets.knowledgePortrait.GlueMonkey4"],
         "MonkeyBuccaneer":["assets.knowledgePortrait.Buccaneer1","assets.knowledgePortrait.Buccaneer2","assets.knowledgePortrait.Buccaneer3","assets.knowledgePortrait.Buccaneer4"],
         "MonkeyVillage":["assets.knowledgePortrait.MonkeyVillage1","assets.knowledgePortrait.MonkeyVillage2","assets.knowledgePortrait.MonkeyVillage3","assets.knowledgePortrait.MonkeyVillage4"],
         "BananaFarm":["assets.knowledgePortrait.BananaFarm1","assets.knowledgePortrait.BananaFarm2","assets.knowledgePortrait.BananaFarm3","assets.knowledgePortrait.BananaFarm4"],
         "Engineer":["assets.knowledgePortrait.Engineer1","assets.knowledgePortrait.Engineer2","assets.knowledgePortrait.Engineer3","assets.knowledgePortrait.Engineer4"],
         "BigBloonSabotage":["assets.knowledgePortrait.BigBloonSabotage1","assets.knowledgePortrait.BigBloonSabotage2","assets.knowledgePortrait.BigBloonSabotage3","assets.knowledgePortrait.BigBloonSabotage4"],
         "MonkeyTycoon":["assets.knowledgePortrait.MonkeyTycoon1","assets.knowledgePortrait.MonkeyTycoon2","assets.knowledgePortrait.MonkeyTycoon3","assets.knowledgePortrait.MonkeyTycoon4"],
         "ActiveAbility":["assets.knowledgePortrait.ActiveAbility1","assets.knowledgePortrait.ActiveAbility2","assets.knowledgePortrait.ActiveAbility3","assets.knowledgePortrait.ActiveAbility4"],
         "WildCard":["assets.knowledgePortrait.Wildcard1","assets.knowledgePortrait.Wildcard2","assets.knowledgePortrait.Wildcard3","assets.knowledgePortrait.Wildcard4"]
      };
      
      public static const allAvatarIDs:Array = [];
      
      private static var qualityIndex:Object = {
         MonkeyKnowledge.COMMON.valueOf():0,
         MonkeyKnowledge.UNCOMMON.valueOf():1,
         MonkeyKnowledge.RARE.valueOf():2,
         MonkeyKnowledge.LEGENDARY.valueOf():3
      };
      
      public static const avatarClasses:Object = {};
      
      {
         initAvatarClasses();
      }
      
      public function MonkeyKnowledgePortraitData()
      {
         super();
      }
      
      private static function initAvatarClasses() : void
      {
         var key:String = null;
         var list:Array = null;
         var classes:Array = null;
         var i:int = 0;
         for(key in avatarClassNames)
         {
            list = avatarClassNames[key];
            avatarClasses[key] = _loc4_;
            classes = _loc4_;
            allAvatarIDs.push(key);
            i = 0;
            while(i < list.length)
            {
               try
               {
                  classes[i] = getDefinitionByName(list[i]) as Class;
               }
               catch(e:Error)
               {
               }
               i++;
            }
         }
      }
      
      public static function getClassByToken(param1:MonkeyKnowledgeToken) : Class
      {
         if(param1.type === MonkeyKnowledgeCard.BOUNTY_CARD)
         {
            return KnowledgeBounty.getAvatarClassByID(param1.subType);
         }
         return getClass(param1.type,param1.quality);
      }
      
      public static function getClass(param1:String, param2:String) : Class
      {
         if(param1 === MonkeyKnowledgeCard.BOUNTY_CARD)
         {
            return KnowledgeBounty.getAvatarClassByID(param2);
         }
         if(!avatarClassNames.hasOwnProperty(param1))
         {
            return Sprite;
         }
         var _loc3_:int = 0;
         if(qualityIndex.hasOwnProperty(param2))
         {
            _loc3_ = qualityIndex[param2];
         }
         var _loc4_:Class = avatarClasses[param1][_loc3_] as Class;
         return _loc4_;
      }
   }
}
