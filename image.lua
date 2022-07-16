local bit = require("bit32")
comp=require("component")
fs=require("filesystem")
math=require("math")
ev=require("event")
gpu2 = comp.gpu --comp.proxy(comp.get("ca834199"))
--gpu3=comp.proxy(comp.get("ea681383"))

local _,addr1=ev.pull("touch")
gpu2.bind(addr1)
gpu2.setBackground(0x000000)
gpu2.fill(1,1,160,50,' ')

function col8ToRGB(col8)
  local r3=bit.band(col8,224)
  local g3=bit.band(col8,28)
  local b2=bit.band(col8,3)

  return r3*32, g3*32, b2*64
end

function rgb2hex(r, g, b)
    return r*65536+g*256+b
end

function bitmapToScreen(file,gpux,w,h)
  for y=1,h do
    for x=1,w do
      local bytes={string.byte(file.read(file,6),1,-1)}
      
      local col=rgb2hex(bytes[1],bytes[2],bytes[3])
      --local col=rgb2hex(col8ToRGB(bytes[1]))
      local col2=rgb2hex(bytes[4],bytes[5],bytes[6])
      --local col2=rgb2hex(col8ToRGB(bytes[2]))
      
        gpux.setBackground(col)
        gpux.setForeground(col2)
        gpux.set(x,y,'▄')
      end
    end
end

function drawBitmap(bmpName)
  self=fs.open(bmpName)
  w=string.byte(self:read(1))
  h=string.byte(self:read(1))/2
  print("ОНО ДОШЛО!!!")

  gpu2.bind(addr1)
  gpu2.setResolution(w,h)
  bitmapToScreen(self,gpu2,w,h)
end

drawBitmap("/home/image.ocif")
ev.pull("touch")
