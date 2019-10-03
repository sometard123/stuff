package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.tool.Console;
   
   public class BloonSendTestModule
   {
      
      public static const instance:BloonSendTestModule = new BloonSendTestModule();
       
      
      private var enableRegen:Boolean = false;
      
      private var enableCamo:Boolean = false;
      
      private var usingStrongBloons:Boolean = false;
      
      private var consoleOutput:Console;
      
      private var isActive:Boolean = false;
      
      public function BloonSendTestModule()
      {
         this.consoleOutput = new Console();
         super();
      }
      
      public function activateBloonSendTestModule() : void
      {
         if(this.isActive)
         {
            return;
         }
         Main.instance.stage.addChild(this.consoleOutput);
         Main.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this.refreshOutput();
         this.isActive = true;
      }
      
      public function deactivateBloonSendTestModule() : void
      {
         if(false == this.isActive)
         {
            return;
         }
         Main.instance.stage.removeChild(this.consoleOutput);
         Main.instance.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this.consoleOutput.clear();
         this.isActive = false;
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.EQUAL || param1.keyCode == Keyboard.NUMPAD_ADD)
         {
            this.enableRegen = !this.enableRegen;
         }
         if(param1.keyCode == Keyboard.MINUS || param1.keyCode == Keyboard.NUMPAD_SUBTRACT)
         {
            this.enableCamo = !this.enableCamo;
         }
         if(param1.keyCode == Keyboard.CONTROL)
         {
            this.usingStrongBloons = !this.usingStrongBloons;
         }
         this.refreshOutput();
         if(false == Main.instance.game.level.roundInProgress)
         {
            return;
         }
         if(param1.keyCode == Keyboard.NUMBER_1 || param1.keyCode == Keyboard.NUMPAD_1)
         {
            if(this.usingStrongBloons)
            {
               this.spawnBloon(Bloon.RAINBOW);
            }
            else
            {
               this.spawnBloon(Bloon.RED);
            }
         }
         if(param1.keyCode == Keyboard.NUMBER_2 || param1.keyCode == Keyboard.NUMPAD_2)
         {
            if(this.usingStrongBloons)
            {
               this.spawnBloon(Bloon.CERAMIC);
            }
            else
            {
               this.spawnBloon(Bloon.BLUE);
            }
         }
         if(param1.keyCode == Keyboard.NUMBER_3 || param1.keyCode == Keyboard.NUMPAD_3)
         {
            if(this.usingStrongBloons)
            {
               this.spawnBloon(Bloon.MOAB);
            }
            else
            {
               this.spawnBloon(Bloon.GREEN);
            }
         }
         if(param1.keyCode == Keyboard.NUMBER_4 || param1.keyCode == Keyboard.NUMPAD_4)
         {
            if(this.usingStrongBloons)
            {
               this.spawnBloon(Bloon.BFB);
            }
            else
            {
               this.spawnBloon(Bloon.YELLOW);
            }
         }
         if(param1.keyCode == Keyboard.NUMBER_5 || param1.keyCode == Keyboard.NUMPAD_5)
         {
            if(this.usingStrongBloons)
            {
               this.spawnBloon(Bloon.BOSS);
            }
            else
            {
               this.spawnBloon(Bloon.PINK);
            }
         }
         if(param1.keyCode == Keyboard.NUMBER_6 || param1.keyCode == Keyboard.NUMPAD_6)
         {
            if(this.usingStrongBloons)
            {
               this.spawnBloon(Bloon.DDT);
            }
            else
            {
               this.spawnBloon(Bloon.BLACK);
            }
         }
         if(param1.keyCode == Keyboard.NUMBER_7 || param1.keyCode == Keyboard.NUMPAD_7)
         {
            if(this.usingStrongBloons)
            {
               this.spawnBloon(Bloon.BOSS_BLOONARIUS);
            }
            else
            {
               this.spawnBloon(Bloon.WHITE);
            }
         }
         if(param1.keyCode == Keyboard.NUMBER_8 || param1.keyCode == Keyboard.NUMPAD_8)
         {
            this.spawnBloon(Bloon.ZEBRA);
         }
         if(param1.keyCode == Keyboard.NUMBER_9 || param1.keyCode == Keyboard.NUMPAD_9)
         {
            this.spawnBloon(Bloon.LEAD);
         }
      }
      
      private function spawnBloon(param1:int) : void
      {
         var _loc2_:Level = Main.instance.game.level;
         var _loc3_:Bloon = Pool.get(Bloon);
         var _loc4_:Boolean = this.enableRegen;
         var _loc5_:Boolean = this.enableCamo;
         if(Bloon.isHugeClass(param1))
         {
            _loc4_ = false;
            _loc5_ = false;
         }
         _loc3_.initialise(_loc2_,param1,_loc2_.startTile,0,_loc4_,_loc5_,_loc2_.roundGenerator.currentRoundDuration);
         _loc2_.addBloon(_loc3_);
      }
      
      private function refreshOutput() : void
      {
         this.consoleOutput.clear();
         this.consoleOutput.log("");
         this.consoleOutput.log("Regen: " + this.enableRegen.toString());
         this.consoleOutput.log("Camo: " + this.enableCamo.toString());
         this.consoleOutput.log("");
         this.consoleOutput.log("Ctrl = Change Bloons");
         this.consoleOutput.log("+ = Toggle regen");
         this.consoleOutput.log("- = Toggle camo");
         this.consoleOutput.log("");
         this.consoleOutput.log("1 = " + (false == this.usingStrongBloons?"Red":"Rainbow"));
         this.consoleOutput.log("2 = " + (false == this.usingStrongBloons?"Blue":"Ceramic"));
         this.consoleOutput.log("3 = " + (false == this.usingStrongBloons?"Green":"MOAB"));
         this.consoleOutput.log("4 = " + (false == this.usingStrongBloons?"Yellow":"BFB"));
         this.consoleOutput.log("5 = " + (false == this.usingStrongBloons?"Pink":"ZOMG"));
         this.consoleOutput.log("6 = " + (false == this.usingStrongBloons?"Black":"DDT"));
         this.consoleOutput.log("7 = " + (false == this.usingStrongBloons?"White":"Bloonarius"));
         if(false == this.usingStrongBloons)
         {
            this.consoleOutput.log("8 = Zebra");
            this.consoleOutput.log("9 = Lead");
         }
         if(false == Main.instance.game.level.roundInProgress)
         {
            this.consoleOutput.log("");
            this.consoleOutput.log("Begin round to start deploying");
         }
      }
   }
}
