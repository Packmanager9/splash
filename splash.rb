require "TextGrapher"

$xrange = 95
$yrange =  95
$count = 0
$countclone = 0
$start = 0
$step = 0
$stepstotal = 1000
$dotstotal = ($stepstotal*$step)+1
$pngholder = nil


$zero = ChunkyPNG::Color.rgba(255, 0, 0, 255);
$ochre = ChunkyPNG::Color.rgba(255, 255, 0, 255);
$four = ChunkyPNG::Color.rgba(0, 0, 255, 255);
$three = ChunkyPNG::Color.rgba(254, 254, 128, 255);
$ochrey = ChunkyPNG::Color.rgba(200, 0, 255, 255);
$ochrew = ChunkyPNG::Color.rgba(255, 255, 255, 255);
$two = ChunkyPNG::Color.rgba(0, 255, 0, 255);
$one = ChunkyPNG::Color.rgba(128, 0, 200, 255);
$black = ChunkyPNG::Color.rgba(0, 0, 0, 255);
$faucet = ChunkyPNG::Color.rgba(100, 100, 50, 255);
$white = ChunkyPNG::Color.rgba(255, 255, 255, 255);
$wall = ChunkyPNG::Color.rgba(50, 50, 100, 255);




class Fighter

attr_accessor :name, :status, :x, :y,  :all
@@all = []
def initialize(name, x, y, status)
    @name = name
    @status = status
    @x = x.to_i
    @y = y.to_i
    @@all << self
end
def self.all
    @@all
end
end

xd = ($xrange/4).to_i
xd3 = ($xrange/3).to_i
yd = ($yrange/4).to_i
yd3 = ($yrange/3).to_i
yd10 = ($yrange/10).to_i



#a = Fighter.new(6, xd3, yd,1)
#b = Fighter.new(1, (2*xd3), (yd),1)
#c = Fighter.new(2, (3*xd), (2*yd),1)
#d = Fighter.new(3, (2*xd), (yd+yd3+yd10),1)
#e = Fighter.new(4, (xd),  (2*yd),1)
#wall = Fighter.new(5, $xrange+1, $yrange+1, 1)
=begin
a1 = Fighter.new(0, rand($xrange), rand($yrange),1)
b2 = Fighter.new(1, rand($xrange), rand($yrange),1)
c3 = Fighter.new(2, rand($xrange), rand($yrange),1)
d4 = Fighter.new(3, rand($xrange), rand($yrange),1)
e5 = Fighter.new(4, rand($xrange), rand($yrange),1)
a6 = Fighter.new(0, rand($xrange), rand($yrange),1)
b7 = Fighter.new(1, rand($xrange), rand($yrange),1)
c8 = Fighter.new(2, rand($xrange), rand($yrange),1)
d9 = Fighter.new(3, rand($xrange), rand($yrange),1)
e0 = Fighter.new(4, rand($xrange), rand($yrange),1)
=end
#hex = Fighter.new(3, (2*xd), (2*yd),1) #this adds a  new monster
#puts "before hash"
hashgrid = {}
count = 0 
countx = 0 
county = 0 
while count < ($xrange*$yrange)
            while county < $yrange*2

                hashgrid["#{countx},#{county}"] = [countx, county, " "]
                    countx+=1
                    if countx >= $xrange*2
                        countx = 0
                        county +=1
                    end
                count+=1
            end
    end
    



    #puts "after hash"

    #puts "before pos"
