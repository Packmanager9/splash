require "TextGrapher" ## include this line to construct graphs in any file
graph = Input_set.new([], 720, 100, 40, 1, 1, 0,  0, "testgraphfile", true)  #   positions, xrange, yrange, trackline_height = (xrange/2).to_i, xstep = 1, ystep = 1, xstart = 0, ystart = 0, filename ="graph", slopemode = false.   Everything but the range and position array are optional, but casn be used to further define thr graph
## setting slopemode to true causes the output to be a png
graph.graphit("splittest") do |xdim|  ## graphit takes a block to define the curve its roughly of the form Y = |block return|   The "testoutput" parameter for graphit tells the program to name the output file testoutput.txt
    xdim =      (xdim * 0.0174533) #  to convert radians to degrees (xdim*0.0174533) for trig graphs, Math module defaults to radians,. 
    xdim =    (graph.trackline_height+(50*Math.cos(Math.sin(xdim)))).to_i   ## this part can be anything you need, it is currently a trig wave for the example output
    xdim.to_i  ## always include a ".to_i" for the graph to print correctly. To print values between whole numbers multiply the curve and chart as if the multiple was 1 
    xdim  ## block must return the value being manipulated implicitly as explicit return will cause the program to end early
end


