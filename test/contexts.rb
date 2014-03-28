module Contexts
	def create_villages
		@juvadi = FactoryGirl.create(:village)
		@inactive_village = FactoryGirl.create(:village, active: false)
	end

	def destroy_villages
		@juvadi.destroy
		@inactive_village.destroy
	end

	def create_activities
		@activity1 = FactoryGirl.create(:activity)
		@inactive_activity = FactoryGirl.create(:activity, active: false)
	end

	def destroy_activities
		@activity1.destroy
		@inactive_activity.destroy
	end

	def create_village_activities
		create_villages
		create_activities
		@va1 = FactoryGirl.create(:village_activity, village: @juvadi, activity: @activity1)
	end

	def destroy_village_activities
		destroy_villages
		destroy_activities
		@va1.destroy
	end

	
end
