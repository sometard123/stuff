package LoadScreen_fla
{
   import fl.motion.AnimatorFactory3D;
   import fl.motion.MotionBase;
   import fl.motion.motion_internal;
   import flash.display.MovieClip;
   import flash.geom.Matrix3D;
   import flash.text.TextField;
   
   public dynamic class LoadBarwithShadow_4 extends MovieClip
   {
       
      
      public var messageField:TextField;
      
      public var cogs:MovieClip;
      
      public var __animFactory_cogsaf1:AnimatorFactory3D;
      
      public var __animArray_cogsaf1:Array;
      
      public var ____motion_cogsaf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_cogsaf1_matArray__:Array;
      
      public var __motion_cogsaf1:MotionBase;
      
      public function LoadBarwithShadow_4()
      {
         super();
         if(this.__animFactory_cogsaf1 == null)
         {
            this.__animArray_cogsaf1 = new Array();
            this.__motion_cogsaf1 = new MotionBase();
            this.__motion_cogsaf1.duration = 1;
            this.__motion_cogsaf1.overrideTargetTransform();
            this.__motion_cogsaf1.addPropertyArray("visible",[true]);
            this.__motion_cogsaf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_cogsaf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_cogsaf1.addPropertyArray("opaqueBackground",[null]);
            this.__motion_cogsaf1.initFilters(["flash.filters.GlowFilter"],[0],0,1);
            this.__motion_cogsaf1.addFilterPropertyArray(0,"alpha",[1],0,1);
            this.__motion_cogsaf1.addFilterPropertyArray(0,"knockout",[false],0,1);
            this.__motion_cogsaf1.addFilterPropertyArray(0,"strength",[10],0,1);
            this.__motion_cogsaf1.addFilterPropertyArray(0,"blurX",[3],0,1);
            this.__motion_cogsaf1.addFilterPropertyArray(0,"blurY",[3],0,1);
            this.__motion_cogsaf1.addFilterPropertyArray(0,"inner",[false],0,1);
            this.__motion_cogsaf1.addFilterPropertyArray(0,"color",[0],0,1);
            this.__motion_cogsaf1.addFilterPropertyArray(0,"quality",[3],0,1);
            this.__motion_cogsaf1.is3D = true;
            this.__motion_cogsaf1.motion_internal::spanStart = 0;
            this.____motion_cogsaf1_matArray__ = new Array();
            this.____motion_cogsaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_cogsaf1_mat3DVec__[0] = 1;
            this.____motion_cogsaf1_mat3DVec__[1] = 0;
            this.____motion_cogsaf1_mat3DVec__[2] = 0;
            this.____motion_cogsaf1_mat3DVec__[3] = 0;
            this.____motion_cogsaf1_mat3DVec__[4] = 0;
            this.____motion_cogsaf1_mat3DVec__[5] = 1;
            this.____motion_cogsaf1_mat3DVec__[6] = 0;
            this.____motion_cogsaf1_mat3DVec__[7] = 0;
            this.____motion_cogsaf1_mat3DVec__[8] = 0;
            this.____motion_cogsaf1_mat3DVec__[9] = 0;
            this.____motion_cogsaf1_mat3DVec__[10] = 1;
            this.____motion_cogsaf1_mat3DVec__[11] = 0;
            this.____motion_cogsaf1_mat3DVec__[12] = -68;
            this.____motion_cogsaf1_mat3DVec__[13] = 20;
            this.____motion_cogsaf1_mat3DVec__[14] = 0;
            this.____motion_cogsaf1_mat3DVec__[15] = 1;
            this.____motion_cogsaf1_matArray__.push(new Matrix3D(this.____motion_cogsaf1_mat3DVec__));
            this.__motion_cogsaf1.addPropertyArray("matrix3D",this.____motion_cogsaf1_matArray__);
            this.__animArray_cogsaf1.push(this.__motion_cogsaf1);
            this.__animFactory_cogsaf1 = new AnimatorFactory3D(null,this.__animArray_cogsaf1);
            this.__animFactory_cogsaf1.addTargetInfo(this,"cogs",0,true,0,true,null,-1);
         }
      }
   }
}
