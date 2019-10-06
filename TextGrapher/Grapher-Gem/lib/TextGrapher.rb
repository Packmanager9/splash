require "Chunky_Png"

class Position # class that contains the x and y positions of a point and what character to print at that position
    attr_accessor  :xdim, :ydim, :status, :char
    def initialize(x, y, status)
        @xdim = x
        @ydim = y
        @status = status # this is rather redundant, but it can be used to filter what prints out if needed. Line 76 can be made conditional such that it checks if the position.status is true or false before printing a char, or a space respectively.
        @char = " "
    end
    def maketrue 
        @char = "X"
        @status = true
    end
    def makefalse 
        @status = false
    end
    def makenil
        @status = nil
    end
    def makeline # makes the character a "-" for any position, and sets it to print
        @char = "-"
        @status = true
    end
    def makeinput(input)  ## can be used to make a curve have any character except "|" but line 71  will need to be commented out of this code, or can be used as the characer choice
        @char = "#{input}"
        @status = true
    end
end
class Input_set # a class that contains the input prefrences and an array of position objects, which are required for the output to be created. The graphit function takes a block of the form |x| (x**2).to_i prints the x value positive half of a parabola 
    attr_accessor  :bigpointmode, :positionset, :xrange, :yrange, :trackline_height, :filename, :slopemode, :xstart, :ystart, :xstep, :ystep
        def initialize(positions, xrange, yrange, trackline_height = (xrange/2).to_i, xstep = 1, ystep = 1, xstart = 0, ystart = 0, filename ="graph", slopemode = false)
            @filename = filename
            @xrange = xrange + xstart
            @yrange = yrange + ystart
            @trackline_height = trackline_height
            @xstart = xstart
            @ystart = ystart
            @xstep = xstep
            @ystep = ystep
            if positions[0] == nil
                countx = xstart
                county = ystart
                count = 0
                    while county < yrange+ystart
                        positions[count] = Position.new((countx), (county), false)
                            countx+=xstep
                            if countx >= xrange +xstart
                                countx = 0
                                county +=ystep
                            end
                        count+=1
                    end
            end
            @slopemode = slopemode #for a future implementation of a closer representation of the graph
            @positionset = []
            @positionset = positions
            @bigpointmode = false
        end
        def bigpointmode
            @bigpointmode = true
        end
        def graphit(filename = self.filename)
             def xeq(xdim)
                xdim
            end
            def yeq(ydim)
                 ydim
            end
            @filename = filename
            count = 0
            str = "|"
            while count < self.positionset.length
                    if xeq(yield(self.positionset[count].xdim)) == yeq(self.positionset[count].ydim)  ## the block here determines the graph that is printed. 
                        self.positionset[count].makeinput("#")  ## the character "#" here is hardcoded for visability, but can be changed at will, and if commented out, the position objects can hold a character with the makeinput method, allowing for arbitrary printouts and multiple graphs
                    end 
                       if  self.trackline_height == self.positionset[count].ydim  ## this adds a straight line at the hight of the trackline parameter if it is within the range. It can be harmless deleted or duplicated and modified to produce multiple graphs
                        self.positionset[count].makeinput("-")
                    end  
                    str = str+self.positionset[count].char       
                if (count+@xstart) % (self.xrange) == 0   && count != 0  ## this conditional evaluation determines when to break the graph up by row, if this evaluates incorrectly the graph will be warped or unreadable
                    if self.slopemode == true

                    else
                    str =  str +"|\n|"            ## do not graph with | because the lines are split by this character, or if required, change the spilt and this line to a different character but consistent in both places to maintain graph structure
                    end
                end
                    count+=1
            end
            ## the block below orients the graph in the standard layout, as it is written upsidedown and backwards
            strray = []
            strray = str.split("|")
            count = 0
            closedreverse = []
            while count < strray.length
                closedreverse << strray[count].reverse
                count +=1
            end
            str = ""
            count = 0
            while count < closedreverse.length
            str = str +closedreverse[count]
            count +=1
            end

             if self.slopemode == true ## requires the ChunkyPNG gem 
                        red = ChunkyPNG::Color.rgba(255, 0, 0, 255);
                        green = ChunkyPNG::Color.rgba(0, 255, 0, 255);
                        blue = ChunkyPNG::Color.rgba(0, 0, 255, 255);
                        black = ChunkyPNG::Color.rgba(0, 0, 0, 255);
                        white = ChunkyPNG::Color.rgba(255, 255, 255, 255);
                        pngx = ChunkyPNG::Image.new((self.xrange/self.xstep).to_i, (self.yrange/self.ystep).to_i, ChunkyPNG::Color::TRANSPARENT)
            # You can now set the color of pixels in this 20x20 PNG like so:

                    pngarray = []
                    pngarray = str.chars
                    count = 0
                        while pngarray[count] && self.positionset[count] != nil 
                            if pngarray[count] == " "  
                            pngx[(self.positionset[count].xdim), (self.positionset[count].ydim).to_i] = white
                            elsif pngarray[count] == "-"  
                                pngx[(self.positionset[count].xdim), (self.positionset[count].ydim).to_i] = black
                            else
                                pngx[(self.positionset[count].xdim), (self.positionset[count].ydim).to_i] = red
                            end
                            count +=1
                        end
                    pngx.save("#{self.filename}.png")
            else
                    IO.write("#{self.filename}.txt", str.reverse)   ## this is the output writer you can change the file type if you can think of a way it benefits you
            end 
                    ## the minimum initialization set to create a graph is roughly object = Input_set.new(positions_to_graph, xrange, yrange)  followed by graph_object.graphit and a yield block if needed to create the curve, if the positions hold the curve, simply yield the parameter with a .to_i on it for the conditionals on the printout method.
            end
end