#puts "after pos"
    def fuzzer (num, range, state)

        num += rand(-3..3)
        if num < 0 
            if state == false
                num=0
                else
                num=0
                end

        end
        if num >= range
            num = range
        end
        num
        end

        def fuzzer_i (num, range, state)

            num += rand(-2..2)
            if num < 0 
                if state == false
                    num=0
                    else
                    num=0
                    end
    
            end
            if num >= range
                num = range
            end
            num
            end
    

            def fuzzer_id (num, range, state)

                num += rand(0..2)
                if num < 0 
                    if state == false
                        num=0
                        else
                        num=0
                        end
        
                end
                if num >= range
                    num = range
                end
                num
                end
        

        def realfight(front, back)
            if front.name == back.name
                back.status = 0
            end
            if front.name == 0 && (back.name == 1 || back.name == 2)
                back.status = 0
            end
            if front.name == 1 && (back.name == 2 || back.name == 3)
                back.status = 0
            end
            if front.name == 2 && (back.name == 3 || back.name == 4)
                back.status = 0
            end
            if front.name == 3 && (back.name == 4 || back.name == 0)
                back.status = 0
            end
            if front.name == 4 && (back.name == 0 || back.name == 1)
                back.status = 0
            end
            if front.name == 5 
                back.status = 0
            end
            if back.name == 5 
                front.status = 0
            end
           # if back.name == "Unknown" 
            #    back.status = 0
            #    back.name = "Unknown"
            #end

            
            if front == back
                back.status = 1
                front.status = 1
            end
            if back.status == 0
            return false
            else
                return true
            end
            
            end
            
$countp = 0
#puts "Proto"
def hugeblock(hashgrid)
    #puts "enter"
count = 0


pngx = ChunkyPNG::Image.new(($xrange+1), ($yrange+1), ChunkyPNG::Color::TRANSPARENT)

count = 0
Fighter.all.each do |fighter|
    x =  fighter.x
    y =  fighter.y
#puts x
#puts y 
        hashgrid["#{x},#{y}"][2] = fighter.name
end
#puts "hash to str"

pngarray = []
count = 0
county = 0
countx = 0
while count < ($xrange*$yrange)
    pngarray = pngarray << hashgrid["#{countx},#{county}"][2]
   

    if pngarray[count] == 3
        pngx[countx , county] = $three
    elsif pngarray[count] == 0  
        pngx[countx , county] = $zero
    elsif pngarray[count] == 1  
        pngx[countx , county] =  $one
    elsif pngarray[count] == 2  
        pngx[countx , county] = $two
    elsif pngarray[count] == 4  
        pngx[countx , county] = $four
    elsif pngarray[count] == 5  
        pngx[countx , county] = $wall
    elsif pngarray[count] == 6  
        pngx[countx , county] = $faucet
    elsif pngarray[count] == 5  
        pngx[countx , county] = $wall
       else
            pngx[countx , county] = $black
        end
        countx+=1
        if countx >= $xrange
            countx = 0
            county +=1
        end
    count += 1
end

#puts "coloring"

#pngarray = pngarray.chars 

#$pngholder = pngx
if $pngholder == nil
    $pngholder = ChunkyPNG::Image.from_file('seed20.png')
else
    $pngholder = pngx 
end


#$pngholder = pngx 
    #puts Fighter.all.length
