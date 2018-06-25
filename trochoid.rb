Pixel=Struct.new(:r,:g,:b)
$img=Array.new(200) do
  Array.new(300) do
    Pixel.new(255,255,255)
  end
end

def pset(x,y,r,g,b)
  if 0<=x && x<300 && 0<=y && y<200
    $img[y][x].r=r
    $img[y][x].g=g
    $img[y][x].b=b
  end
end

def writeimage(name)
  open(name,"wb") do |f|
    f.puts("P6\n300 200\n255")
    $img.each do |a|
      a.each do |p|
        f.write(p.to_a.pack('ccc'))
      end
    end
  end
end

def clearimage
  200.times do |y|
    300.times do |x|
      $img[y][x].r=255
      $img[y][x].g=255
      $img[y][x].b=255
    end
  end
end

def coordinateaxes
  for i in 0..300 do
    pset(i,100,0,0,0)
  end
  for j in 0..200 do
    pset(150,j,0,0,0)
  end
end

def circle(x0,y0,rad,r,g,b)
  aa=x0-rad.to_i
  bb=x0+rad.to_i
  cc=y0-rad.to_i
  dd=y0+rad.to_i
  for x in aa..bb do
    for y in cc..dd do
      y1=y0+Math.sqrt(rad**2-(x-x0)**2)
      y2=y0-Math.sqrt(rad**2-(x-x0)**2)
      x1=x0+Math.sqrt(rad**2-(y-y0)**2)
      x2=x0-Math.sqrt(rad**2-(y-y0)**2)  
      pset(x,y1,r,g,b)
      pset(x,y2,r,g,b)
      pset(x1,y,r,g,b)
      pset(x2,y,r,g,b)
    end
  end
end

def betweenline(x1,y1,x2,y2)
  x1i=x1.to_i
  x2i=x2.to_i
  y1i=y1.to_i
  y2i=y2.to_i
  if y1==y2 then
    if x1<x2 then
      for x in x1i..x2i do
        pset(x,y1i,0,0,0)
      end
    else
      for x in x2i..x1i do
        pset(x,y1i,0,0,0)
      end
    end
  elsif x1==x2 then
    if y1<y2 then
      for y in y1i..y2i do
        pset(x1i,y,0,0,0)
      end
    else
      for y in y2i..y1i do
        pset(x1i,y,0,0,0)
      end
    end
  else
    if x1<x2 then
      inc=(y2-y1)/(x2-x1)
      for x in x1i+1..x2i do
        y=inc*x+(y1-inc*x1)
        pset(x,y.to_i,0,0,0)
      end
    else
      inc=(y1-y2)/(x1-x2)
      for x in x2i+1..x1i do
        y=inc*x+(y1-inc*x1)
        pset(x,y.to_i,0,0,0)
      end
    end
  end
end

#def movecycle
#  circle(150,100,80,112,128,144)
#  for xc in 150..215 do
#    yc=100+Math.sqrt(65**2-(xc-150)**2)
#    circle(xc,yc.to_i,15,85,107,47)
#  end
#end

# def movecycle
#   count=1000
#   215.step(150,-1) do |x|
#     clearimage
#     coordinateaxes
#     circle(150,100,80,112,128,144)
#     y=100-Math.sqrt(65**2-(x-150)**2)
#     circle(x,y.to_i,15,85,107,47)
#     writeimage("a#{count}.ppm")
#     count=count+1
#   end
# end

# def movecircle
#   count=1000
#   0.step(2*Math::PI-Math::PI/45,Math::PI/45) do |z|
#     clearimage
#     coordinateaxes
#     circle(150,100,80,112,128,144)
#     x=65*Math.cos(z)
#     y=65*Math.sin(z)
#     p=15*Math.cos(z*80/15)
#     q=-15*Math.sin(z*80/15)
#     circle(150+x.to_i,100-y.to_i,15,85,107,47)
#     pset(150+x.to_i,100-y.to_i,250,128,114)
#     pset(150+(x+p).to_i,100-(y+q).to_i,250,128,114)
#     writeimage("a#{count}.ppm")
#     count=count+1
#   end
# end

