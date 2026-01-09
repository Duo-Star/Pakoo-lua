
function Signalstr() end
Signalstr={
  __call=function(_,data)
    return Signalstr.new(data)
  end,
  __index = {
    new=function(data)
      local data={
        type="Signalstr",
        iotype="t",
        p=data.p or Vector(),
        act=data.act or false,
        contacts={
          [1]=false,[2]=false,
          [3]=false,[4]=false
        },
        gist={},
        scabid=data.scabid or "none",
        paint=data.paint
      }
      return setmetatable(data,Signalstr)
    end,
    getInfo=function(item,map)
      return "p="..item.p:translate2d_simple()
      .."\n".."act="..tostring(item.act)
      .."\n".."contacts="..dump(item.contacts)
      .."\n".."scabid="..item.scabid
      --.."\n"..""..dump(map.scab[item.scabid].include)
    end,

    getScab=function(s,map)
      return map.scab[s.scabid]
    end,

    ptON=Paint().setColor(0xFFB71C1C).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    ptOFF=Paint().setColor(0xFFBDBDBD).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    ptOutline=Paint().setColor(0xFF424242).setStrokeWidth(5) .setStyle(Paint.Style.FILL),

    onDraw=function(String_,graph)
      local pt
      if String_.act then
        pt=String_.ptON
       else
        pt=String_.ptOFF
      end
      --graph:drawBitmap(res.bitmap.Redstone_Dust,String_.p+Vector(-.48,.5),0.006,pakoo.graph.paints.grid)
      graph:drawRect(String_.p+Vector(-.1,.1),String_.p+Vector(.1,-.1),pt)
      for i=1,4 do
        if String_.contacts[i] then
          if i==1 then
            graph:drawRect(String_.p+Vector(-.5,.1),String_.p+Vector(-.1,-.1),pt)
           elseif i==2 then
            graph:drawRect(String_.p+Vector(.1,.1),String_.p+Vector(.5,-.1),pt)
           elseif i==3 then
            graph:drawRect(String_.p+Vector(-.1,-.1),String_.p+Vector(.1,-.5),pt)
           else
            graph:drawRect(String_.p+Vector(-.1,.5),String_.p+Vector(.1,.1),pt)
          end
        end
      end

    end,



    updateContacts=function(map,vec)
      local me=map:indexSth(vec)
      local _X=map:get_X(vec)
      local X_=map:getX_(vec)
      local _Y=map:get_Y(vec)
      local Y_=map:getY_(vec)
      me.contacts[1]=Signalstr.isThis(_X)
      me.contacts[2]=Signalstr.isThis(X_)
      me.contacts[3]=Signalstr.isThis(_Y)
      me.contacts[4]=Signalstr.isThis(Y_)
    end,

    onCreate=function(vec,map)

      --print("\n addSignalstr")
      local signalstr=Signalstr{
        p=vec,
        act=false,
        scabid="none"
      }
      map:add(signalstr,vec)
      Signalstr.updateContacts(map,vec)
      local me=map:indexSth(vec)
      local contactsSignalstr={}

      for i=1,4 do
        local item=me.contacts[i]--读取到邻居
        if item and i==1 then
          local hisVec=vec+Vector(-1)
          contactsSignalstr[#contactsSignalstr+1]= map:indexSth(hisVec)
          Signalstr.updateContacts(map,hisVec)
          --[[@map:updateContacts(hisVec)
          为了让他们邻居的显示能够跟我们相连，
          这个东西只起到视觉作用，
          不会对我们自己的创建逻辑产生影响--]]
         elseif item and i==2 then
          local hisVec=vec+Vector(1)
          contactsSignalstr[#contactsSignalstr+1]= map:indexSth(hisVec)
          Signalstr.updateContacts(map,hisVec)

         elseif item and i==3 then
          local hisVec=vec+Vector(0,-1)
          contactsSignalstr[#contactsSignalstr+1]= map:indexSth(hisVec)
          Signalstr.updateContacts(map,hisVec)

         elseif item and i==4 then
          local hisVec=vec+Vector(0,1)
          contactsSignalstr[#contactsSignalstr+1]= map:indexSth(hisVec)
          Signalstr.updateContacts(map,hisVec)
        end
      end
      --查重与去除
      local contactsSignalstr_scabid={}
      for i=1,#contactsSignalstr do
        contactsSignalstr_scabid[i]=contactsSignalstr[i].scabid
      end

      local __contactsSignalstr_scabid={contactsSignalstr_scabid[1]}
      for i=1,#contactsSignalstr_scabid do
        local item=contactsSignalstr_scabid[i]
        local has=false
        for j=1,#__contactsSignalstr_scabid do
          local __item=__contactsSignalstr_scabid[j]
          if item==__item then
            has=true
            --print(__item.."and"..item.."消除重复")
          end
        end
        if not(has) then
          __contactsSignalstr_scabid[i]=contactsSignalstr_scabid[i]
        end
      end


      if #__contactsSignalstr_scabid>=2 then
        --print("#__contactsSignalstr_scabid="..#__contactsSignalstr_scabid..",已执行归并")
        local _scabid=contactsSignalstr[1].scabid
        map.scab[_scabid]:addInclude(vec)
        me.scabid=_scabid--到此为止已经把自己加进去了
        --print("到此为止已经把自己加进去了scabid".._scabid)
        --现在来开始处理另外
        --先知道有哪些
        local others={}
        for i=2,#__contactsSignalstr_scabid do
          others[i-1]=contactsSignalstr[i]
        end
        --print(dump(others))
        --print("知道了有哪些"..dump(contactsSignalstr).."以上就是这些")
        --下面开始处理它们
        for i=1,#others do
          local willdelete=others[i].scabid
          --获取他的所有包涵(Vec)
          local include= map.scab[others[i].scabid].include
          --逐一转移到主要的邻居
          for i=1,#include do
            map.scab[_scabid]:addInclude(include[i])
            map:indexSth(include[i]).scabid=_scabid
          end
          --print("willdelete"..willdelete)
          --print(dump(map.scab[willdelete]))
          if map.scab[willdelete] then
            map.scab[willdelete]=nil
          end
          --print(dump(map.scab[_scabid]))
          --print("打印全部表"..dump(map.scab))
        end
        --]]

       elseif #__contactsSignalstr_scabid==1 then
        --print("#__contactsSignalstr_scabid=1,已执行归并")
        local _scabid=contactsSignalstr[1].scabid
        map.scab[_scabid]:addInclude(vec)
        me.scabid=_scabid

       else

        local scabid=math.floor(os.time()*0.0001)*10000*10+vec.x+vec.y+math.random(-50,50)--加的ID靠时间戳
        --print("新创建scab: "..scabid)
        me.scabid=scabid
        Scab.addScab(Scab.new{ include={vec},id=scabid},map)
      end
      --print("在场的scab: "..map:totalScabNum().."个")
      --print("结束本次创建")

    end,

    onDelete=function(signalstr,map,pakoo)
      local will_delete=signalstr
      local scab=signalstr:getScab(map)
      local do_not_delete={}
      for i=1,#scab.include do
        local vec=scab.include[i]
        if will_delete.p.x==vec.x and will_delete.p.y==vec.y then
         else
          do_not_delete[#do_not_delete+1]=map[vec.x][vec.y]
          map[vec.x][vec.y]=nil
          --print(dump(vec))
        end
      end
      map[will_delete.p.x][will_delete.p.y]=nil
      map.scab[will_delete.scabid]=nil

      for i=1,#do_not_delete do
        local item=do_not_delete[i]
        local vec=item.p
        map:addSignalstr(vec,pakoo)
      end


    end,

    wakeUp=function(signalstr,initiator,map)
      signalstr.act=true
      local scabid=signalstr.scabid
      map.scab[scabid]:wakeUp(signalstr,initiator,map)
    end,
    goOut=function(signalstr,initiator,map)
      signalstr.act=false
      local scabid=signalstr.scabid
      map.scab[scabid]:goOut(signalstr,initiator,map)
    end,
    onUpdate=function(String_,pakoo)

    end,



    isThis=function(sth)
      return getmetatable(sth)==Signalstr
    end,


    onTouch_ACTION_DOWN=function(item,pakoo)

    end,


  }
}
setmetatable(Signalstr, Signalstr)


return Signalstr