Fighter.all.clear
    #puts Fighter.all.length
    zen = 0
    yen = 0 
    while yen < $yrange
        if !(ChunkyPNG::Color.r($pngholder[zen, yen]) == 0 &&  ChunkyPNG::Color.g($pngholder[zen, yen]) == 0 && ChunkyPNG::Color.b($pngholder[zen, yen]) == 0)

     
            if ChunkyPNG::Color.r($pngholder[zen, yen]) == 255
 
                yid =  [fuzzer_i(yen, $yrange,true), $yrange].min
                xid =  [fuzzer(zen, $xrange,false), $xrange].min
         graby = (Fighter.all.select do |fighterobj| fighterobj.y == yid && fighterobj.x == xid end)
            if !graby.map(&:name).include?(0)
                 Fighter.new(0,xid, yid, 1 ) 
            end
         end
     
         if ChunkyPNG::Color.b($pngholder[zen, yen]) == 128# && (ChunkyPNG::Color.g($pngholder[zen, yen]) == 0 && ChunkyPNG::Color.b($pngholder[zen, yen]) == 0)
 
                yid =  [fuzzer(yen, $yrange,true), $yrange].min
                xid =  [fuzzer_i(zen, $xrange,false), $xrange].min
         graby = (Fighter.all.select do |fighterobj| fighterobj.y == yid && fighterobj.x == xid end)
            if !graby.map(&:name).include?(3)
                 Fighter.new(3,xid, yid, 1 ) 
         end
         end
     
         if ChunkyPNG::Color.b($pngholder[zen, yen]) == 255
 
                yid =  [fuzzer_id(yen, $yrange,true), $yrange].min
                xid =  [fuzzer(zen, $xrange,false), $xrange].min
         graby = (Fighter.all.select do |fighterobj| fighterobj.y == yid && fighterobj.x == xid end)
            if !graby.map(&:name).include?(4)
                 Fighter.new(4,xid, yid, 1 ) 
         end
         end
     

      
         if ChunkyPNG::Color.g($pngholder[zen, yen]) == 255
 
            yid =  [fuzzer(yen, $yrange,true), $yrange].min
            xid =  [fuzzer(zen, $xrange,false), $xrange].min
     graby = (Fighter.all.select do |fighterobj| fighterobj.y == yid && fighterobj.x == xid end)
        if !graby.map(&:name).include?(2)
             Fighter.new(2,xid, yid, 1 ) 
     end
     end

      
 

     if ChunkyPNG::Color.r($pngholder[zen, yen]) == 128 #  && (ChunkyPNG::Color.r($pngholder[zen, yen]) == 0 && ChunkyPNG::Color.g($pngholder[zen, yen]) == 0)
        yid =  [fuzzer(yen, $yrange,true), $yrange].min
        xid =  [fuzzer(zen, $xrange,false), $xrange].min
        graby = (Fighter.all.select do |fighterobj| fighterobj.y == yid && fighterobj.x == xid end)
    if !graby.map(&:name).include?(1)
         Fighter.new(1,xid, yid, 1 ) 
    end
end
if ChunkyPNG::Color.g($pngholder[zen, yen]) == 100 && ChunkyPNG::Color.r($pngholder[zen, yen]) == 99 && ChunkyPNG::Color.b($pngholder[zen, yen]) == 50
    yid =  [fuzzer_id(yen, $yrange,true), $yrange].min
    xid =  [fuzzer(zen, $xrange,false), $xrange].min
        Fighter.new(6,zen, yen, 1 ) 
     Fighter.new(4,xid, yid, 1 ) 

end

    if ChunkyPNG::Color.g($pngholder[zen, yen]) == 50 && ChunkyPNG::Color.r($pngholder[zen, yen]) == 50 && ChunkyPNG::Color.b($pngholder[zen, yen]) == 100
        Fighter.new(5,zen, yen, 1 ) 
 end
    end
        zen +=1
        if zen == $xrange
            zen = 0
            yen +=1
        end
    end
#puts "after inst"
def saver(pngx)
pngx.save("gifmake17/#{$countp}.png")
puts $countp

    countd = 0
    yid = 0
    xid = 0 

    while yid < $yrange
    xid = countd % $xrange
    if countd !=0 && xid == 0
        yid +=1
        if yid > $yrange 
            yid = $yrange
        end
    end
        graby = (Fighter.all.select do |fighterobj| fighterobj.y == yid && fighterobj.x == xid end)

            zid = 0
                if graby.length > 1
                    (graby.length).times do 
                        g = 0
                        f = 0
                        while g == f
                        g = rand(graby.length)
                        f= rand(graby.length)
                        end
                            g = graby[g]
                            f = graby[f]
                            if g !=f && f.name != g.name && 
                        realfight( g, f)
                     
                        end
                    end
            end
            wallprescence = graby.find do |wallfind|  wallfind.name == 5 end
                if wallprescence != nil
                        Fighter.new(5, xid, yid, 1)
                        pngx[xid,yid] = $wall
                end
                    zid += 1
            countd += 1
       end
end
$countp +=1
saver(pngx)

count += 1
end












$stepstotal.times do
    hugeblock(hashgrid)
            Fighter.all.delete_if do |fighter| fighter.status ==0 end
            
end

