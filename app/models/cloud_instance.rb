class CloudInstance < ActiveRecord::Base
require 'csv'
	
	def self.import(file)
      Dir.chdir(File.dirname(__FILE__))
      File.open("Book1.csv", "r") do |f|
  		f.each_line do |line|
    	puts line
    	column = line.split(",")
    	CloudInstance.create ( {
    		:instance_id => column[0],
    		:provider => column[1],
	      	:instance_type => column[2],
	      	:cores => column[3].to_i,
	      	:memory => column[4].to_f,
	      	:cost => column[5],
	      	:ratio => column[6],
	      	:clock_speed => column[7],
	      	:factor => column[8]
    	    	}
      	)
  		end
	end # end CSV.foreach
  end
@instances = ''
	def self.get_instance_AWS (cloudinstances, cpu, mem, clock_speed)
		@cpu = cpu
		@mem = mem
		@clock_speed = clock_speed
		@instances = CloudInstance.where("cores >= ? AND memory >= ?", cpu, mem)
		return @instances
	end
end
