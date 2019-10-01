package com.lgrey.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class LGDisplayListUtil
   {
      
      private static var _instance:LGDisplayListUtil;
       
      
      public function LGDisplayListUtil(param1:SingletonEnforcer#661)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use LGDisplayListUtil.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : LGDisplayListUtil
      {
         if(_instance == null)
         {
            _instance = new LGDisplayListUtil(new SingletonEnforcer#661());
         }
         return _instance;
      }
      
      public function setPlayStateOfAllChildMovieClips(param1:DisplayObjectContainer, param2:Boolean, param3:Boolean = false, param4:Boolean = true) : void
      {
         var _loc7_:DisplayObject = null;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:int = param1.numChildren;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = param1.getChildAt(_loc6_);
            if(_loc7_ is DisplayObjectContainer)
            {
               if(_loc7_ is MovieClip)
               {
                  if(param2)
                  {
                     if(param3)
                     {
                        MovieClip(_loc7_).gotoAndPlay(1);
                     }
                     else
                     {
                        MovieClip(_loc7_).play();
                     }
                  }
                  else if(param3)
                  {
                     MovieClip(_loc7_).gotoAndStop(1);
                  }
                  else
                  {
                     MovieClip(_loc7_).stop();
                  }
               }
               this.setPlayStateOfAllChildMovieClips(DisplayObjectContainer(_loc7_),param2,param3);
            }
            _loc6_++;
         }
         if(param4)
         {
            if(param1 is MovieClip)
            {
               if(param2)
               {
                  if(param3)
                  {
                     MovieClip(param1).gotoAndPlay(1);
                  }
                  else
                  {
                     MovieClip(param1).play();
                  }
               }
               else if(param3)
               {
                  MovieClip(param1).gotoAndStop(1);
               }
               else
               {
                  MovieClip(param1).stop();
               }
            }
         }
      }
      
      public function removeAllChildren(param1:*) : void
      {
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
      }
      
      public function removeAllButTopChild(param1:*) : void
      {
         while(param1.numChildren > 1)
         {
            param1.removeChildAt(0);
         }
      }
      
      public function removeAllButBottomChild(param1:*) : void
      {
         while(param1.numChildren > 1)
         {
            param1.removeChildAt(1);
         }
      }
      
      public function offsetChildren(param1:*, param2:Number, param3:Number) : void
      {
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.numChildren)
         {
            param1.getChildAt(_loc4_).x = param1.getChildAt(_loc4_).x + param2;
            param1.getChildAt(_loc4_).y = param1.getChildAt(_loc4_).y + param3;
            _loc4_++;
         }
      }
      
      public function makeChildrenInvisible(param1:*) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            param1.getChildAt(_loc2_).visible = false;
            _loc2_++;
         }
      }
      
      public function makeChildrenVisible(param1:*) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            param1.getChildAt(_loc2_).visible = true;
            _loc2_++;
         }
      }
      
      public function transferChildren(param1:*, param2:*) : void
      {
         while(param1.numChildren > 0)
         {
            param2.addChild(param1.getChildAt(0));
         }
      }
      
      public function transferChildrenAndOffset(param1:*, param2:*, param3:Number = 0, param4:Number = 0) : void
      {
         var _loc5_:DisplayObject = null;
         while(param1.numChildren > 0)
         {
            _loc5_ = param1.getChildAt(0);
            param2.addChild(_loc5_);
            _loc5_.x = _loc5_.x + param3;
            _loc5_.y = _loc5_.y + param4;
         }
      }
      
      public function scaleChildren(param1:*, param2:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc3_);
            _loc4_.width = _loc4_.width * param2;
            _loc4_.height = _loc4_.height * param2;
            _loc4_.x = _loc4_.x * param2;
            _loc4_.y = _loc4_.y * param2;
            _loc3_++;
         }
      }
      
      public function findInstancesOfType(param1:DisplayObjectContainer, param2:Class) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.numChildren)
         {
            if(param1.getChildAt(_loc4_) is param2)
            {
               _loc3_.push(param1.getChildAt(_loc4_));
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function reparentAndPreserveGlobalPosition(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         var _loc3_:Point = null;
         _loc3_ = this.localToLocal(new Point(param1.x,param1.y),param1.parent,param2);
         param2.addChild(param1);
         param1.x = _loc3_.x;
         param1.y = _loc3_.y;
      }
      
      public function localToLocal(param1:Point, param2:DisplayObject, param3:DisplayObject) : Point
      {
         param1 = param2.localToGlobal(param1);
         param1 = param3.globalToLocal(param1);
         return param1;
      }
      
      public function hasLabel(param1:MovieClip, param2:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc5_:FrameLabel = null;
         var _loc4_:int = param1.currentLabels.length;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.currentLabels[_loc3_];
            if(_loc5_.name == param2)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
   }
}

class SingletonEnforcer#661
{
    
   
   function SingletonEnforcer#661()
   {
      super();
   }
}
