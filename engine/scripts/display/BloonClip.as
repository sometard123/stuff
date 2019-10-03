package display
{
   import assets.BurnEffect;
   import assets.CamoEffect;
   import assets.DDTCamoOverlay;
   import assets.DissolverEffect;
   import assets.GlueEffect;
   import assets.IceEffect;
   import assets.bloon.Bfb;
   import assets.bloon.BfbProps;
   import assets.bloon.BossBlimp;
   import assets.bloon.BossBlimpProps;
   import assets.bloon.Ddt;
   import assets.bloon.DdtProp;
   import assets.bloon.Moab;
   import assets.bloon.MoabProps;
   import assets.bloons.Black;
   import assets.bloons.BlackRegen;
   import assets.bloons.BlastopopoulosProps;
   import assets.bloons.BlastopopoulosRed;
   import assets.bloons.Bloonarius;
   import assets.bloons.BloonariusProps;
   import assets.bloons.Blue;
   import assets.bloons.BlueRegen;
   import assets.bloons.Ceramic;
   import assets.bloons.CeramicRegen;
   import assets.bloons.Dreadbloon;
   import assets.bloons.DreadbloonProps;
   import assets.bloons.Green;
   import assets.bloons.GreenRegen;
   import assets.bloons.Lead;
   import assets.bloons.LeadRegen;
   import assets.bloons.Pink;
   import assets.bloons.PinkRegen;
   import assets.bloons.Rainbow;
   import assets.bloons.RainbowRegen;
   import assets.bloons.Red;
   import assets.bloons.RedRegen;
   import assets.bloons.Vortex;
   import assets.bloons.VortexProps;
   import assets.bloons.White;
   import assets.bloons.WhiteRegen;
   import assets.bloons.Yellow;
   import assets.bloons.YellowRegen;
   import assets.bloons.Zebra;
   import assets.bloons.ZebraRegen;
   import assets.effects.Stun;
   import flash.display.BitmapData;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   
   public class BloonClip
   {
      
      private static var propFrames:Vector.<Vector.<Frame>> = new Vector.<Vector.<Frame>>();
      
      private static var bloonFrameSets:Vector.<Vector.<Frame>>;
      
      private static var regenBloonFrameSets:Vector.<Vector.<Frame>>;
      
      private static var camoFrames:Vector.<Frame>;
      
      public static var ddtCamoFrames:Clip;
      
      private static var regenFrames:Vector.<Frame>;
      
      private static var iceFrames:Vector.<Frame>;
      
      private static var glueFrames:Vector.<Frame>;
      
      private static var dissolverFrames:Vector.<Frame>;
      
      private static var burnyFrames:Vector.<Frame>;
      
      private static var stunFrames:Vector.<Frame>;
      
      public static var sourceClasses:Vector.<Class> = Vector.<Class>([Red,Blue,Green,Yellow,Pink,Black,White,Zebra,Lead,Rainbow,Ceramic,Moab,Bfb,BossBlimp,Ddt,Bloonarius,Vortex,BlastopopoulosRed,Dreadbloon]);
      
      public static var regenSourceClasses:Vector.<Class> = Vector.<Class>([RedRegen,BlueRegen,GreenRegen,YellowRegen,PinkRegen,BlackRegen,WhiteRegen,ZebraRegen,LeadRegen,RainbowRegen,CeramicRegen,RainbowRegen,RainbowRegen,RainbowRegen,RainbowRegen,RainbowRegen,RainbowRegen,RainbowRegen,RainbowRegen]);
      
      public static var labels:Vector.<String> = Vector.<String>(["red","blue","green","yellow","pink","black","ice","zebra","lead","rainbow","ceramic","regen"]);
      
      public static var burnyFrameGroups:Object = {};
      
      {
         initBurnyFrameGroups();
      }
      
      private var bloonFrame:Frame;
      
      private var camoFrame:Frame;
      
      private var regenFrame:Frame;
      
      private var iceFrame:Frame;
      
      private var glueFrame:Frame;
      
      private var dissolverFrame:Frame;
      
      private var currentBurnyFrames:Vector.<Frame>;
      
      private var currentStunFrames:Vector.<Frame>;
      
      private var currentPropFrames:Vector.<Frame>;
      
      private var propIndex:int = 0;
      
      private var stunFrameIndex:int = 0;
      
      private var burnyFrameIndex:int = 0;
      
      private var bloonFrameIndex:int = 0;
      
      public var propVisible:Boolean = true;
      
      public var bloonVisible:Boolean = true;
      
      public var camoVisible:Boolean = false;
      
      public var regenVisible:Boolean = false;
      
      public var iceVisible:Boolean = false;
      
      public var glueState:int = 0;
      
      public var burnyStuffVisible:Boolean = false;
      
      public var stunVisible:Boolean = false;
      
      public var type:int;
      
      public function BloonClip()
      {
         var _loc1_:FrameFactory = null;
         var _loc2_:int = 0;
         this.currentBurnyFrames = new Vector.<Frame>();
         this.currentStunFrames = new Vector.<Frame>();
         this.currentPropFrames = new Vector.<Frame>();
         super();
         if(bloonFrameSets == null)
         {
            _loc1_ = Main.instance.frameFactory;
            bloonFrameSets = new Vector.<Vector.<Frame>>();
            regenBloonFrameSets = new Vector.<Vector.<Frame>>();
            _loc2_ = 0;
            while(_loc2_ < sourceClasses.length)
            {
               bloonFrameSets.push(Main.instance.frameFactory.getFrames(sourceClasses[_loc2_],_loc2_ >= Bloon.MOAB?16:0));
               regenBloonFrameSets.push(Main.instance.frameFactory.getFrames(regenSourceClasses[_loc2_],0));
               _loc2_++;
            }
            camoFrames = _loc1_.getFrames(CamoEffect,0);
            iceFrames = _loc1_.getFrames(IceEffect,0);
            glueFrames = _loc1_.getFrames(GlueEffect,0);
            dissolverFrames = _loc1_.getFrames(DissolverEffect,0);
            stunFrames = _loc1_.getFrames(Stun,0);
            propFrames = new Vector.<Vector.<Frame>>();
            propFrames.push(_loc1_.getFrames(MoabProps,16));
            propFrames.push(_loc1_.getFrames(BfbProps,16));
            propFrames.push(_loc1_.getFrames(BossBlimpProps,16));
            propFrames.push(_loc1_.getFrames(DdtProp,16));
            propFrames.push(_loc1_.getFrames(BloonariusProps,16));
            propFrames.push(_loc1_.getFrames(VortexProps,16));
            propFrames.push(_loc1_.getFrames(BlastopopoulosProps,16));
            propFrames.push(_loc1_.getFrames(DreadbloonProps,16));
            ddtCamoFrames = new Clip();
            ddtCamoFrames.initialise(DDTCamoOverlay,16);
         }
      }
      
      public static function initBurnyFrameGroups() : void
      {
         var _loc2_:String = null;
         var _loc3_:Frame = null;
         var _loc5_:Vector.<Frame> = null;
         var _loc6_:int = 0;
         var _loc1_:FrameFactory = Main.instance.frameFactory;
         burnyFrames = _loc1_.getFrames(BurnEffect,0);
         var _loc4_:int = 0;
         while(_loc4_ < labels.length)
         {
            _loc2_ = labels[_loc4_];
            _loc5_ = burnyFrameGroups[_loc2_] = new Vector.<Frame>();
            _loc6_ = 0;
            while(_loc6_ < burnyFrames.length)
            {
               _loc3_ = burnyFrames[_loc6_];
               if(_loc3_.label === _loc2_)
               {
                  _loc5_.push(_loc3_);
               }
               _loc6_++;
            }
            _loc4_++;
         }
      }
      
      public function setFrame(param1:int, param2:Number = 0) : void
      {
         var _loc4_:Vector.<Frame> = null;
         var _loc5_:int = 0;
         var _loc6_:Frame = null;
         var _loc7_:Vector.<Frame> = null;
         var _loc8_:String = null;
         this.type = param1;
         param2 = Math.min(Math.max(0,param2),1);
         if(!this.regenVisible)
         {
            _loc4_ = bloonFrameSets[param1];
         }
         else
         {
            _loc4_ = regenBloonFrameSets[param1];
         }
         this.bloonFrameIndex = Math.max(1,Math.ceil(_loc4_.length * (1 - param2))) - 1;
         this.bloonFrame = _loc4_[this.bloonFrameIndex];
         var _loc3_:String = null;
         if(!this.regenVisible && param1 < Bloon.MOAB)
         {
            this.camoFrame = camoFrames[param1];
            this.iceFrame = iceFrames[param1];
            this.glueFrame = glueFrames[param1];
            this.dissolverFrame = dissolverFrames[param1];
            _loc3_ = param1 < Bloon.MOAB?labels[param1]:null;
         }
         else
         {
            _loc5_ = 11;
            this.camoFrame = camoFrames[_loc5_];
            this.iceFrame = iceFrames[_loc5_];
            this.glueFrame = glueFrames[_loc5_];
            this.dissolverFrame = dissolverFrames[_loc5_];
            _loc3_ = "regen";
         }
         if(_loc3_)
         {
            if(burnyFrameGroups.hasOwnProperty(_loc3_))
            {
               this.currentBurnyFrames = burnyFrameGroups[_loc3_];
            }
            else
            {
               this.currentBurnyFrames.length = 0;
            }
            this.currentStunFrames.splice(0,this.currentStunFrames.length);
            for each(_loc6_ in stunFrames)
            {
               if(_loc6_.label == _loc3_)
               {
                  this.currentStunFrames.push(_loc6_);
               }
            }
         }
         if(Bloon.isHugeClass(param1))
         {
            _loc7_ = propFrames[param1 - Bloon.MOAB];
            this.currentPropFrames.splice(0,this.currentPropFrames.length);
            _loc8_ = Math.max(1,Math.ceil(4 * (1 - param2))).toString();
            for each(_loc6_ in _loc7_)
            {
               if(_loc6_.label == _loc8_)
               {
                  this.currentPropFrames.push(_loc6_);
               }
            }
         }
      }
      
      public function quickDraw(param1:BitmapData, param2:Number, param3:Number) : void
      {
         if(this.burnyStuffVisible)
         {
            this.burnyFrameIndex++;
            this.burnyFrameIndex = this.burnyFrameIndex < this.currentBurnyFrames.length?int(this.burnyFrameIndex):0;
            this.currentBurnyFrames[this.burnyFrameIndex].quickDraw(param1,param2,param3);
         }
         if(this.bloonVisible)
         {
            this.bloonFrame.quickDraw(param1,param2,param3);
         }
         if(this.camoVisible)
         {
            this.camoFrame.quickDraw(param1,param2,param3);
         }
         if(this.iceVisible)
         {
            this.iceFrame.quickDraw(param1,param2,param3);
         }
         if(this.glueState == 1)
         {
            this.glueFrame.quickDraw(param1,param2,param3);
         }
         else if(this.glueState == 2)
         {
            this.dissolverFrame.quickDraw(param1,param2,param3);
         }
         if(this.stunVisible)
         {
            this.stunFrameIndex++;
            this.stunFrameIndex = this.stunFrameIndex < this.currentStunFrames.length?int(this.stunFrameIndex):0;
            this.currentStunFrames[this.stunFrameIndex].quickDraw(param1,param2,param3);
         }
      }
      
      public function drawRotated(param1:BitmapData, param2:Number, param3:Number, param4:Number) : void
      {
         this.propIndex++;
         this.propIndex = this.propIndex < this.currentPropFrames.length?int(this.propIndex):0;
         if(this.propVisible)
         {
            this.currentPropFrames[this.propIndex].drawRotated(param1,param2,param3,param4);
         }
         if(this.bloonVisible)
         {
            this.bloonFrame.drawRotated(param1,param2,param3,param4);
         }
         if(this.camoVisible)
         {
            if(this.type === Bloon.DDT)
            {
               ddtCamoFrames.gotoAndStop(this.bloonFrameIndex);
               ddtCamoFrames.drawRotated(param1,param2,param3,param4);
            }
            else
            {
               this.camoFrame.drawRotated(param1,param2,param3,param4);
            }
         }
         if(this.iceVisible)
         {
            this.iceFrame.drawRotated(param1,param2,param3,param4);
         }
         if(this.glueState == 1)
         {
            this.glueFrame.drawRotated(param1,param2,param3,param4);
         }
         else if(this.glueState == 2)
         {
            this.dissolverFrame.drawRotated(param1,param2,param3,param4);
         }
      }
      
      public function get radius() : Number
      {
         return this.bloonFrame.data.height / 2;
      }
      
      public function getBloonFrame() : Frame
      {
         return this.bloonFrame;
      }
   }
}
