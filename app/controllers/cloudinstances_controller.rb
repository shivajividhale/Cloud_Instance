class CloudinstancesController < ApplicationController
	def index
		#CloudinstancesController.import
	end

	def create
		@providers = CloudInstance.uniq.pluck(:provider)
		@best_instances = []
		@providers.each do |cloud_provider|
			@cores = params[:CPUUtil]
			@memory = params[:MEMUtil]
			@instances = CloudInstance.where("cores >= ? AND memory >= ? AND provider = ?", params[:CPUUtil], params[:MEMUtil], cloud_provider)
			@best_instances << get_instance(@instances,params[:CPUUtil], params[:MEMUtil], params[:clock_speed])
		# @CloudInstance = CloudInstance.get_instance_AWS(params[:CPUUtil], params[:MEMUtil], params[:clock_speed])
		end
		puts @best_instances
		render :show
	end

	def self.import
		CloudInstance.import('Book1.csv')
	end
private
	def get_instance(cloudinstances, cores, mem, clock_speed)
		instance_list = []

		min = [999.99]
		cloudinstances.each do |instance|
			puts instance.provider
			@distance = (instance.cores*instance.factor - cores.to_i) + (instance.memory - mem.to_f)
			next if @distance > min[0]
			
			if @distance < min[0]
				min.clear 
				instance_list.clear
				min << @distance
				instance_list << instance
				next
			else
				instance_list << instance
			end
		end
		instance_list.each do |instance|
			puts instance.inspect if instance.provider == "Azure"
		end

		return instance_list[0] if instance_list.length == 1
			
		result = instance_list.sort_by do |item|
    		item[:clock_speed]
		end
		instance_list.clear
		result.each do |instance|
			if instance.clock_speed > params[:clock_speed].to_f 
				if instance_list.length == 0
					instance_list << instance 
				elsif instance.clock_speed < instance_list[0].clock_speed
					instance_list.clear
					instance_list << instance
				else
					instance_list << instance if instance_list[0].clock_speed == instance.clock_speed 
				end
			end
		end
		return instance_list[0] if instance_list.length == 1
		if instance_list.length == 0
			instance_list = instance_list.sort_by do 
		else
			res = instance_list.sort_by do |item|
    			item[:cost]
			end 
		end	
		res = res.reverse
		return res[0]
	end	
end

