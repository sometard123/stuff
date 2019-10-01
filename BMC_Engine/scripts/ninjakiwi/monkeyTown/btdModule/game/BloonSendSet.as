package ninjakiwi.monkeyTown.btdModule.game
{
   import assets.sandbox.Sandbox_BFB;
   import assets.sandbox.Sandbox_Black;
   import assets.sandbox.Sandbox_Blue;
   import assets.sandbox.Sandbox_CamoBlack;
   import assets.sandbox.Sandbox_CamoBlue;
   import assets.sandbox.Sandbox_CamoCeramic;
   import assets.sandbox.Sandbox_CamoGreen;
   import assets.sandbox.Sandbox_CamoIce;
   import assets.sandbox.Sandbox_CamoLead;
   import assets.sandbox.Sandbox_CamoPink;
   import assets.sandbox.Sandbox_CamoRainbow;
   import assets.sandbox.Sandbox_CamoRed;
   import assets.sandbox.Sandbox_CamoRegenBlack;
   import assets.sandbox.Sandbox_CamoRegenBlue;
   import assets.sandbox.Sandbox_CamoRegenCeramic;
   import assets.sandbox.Sandbox_CamoRegenGreen;
   import assets.sandbox.Sandbox_CamoRegenIce;
   import assets.sandbox.Sandbox_CamoRegenLead;
   import assets.sandbox.Sandbox_CamoRegenPink;
   import assets.sandbox.Sandbox_CamoRegenRainbow;
   import assets.sandbox.Sandbox_CamoRegenRed;
   import assets.sandbox.Sandbox_CamoRegenYellow;
   import assets.sandbox.Sandbox_CamoRegenZebra;
   import assets.sandbox.Sandbox_CamoYellow;
   import assets.sandbox.Sandbox_CamoZebra;
   import assets.sandbox.Sandbox_Ceramic;
   import assets.sandbox.Sandbox_Green;
   import assets.sandbox.Sandbox_Ice;
   import assets.sandbox.Sandbox_Lead;
   import assets.sandbox.Sandbox_MOAB;
   import assets.sandbox.Sandbox_OMFG;
   import assets.sandbox.Sandbox_Pink;
   import assets.sandbox.Sandbox_Rainbow;
   import assets.sandbox.Sandbox_Red;
   import assets.sandbox.Sandbox_RegenBlack;
   import assets.sandbox.Sandbox_RegenBlue;
   import assets.sandbox.Sandbox_RegenCeramic;
   import assets.sandbox.Sandbox_RegenGreen;
   import assets.sandbox.Sandbox_RegenIce;
   import assets.sandbox.Sandbox_RegenLead;
   import assets.sandbox.Sandbox_RegenPink;
   import assets.sandbox.Sandbox_RegenRainbow;
   import assets.sandbox.Sandbox_RegenRed;
   import assets.sandbox.Sandbox_RegenYellow;
   import assets.sandbox.Sandbox_RegenZebra;
   import assets.sandbox.Sandbox_Yellow;
   import assets.sandbox.Sandbox_Zebra;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   
   public class BloonSendSet
   {
       
      
      public var bloonSendSets:Vector.<BloonSendDef>;
      
      private var standardThumbs:Array;
      
      private var regenThumbs:Array;
      
      private var camoThumbs:Array;
      
      private var camoRegenThumbs:Array;
      
      public function BloonSendSet()
      {
         this.bloonSendSets = new Vector.<BloonSendDef>();
         this.standardThumbs = [Sandbox_Red,Sandbox_Blue,Sandbox_Green,Sandbox_Yellow,Sandbox_Pink,Sandbox_Black,Sandbox_Ice,Sandbox_Zebra,Sandbox_Lead,Sandbox_Rainbow,Sandbox_Ceramic,Sandbox_MOAB,Sandbox_BFB,Sandbox_OMFG];
         this.regenThumbs = [Sandbox_RegenRed,Sandbox_RegenBlue,Sandbox_RegenGreen,Sandbox_RegenYellow,Sandbox_RegenPink,Sandbox_RegenBlack,Sandbox_RegenIce,Sandbox_RegenZebra,Sandbox_RegenLead,Sandbox_RegenRainbow,Sandbox_RegenCeramic,Sandbox_MOAB,Sandbox_BFB,Sandbox_OMFG];
         this.camoThumbs = [Sandbox_CamoRed,Sandbox_CamoBlue,Sandbox_CamoGreen,Sandbox_CamoYellow,Sandbox_CamoPink,Sandbox_CamoBlack,Sandbox_CamoIce,Sandbox_CamoZebra,Sandbox_CamoLead,Sandbox_CamoRainbow,Sandbox_CamoCeramic,Sandbox_MOAB,Sandbox_BFB,Sandbox_OMFG];
         this.camoRegenThumbs = [Sandbox_CamoRegenRed,Sandbox_CamoRegenBlue,Sandbox_CamoRegenGreen,Sandbox_CamoRegenYellow,Sandbox_CamoRegenPink,Sandbox_CamoRegenBlack,Sandbox_CamoRegenIce,Sandbox_CamoRegenZebra,Sandbox_CamoRegenLead,Sandbox_CamoRegenRainbow,Sandbox_CamoRegenCeramic,Sandbox_MOAB,Sandbox_BFB,Sandbox_OMFG];
         super();
         var _loc1_:BloonSendDef = new BloonSendDef().ID("RedGroup1").Type(Bloon.RED).Name("Red Bloon").Hotkey("1").Quantity(10).Interval(0.6).Cost(20).IncomeChange(2).UnlockRound(1).ThumbStandard(Sandbox_Red).ThumbCamo(Sandbox_CamoRed).ThumbRegen(Sandbox_RegenRed).ThumbRegenCamo(Sandbox_CamoRegenRed);
         this.bloonSendSets.push(_loc1_);
         _loc1_ = new BloonSendDef().ID("BlueGroup1").Type(Bloon.BLUE).Name("Blue Bloon").Hotkey("2").Quantity(10).Interval(0.6).Cost(35).IncomeChange(4).UnlockRound(1).ThumbStandard(Sandbox_Blue).ThumbCamo(Sandbox_CamoBlue).ThumbRegen(Sandbox_RegenBlue).ThumbRegenCamo(Sandbox_CamoRegenBlue);
         this.bloonSendSets.push(_loc1_);
         _loc1_ = new BloonSendDef().ID("GreenGroup1").Type(Bloon.GREEN).Name("Green Bloon").Hotkey("3").Quantity(5).Interval(0.6).Cost(30).IncomeChange(3).UnlockRound(5).ThumbStandard(Sandbox_Green).ThumbCamo(Sandbox_CamoGreen).ThumbRegen(Sandbox_RegenGreen).ThumbRegenCamo(Sandbox_CamoRegenGreen);
         this.bloonSendSets.push(_loc1_);
         _loc1_ = new BloonSendDef().ID("YellowGroup1").Type(Bloon.YELLOW).Name("Yellow Bloon").Hotkey("4").Quantity(5).Interval(0.6).Cost(50).IncomeChange(5).UnlockRound(5).ThumbStandard(Sandbox_Yellow).ThumbCamo(Sandbox_CamoYellow).ThumbRegen(Sandbox_RegenYellow).ThumbRegenCamo(Sandbox_CamoRegenYellow);
         this.bloonSendSets.push(_loc1_);
         _loc1_ = new BloonSendDef().ID("PinkGroup1").Type(Bloon.PINK).Name("Pink Bloon").Hotkey("5").Quantity(5).Interval(0.6).Cost(80).IncomeChange(8).UnlockRound(10).ThumbStandard(Sandbox_Pink).ThumbCamo(Sandbox_CamoPink).ThumbRegen(Sandbox_RegenPink).ThumbRegenCamo(Sandbox_CamoRegenPink);
         this.bloonSendSets.push(_loc1_);
         _loc1_ = new BloonSendDef().ID("BlackGroup1").Type(Bloon.BLACK).Name("Black Bloon").Hotkey("6").Quantity(3).Interval(0.6).Cost(160).IncomeChange(16).UnlockRound(12).ThumbStandard(Sandbox_Black).ThumbCamo(Sandbox_CamoBlack).ThumbRegen(Sandbox_RegenBlack).ThumbRegenCamo(Sandbox_CamoRegenBlack);
         this.bloonSendSets.push(_loc1_);
         _loc1_ = new BloonSendDef().ID("WhiteGroup1").Type(Bloon.WHITE).Name("White Bloon").Hotkey("7").Quantity(3).Interval(0.6).Cost(160).IncomeChange(16).UnlockRound(12).ThumbStandard(Sandbox_Ice).ThumbCamo(Sandbox_CamoIce).ThumbRegen(Sandbox_RegenIce).ThumbRegenCamo(Sandbox_CamoRegenIce);
         this.bloonSendSets.push(_loc1_);
         _loc1_ = new BloonSendDef().ID("LeadGroup1").Type(Bloon.LEAD).Name("Lead Bloon").Hotkey("8").Quantity(3).Interval(0.6).Cost(180).IncomeChange(18).UnlockRound(12).ThumbStandard(Sandbox_Lead).ThumbCamo(Sandbox_CamoLead).ThumbRegen(Sandbox_RegenLead).ThumbRegenCamo(Sandbox_CamoRegenLead);
         this.bloonSendSets.push(_loc1_);
         _loc1_ = new BloonSendDef().ID("ZebraGroup1").Type(Bloon.ZEBRA).Name("Zebra Bloon").Hotkey("9").Quantity(3).Interval(0.6).Cost(180).IncomeChange(18).UnlockRound(12).ThumbStandard(Sandbox_Zebra).ThumbCamo(Sandbox_CamoZebra).ThumbRegen(Sandbox_RegenZebra).ThumbRegenCamo(Sandbox_CamoRegenZebra);
         this.bloonSendSets.push(_loc1_);
         _loc1_ = new BloonSendDef().ID("RainbowGroup1").Type(Bloon.RAINBOW).Name("Rainbow Bloon").Hotkey("0").Quantity(2).Interval(0.6).Cost(220).IncomeChange(22).UnlockRound(15).ThumbStandard(Sandbox_Rainbow).ThumbCamo(Sandbox_CamoRainbow).ThumbRegen(Sandbox_RegenRainbow).ThumbRegenCamo(Sandbox_CamoRegenRainbow);
         this.bloonSendSets.push(_loc1_);
         _loc1_ = new BloonSendDef().ID("CeremicGroup1").Type(Bloon.CERAMIC).Name("Ceremic Bloon").Hotkey("U").Quantity(1).Interval(0.6).Cost(250).IncomeChange(0).UnlockRound(20).ThumbStandard(Sandbox_Ceramic).ThumbCamo(Sandbox_CamoCeramic).ThumbRegen(Sandbox_RegenCeramic).ThumbRegenCamo(Sandbox_CamoRegenCeramic);
         this.bloonSendSets.push(_loc1_);
         _loc1_ = new BloonSendDef().ID("MOABGroup1").Type(Bloon.MOAB).Name("MOAB").Hotkey("I").Quantity(1).Interval(0.6).Cost(1500).IncomeChange(-30).UnlockRound(25).ThumbStandard(Sandbox_MOAB).ThumbCamo(Sandbox_MOAB).ThumbRegen(Sandbox_MOAB).ThumbRegenCamo(Sandbox_MOAB);
         this.bloonSendSets.push(_loc1_);
         _loc1_ = new BloonSendDef().ID("BFBGroup1").Type(Bloon.BFB).Name("BFB").Hotkey("O").Quantity(1).Interval(0.6).Cost(5000).IncomeChange(-250).UnlockRound(30).ThumbStandard(Sandbox_BFB).ThumbCamo(Sandbox_BFB).ThumbRegen(Sandbox_BFB).ThumbRegenCamo(Sandbox_BFB);
         this.bloonSendSets.push(_loc1_);
         _loc1_ = new BloonSendDef().ID("ZOMGGroup1").Type(Bloon.BOSS).Name("ZOMG").Hotkey("P").Quantity(1).Interval(0.6).Cost(15000).IncomeChange(-1500).UnlockRound(30).ThumbStandard(Sandbox_OMFG).ThumbCamo(Sandbox_OMFG).ThumbRegen(Sandbox_OMFG).ThumbRegenCamo(Sandbox_OMFG);
         this.bloonSendSets.push(_loc1_);
      }
      
      public function getBloonSendDef(param1:String) : BloonSendDef
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.bloonSendSets.length)
         {
            if(param1 == this.bloonSendSets[_loc2_].id)
            {
               return this.bloonSendSets[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function clearAllBloonSendDefs() : void
      {
         this.bloonSendSets = new Vector.<BloonSendDef>();
      }
      
      public function addBloonSendDef(param1:BloonSendDef) : void
      {
         param1.thumbStandard = this.standardThumbs[param1.type];
         param1.thumbRegen = this.regenThumbs[param1.type];
         param1.thumbCamo = this.camoThumbs[param1.type];
         param1.thumbRegenCamo = this.camoRegenThumbs[param1.type];
         this.bloonSendSets.push(param1);
      }
   }
}