# def movecircle(radius,start,z)
#   zzz=z*(80.0-radius)/radius
#   x=(80-radius)*Math.cos(z)
#   y=(80-radius)*Math.sin(z)
#   p=start*Math.cos(zzz)
#   q=-start*Math.sin(zzz)
#   circle(150+x.to_i,100-y.to_i,radius,85,107,47)
#   if zzz!=Math::PI/2.0 && zzz!=Math::PI*3.0/2.0 then
#     betweenline(150+x,100-y,150+x+p,100-y-q)
#     pset(150+x.to_i,100-y.to_i,250,128,114)
#     pset(150+(x+p).to_i,100-(y+q).to_i,250,128,114)
#   else
#     x1=150+x
#     y1=100-y
#     y2=100-y-q
#     y1i=y1.to_i
#     y2i=y2.to_i
#     if y1<y2 then
#       for yy in y1i+1..y2i do
#         pset(x1.to_i,yy,250,128,114)
#       end
#     else
#       for yy in y2i+1..y1i do
#         pset(x1.to_i,yy,250,128,114)
#       end
#     end
#     pset(150+x.to_i,100-y.to_i,250,128,114)
#     pset(150+(x+p).to_i,100-(y+q).to_i,250,128,114)
#   end
# end

def movecircle(radius,start,z)
  zzz=z*(80.0-radius)/radius
  x=(80-radius)*Math.cos(z)
  y=(80-radius)*Math.sin(z)
  p=start*Math.cos(zzz)
  q=-start*Math.sin(zzz)
  circle(150+x.to_i,100-y.to_i,radius,0,0,0)
  betweenline(150+x,100-y,150+x+p,100-y-q)
  pset(150+x.to_i,100-y.to_i,0,0,0)
  pset(150+x.to_i+1,100-y.to_i,0,0,0)
  pset(150+x.to_i,100-y.to_i+1,0,0,0)
  pset(150+x.to_i-1,100-y.to_i,0,0,0)
  pset(150+x.to_i,100-y.to_i-1,0,0,0)
  pset(150+(x+p).to_i,100-(y+q).to_i,255,0,0)
  pset(150+(x+p).to_i+1,100-(y+q).to_i,255,0,0)
  pset(150+(x+p).to_i,100-(y+q).to_i-1,255,0,0)
  pset(150+(x+p).to_i-1,100-(y+q).to_i,255,0,0)
  pset(150+(x+p).to_i,100-(y+q).to_i-1,255,0,0)
end

def movepoint(radius,start,z)
  x=(80-radius)*Math.cos(z)
  y=(80-radius)*Math.sin(z)
  p=start*Math.cos(z*(80.0-radius)/radius)
  q=-start*Math.sin(z*(80.0-radius)/radius)
  pset(150+(x+p).to_i,100-(y+q).to_i,255,0,0)
end

def move(radius,start,times)
  st=Time.now
  count=1000
  0.step(2.0*times*Math::PI-Math::PI/180.0,Math::PI/180.0) do |z|
    clearimage
    coordinateaxes
    circle(150,100,80,0,0,255)
    movecircle(radius,start,z)
    0.step(z,Math::PI/180.0) do |zz|
      movepoint(radius,start,zz)
    end
    writeimage("a#{count}.ppm")
    count=count+1
  end
  for ii in 1..45 do
    clearimage
    coordinateaxes
    circle(150,100,80,0,0,255)
    movecircle(radius,start,2.0*times*Math::PI)
    0.step(2.0*times*Math::PI,Math::PI/180.0) do |zz|
      movepoint(radius,start,zz)
    end
    writeimage("a#{count}.ppm")
    count=count+1
  end
  puts "#{Time.now - st}s\n"
end
