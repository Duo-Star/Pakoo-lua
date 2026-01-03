function Villager() end
Villager={
  __call=function(_,data)
    return Villager.new(data)
  end,
  __index = {
    new=function(data)
      local data={
        type="Villager",
        p=data.p or Vector(),
        act=data.act or false,
      }
      return setmetatable(data,Villager)
    end,

    getInfo=function(item,map)
      return "p="..item.p:translate2d_simple()
      .."\n".."act="..tostring(item.act)
    end,
    ptOutline=Paint().setColor(0xFF616161).setStrokeWidth(1) .setStyle(Paint.Style.FILL),
    onDraw=function(String_,graph)
      local ptOutline=String_.ptOutline
      graph:drawRect(String_.p+Vector(-.5,.5),String_.p+Vector(.5,-.5),ptOutline)
      graph:drawBitmap(res.bitmap.SkeletonFace,String_.p+Vector(-.4,.38),0.012,ptOutline)
    end,
    onCreate=function(torch,pakoo)

    end,
    onTurnOn=function(cp)
      soundPool.play(res.sound["Skeleton_idle"..math.random(1,3)], 1,1,0,0,1)
    end,
    onUpdate=function(lt,pakoo)
      local _act=lt.act
      local map=pakoo.map
      local a1= map:getIfSignalstrActOrSignal(lt.p)
      local a2= map:getIfSignalstrActOrSignal(lt.p+Vector.front)
      local a3= map:getIfSignalstrActOrSignal(lt.p+Vector.back)
      local a4= map:getIfSignalstrActOrSignal(lt.p+Vector.left)
      local a5= map:getIfSignalstrActOrSignal(lt.p+Vector.right)
      lt.act= a1 or a2 or a3 or a4 or a5
      if not(_act) and lt.act then
        lt:onTurnOn()
      end
    end,
onDelete=function(item,map)
      map[item.p.x][item.p.y]=nil
    end,
    isThis=function(sth)
      return getmetatable(sth)==Villager
    end,

    onTouch_ACTION_DOWN=function(item,pakoo)

    end,

  }
}
setmetatable(Villager, Villager)


return Villager
