function Scab() end
Scab={
  __call=function(_,data)
    return Scab.new(data)
  end,
  __index = {
    new=function(data)
      local pt=Paint().setColor(Color.argb(255,
      150+(80)*math.sin(data.id),
      150+(80)*math.sin(10+data.id),
      150+(80)*math.sin(15+data.id))).setStrokeWidth(7) .setStyle(Paint.Style.STROKE)
      local data={
        include=data.include or {},
        id=data.id or "none",
        isScabAct=false,
        inputList={},
        pt=pt
      }
      return setmetatable(data,Scab)
    end,
    addScab=function(scab,map)
      map.scab[scab.id]=scab
    end,
    --添加包含的红实线，存储方式靠坐标
    addInclude=function(scab,vec)
      scab.include[#scab.include+1]=vec
    end,
    newId=function(map)
      map.scab_idCount=map.scab_idCount+1
      return map.scab_idCount
    end,

    onUpdate=function(scab,pakoo)
      local _act=false
      for i=1,#scab.include do
        local vec=scab.include[i]
        local iact=pakoo.map:signalLayerIndex(vec)
        if iact then iact=iact>=1 end
        _act=_act or iact
      end
      scab.isScabAct=_act
      local map=pakoo.map
      if scab.isScabAct then
        for i=1,#scab.include do
          local vec=scab.include[i]
          map[vec.x][vec.y].act=true
        end
       else
        for i=1,#scab.include do
          local vec=scab.include[i]
          map[vec.x][vec.y].act=false
        end
      end
    end,

    onDraw=function(scab,map,graph)
      for i=1,#scab.include do
        local vec=scab.include[i]
        local String_=map[vec.x][vec.y]
        local dx=.05
        graph:drawRect(String_.p+Vector(-.5-dx,.5+dx),String_.p+Vector(.5+dx,-.5-dx),scab.pt)
      end
    end


    --[[
    --唤醒所有红实线
    wakeUpAllInclude=function(scab,signalstr,initiator,map)
      scab.isScabAct=true
      --scab.inputList[initiator.p.x]
      for i=1,#scab.include do
        local vec=scab.include[i]
        map[vec.x][vec.y]:wakeUp()
      end
    end,
    goOutAllInclude=function(scab,signalstr,initiator,map)
      scab.isScabAct=false
      for i=1,#scab.include do
        local vec=scab.include[i]
        map[vec.x][vec.y]:goOut()
      end
    end,
--]]

    --[[
    wakeUp=function(signalstr,initiator,map)
      map.scab[signalstr.scabid]:wakeUpAllInclude(map)
    end,
    goOut=function(signalstr,initiator,map)
      map.scab[signalstr.scabid]:goOutAllInclude(map)
    end,
--]]




  }
}
setmetatable(Scab, Scab)


return Scab
