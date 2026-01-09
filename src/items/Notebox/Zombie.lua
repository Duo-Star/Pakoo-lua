
function Creeper() end
Creeper={
  __call=function(_,data)
    return Creeper.new(data)
  end,
  __index = {
    new=function(data)
      local data={
        type="Light",
        iotype="o",
        p=data.p or Vector(),
        act=data.act or false,
      }
      return setmetatable(data,Creeper)
    end,

    getInfo=function(item,map)
      return "p="..item.p:translate2d_simple()
      .."\n".."act="..tostring(item.act)
    end,

    ptON=Paint().setColor(0xFFFFCA28).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    ptOFF=Paint().setColor(0xFFBDBDBD).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    ptOutline=Paint().setColor(0xFF424242).setStrokeWidth(5) .setStyle(Paint.Style.FILL),

    onDraw=function(String_,graph)

      local pt
      if String_.act then
        pt=String_.ptON
        --graph:drawBitmap(res.bitmap.copper_bulb_1,String_.p+Vector(-.48,.5),0.062,pt)

       else
        --graph:drawBitmap(res.bitmap.copper_bulb_0,String_.p+Vector(-.48,.5),0.062,pt)

        pt=String_.ptOFF
      end

      graph:drawBitmap(res.bitmap.Creeper,String_.p+Vector(-.48,.5),0.062,pt)

      --graph:drawBitmap(res.bitmap.Redstone_Dust,String_.p+Vector(-.48,.5),0.006,pakoo.graph.paints.grid)

      --graph:drawRect(String_.p+Vector(-.3,.3),String_.p+Vector(.3,-.3),pt)

    end,
    onCreate=function(torch,pakoo)

    end,

    onTurnOn=function(cp)

      soundPool.play(1, 1,1,0,0,1)

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
      --print(tostring(a1)..tostring (a2) .. tostring (a3) .. tostring (a4) .. tostring (a5))
    end,

    onDelete=function(item,map)
      map[item.p.x][item.p.y]=nil
    end,

    isThis=function(sth)
      return getmetatable(sth)==Creeper
    end,

    onTouch_ACTION_DOWN=function(item,pakoo)

    end,



  }
}
setmetatable(Creeper, Creeper)


return Creeper
