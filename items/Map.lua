function Map() end
Map={
  __call=function(_,data)
    return Map.new(data)
  end,
  __index = {
    new=function(data)
      local map={
        scab=data.scab or {},
        signalLayer={},
        size=data.size or Vector(100,100)
      }
      for i=1,map.size.x do
        map[i]={}
      end--pakoo.map[x][y]
      for i=1,map.size.x do
        map.signalLayer[i]={}
      end
      map.scab_idCount=0
      return setmetatable(map,Map)
    end,

    add=function(map,item,vec)
      map[vec.x][vec.y]=item
    end,

    getType=function(map,vec)
      local item=map[vec.x][vec.y]
      if not(item) then return "none"
       else
        return item.type
      end
    end,

    getInfo=function(map,vec)
      local item=map[vec.x][vec.y]
      local result="can not find item"
      if item then
        result=item:getInfo(map)
      end
      return result
    end,

    indexSth=function(map,vec)
      return (map[math.floor(vec.x)] or {})[math.floor(vec.y)]
    end,

    signalLayerIndex=function(map,vec)
      return (map.signalLayer[math.floor(vec.x)] or {})[math.floor(vec.y)] or 0
    end,

    signalLayerSet=function(map,vec,v)
      (map.signalLayer[math.floor(vec.x)] or {})[math.floor(vec.y)]=v
    end,

    signalLayerAdd=function(map,vec)
      map:signalLayerSet(vec,
      (map:signalLayerIndex(vec) or 0)+1
      )
    end,

    signalLayerSub=function(map,vec)
      map:signalLayerSet(vec,
      (map:signalLayerIndex(vec) or 0)-1
      )
    end,

    signalLayerAdd_Quartet=function(map,p)
      map:signalLayerAdd(p)
      map:signalLayerAdd(p+Vector.front)
      map:signalLayerAdd(p+Vector.back)
      map:signalLayerAdd(p+Vector.left)
      map:signalLayerAdd(p+Vector.right)
    end,

    signalLayerSub_Quartet=function(map,p)
      map:signalLayerSub(p)
      map:signalLayerSub(p+Vector.front)
      map:signalLayerSub(p+Vector.back)
      map:signalLayerSub(p+Vector.left)
      map:signalLayerSub(p+Vector.right)
    end,




    totalScabNum=function(map)
      local num=0
      for k, v in pairs(map.scab) do
        num=num+1
      end
      return num
    end,

    ifThereEmpty=function(map,vec)
      return map:indexSth(vec)==nil
    end,

    addSignalstr=function(map,vec)
      if map:ifThereEmpty(vec) then
        Signalstr.onCreate(vec,map)
       else
        simpleSnackMsg("这里已经有人了🐱")
      end
    end,

    deleteSth=function(map,vec)
      if map:ifThereEmpty(vec) then
        simpleSnackMsg("你要删空气¿🤔")
       else
        local will_delete=map:indexSth(vec)
        will_delete:onDelete(map)
      end
    end,

    addTorch=function(map,vec,pakoo)
      if map:ifThereEmpty(vec) then
        local torch=Torch{p=vec}
        map:add(torch,vec)
        torch:onCreate(pakoo)
       else
        simpleSnackMsg("这里已经有人了🐱")
      end
    end,

    addButton=function(map,vec,pakoo)
      if map:ifThereEmpty(vec) then
        local btn=Button{p=vec}
        map:add(btn,vec)
        btn:onCreate(pakoo)
       else
        simpleSnackMsg("这里已经有人了🐱")
      end
    end,

    addSwitch=function(map,vec,pakoo)
      local lt=Switch{p=vec}
      map:add(lt,vec)
      lt:onCreate(pakoo)
    end,

    addLight=function(map,vec,pakoo)
      local lt=Light{p=vec}
      map:add(lt,vec)
      lt:onCreate(pakoo)
    end,

    addCreeper=function(map,vec,pakoo)
      local cp=Creeper{p=vec}
      map:add(cp,vec)
      cp:onCreate(pakoo)
    end,

    addPiglin=function(map,vec,pakoo)
      local cp=Piglin{p=vec}
      map:add(cp,vec)
      cp:onCreate(pakoo)
    end,

    addSkeleton=function(map,vec,pakoo)
      local cp=Skeleton{p=vec}
      map:add(cp,vec)
      cp:onCreate(pakoo)
    end,

    addRepeater=function(map,vec,pakoo)
      local re=Repeater{p=vec}
      map:add(re,vec)
      re:onCreate(pakoo)
    end,


    getIfSignalstrActOrSignal=function(map,vec)
      local sth=map:indexSth(vec)
      local s1=Signalstr.isThis(sth) and sth.act==true
      if s1 then return true
       elseif map:signalLayerIndex(vec)>=1 then
        return true
       else return false
      end
    end,

    getIfActOrSignal=function(map,vec)
      local sth=map:indexSth(vec)
      local s1=sth and sth.act or false
      if s1 then return true
       elseif map:signalLayerIndex(vec)>=1 then
        return true
       else return false
      end
    end,


    get_X=function(map,vec)
      local a=map[vec.x-1]
      if a then return a[vec.y]
       else return nil
      end
    end,
    getX_=function(map,vec)
      local a=map[vec.x+1]
      if a then return a[vec.y]
       else return nil
      end
    end,
    get_Y=function(map,vec)
      return map[vec.x][vec.y-1]
    end,
    getY_=function(map,vec)
      return map[vec.x][vec.y+1]
    end,

  }
}
setmetatable(Map, Map)


return Map



