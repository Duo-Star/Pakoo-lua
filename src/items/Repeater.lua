
function Repeater() end
Repeater={
  __call=function(_,data)
    return Repeater.new(data)
  end,
  __index = {
    new=function(data)
      local data={
        type="Repeater",
        p=data.p or Vector(),
        dir=1,
        wait=false,--so Monitoring
        save=false,
        startWait=0,
        delayTick=5,
        act=false,
        outputWay=1
      }
      return setmetatable(data,Repeater)
    end,

    getInfo=function(item,map)
      return "p="..item.p:translate2d_simple()
      .."\n".."dir="..tostring(item.dir)
      .."\n".."wait="..tostring(item.wait)
      .."\n".."save="..tostring(item.save)
      .."\n".."startWait="..tostring(item.startWait)
      .."\n".."delayTick="..tostring(item.delayTick)
      .."\n".."act="..tostring(item.out)

    end,

    ptON=Paint().setColor(0xFFB71C1C).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    ptOFF=Paint().setColor(0xFFBDBDBD).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    ptOutline=Paint().setColor(0xFF424242).setStrokeWidth(5) .setStyle(Paint.Style.FILL),

    uChange=function(rp,pakoo)
      if rp.delayTick<=20 then
        rp.delayTick=rp.delayTick+5
       else
        rp.delayTick=5
      end
    end,

    onDraw=function(rp,graph)
      local v=rp.p
      --local text="rp save="..tostring(rp.save).." wait="..tostring(rp.wait)
      --graph:drawText(text,v+Vector(-.2,-.1),paints.text)

      local dir=rp.dir

      local ptIn = rp.save and rp.ptON or rp.ptOFF
      local ptOut = rp.act and rp.ptON or rp.ptOFF


      if dir==1 then
        graph:drawRect(v+Vector(-.5,.1), v+Vector(.1,-.1),ptIn)
        graph:drawRect(v+Vector(.3,.5), v+Vector(.5,-.5),ptOut)
        graph:drawText(tostring(rp.delayTick),
        v+Vector(-.4,.3),
        Paint().setColor(color.text_1)
        .setTextSize(0.18*graph.lam))


      end


    end,

    updateContacts=function()

    end,

    onCreate=function(rp,pakoo)

    end,

    getInputDir=function(rp)
      local d=rp.dir
      local dirVec=Vector()
      if d==1 then dirVec=rp.p+Vector.left
       elseif d==2 then dirVec=rp.p+Vector.back
       elseif d==3 then dirVec=rp.p+Vector.right
       else dirVec=rp.p+Vector.front
      end
      return dirVec
    end,

    getInputDir=function(rp)

    end,

    getInput=function(rp,map)--加上方向
      return map:getIfActOrSignal(rp.p+Vector.left) --or map:getIfSignalstrActOrSignal(rp.p)
    end,--return bool

    goOutput=function(rp,map,signal)--@signal<bool>
      rp.act=signal
      if Signalstr.isThis(map:indexSth(rp.p+Vector.right)) then
        if signal then

          map:signalLayerAdd(rp.p+Vector.right)
          --map:signalLayerAdd(rp.p)
         else
          map:signalLayerSub(rp.p+Vector.right)
          --map:signalLayerSub(rp.p)
        end
      end

    end,

    onMonitoring=function(rp,pakoo)
      --print("onMonitoring")
      local input = rp:getInput(pakoo.map)
      rp.wait = input ~= rp.save
      rp.startWait=pakoo.tick
      rp.save=input
    end,

    onUpdate=function(rp,pakoo)
      if not( rp.wait ) then
        rp:onMonitoring(pakoo)

      end
      --[
      if rp.wait then
        --print("rp.wait")
        --[
        if rp.delayTick+rp.startWait<=pakoo.tick then
          rp:goOutput(pakoo.map, rp.save)
          rp.wait=false
          rp:onMonitoring(pakoo)
        end
        --]]
        --wait
      end
      --]]
    end,

    onDelete=function(item,map)

    end,

    isThis=function(sth)
      return getmetatable(sth)==Repeater
    end,

    onTouch_ACTION_DOWN=function(item,pakoo)

    end,

  }
}
setmetatable(Repeater, Repeater)


return Repeater
