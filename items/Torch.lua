function Torch() end
Torch={
  __call=function(_,data)
    return Torch.new(data)
  end,
  __index = {
    new=function(data)
      local data={
        type="Torch",
        p=data.p,
        pt_head=Paint().setColor(0xFFC2185B).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
        pt_body=Paint().setColor(0xFF795548).setStrokeWidth(5) .setStyle(Paint.Style.FILL)
      }
      return setmetatable(data,Torch)
    end,
    ptOutline=Paint().setColor(0xFFBDBDBD).setStrokeWidth(5) .setStyle(Paint.Style.STROKE),
    pt_head=Paint().setColor(0xFFFD0000).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    pt_head_core=Paint().setColor(0xFFFFD800).setStrokeWidth(5) .setStyle(Paint.Style.FILL),

    pt_body=Paint().setColor(0xFF616161).setStrokeWidth(5) .setStyle(Paint.Style.FILL),


    onDraw=function(torch,graph)
      graph:drawRect(torch.p+Vector(-.5,.5),torch.p+Vector(.5,-.5),Torch.ptOutline)
      graph:drawRect(torch.p+Vector(-.12,.42),torch.p+Vector(.12,.17),Torch.pt_head)
      graph:drawRect(torch.p+Vector(-.06,.36),torch.p+Vector(.06,.24),Torch.pt_head_core)
      graph:drawRect(torch.p+Vector(-.06,.17),torch.p+Vector(.06,-.4),Torch.pt_body)
    end,

    onCreate=function(torch,pakoo)
      pakoo.map:signalLayerAdd_Quartet(torch.p)

    end,
    getInfo=function(item)
      return "p="..item.p:translate2d_simple()
    end,

    onUpdate=function(torch,pakoo)

    end,

    onDelete=function(item,map)
      map[item.p.x][item.p.y]=nil
      map:signalLayerSub_Quartet(item.p)
    end,


    onTouch_ACTION_DOWN=function(torch,pakoo)

    end,

  }
}
setmetatable(Torch, Torch)

return Torch
