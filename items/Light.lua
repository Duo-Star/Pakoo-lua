
function Light() end
Light={
  __call=function(_,data)
    return Light.new(data)
  end,
  __index = {
    new=function(data)
      local data={
        type="Light",
        p=data.p or Vector(),
        act=data.act or false,
      }
      return setmetatable(data,Light)
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
        --graph:drawBitmap(res.bitmap.Copper_bulb_1,String_.p+Vector(-.48,.5),0.062,pt)
       else
        --graph:drawBitmap(res.bitmap.Copper_bulb_0,String_.p+Vector(-.48,.5),0.062,pt)
        pt=String_.ptOFF
      end
      --graph:drawBitmap(res.bitmap.Redstone_Dust,String_.p+Vector(-.48,.5),0.006,pakoo.graph.paints.grid)
      graph:drawRect(String_.p+Vector(-.3,.3),String_.p+Vector(.3,-.3),pt)
    end,
    onCreate=function(torch,pakoo)

    end,

    onUpdate=function(lt,pakoo)

      local map=pakoo.map
      local a1= map:getIfSignalstrActOrSignal(lt.p)
      local a2= map:getIfSignalstrActOrSignal(lt.p+Vector.front)
      local a3= map:getIfSignalstrActOrSignal(lt.p+Vector.back)
      local a4= map:getIfSignalstrActOrSignal(lt.p+Vector.left)
      local a5= map:getIfSignalstrActOrSignal(lt.p+Vector.right)
      lt.act= a1 or a2 or a3 or a4 or a5
      --print(tostring(a1)..tostring (a2) .. tostring (a3) .. tostring (a4) .. tostring (a5))
    end,

    onDelete=function(item,map)
      map[item.p.x][item.p.y]=nil
    end,

    isThis=function(sth)
      return getmetatable(sth)==Light
    end,

    onTouch_ACTION_DOWN=function(item,pakoo)

    end,

  }
}
setmetatable(Light, Light)


return Light
