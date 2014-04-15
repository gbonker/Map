class VillageActivity < ActiveRecord::Base
	# Relationships
	belongs_to :village
	belongs_to :activity

	# Validations
	validates :activity_id, presence: true, numericality: { greater_than: 0, only_integer: true }
	validates :village_id, presence: true, numericality: { greater_than: 0, only_integer: true }
	validates_presence_of :start_date

	validates_date :start_date, :on_or_before => lambda { Date.today }, :on_or_before_message => "should have started today or in the past", :on => :create
	validates_date :end_date, :on_or_after => :start_date, allow_blank: true

	validate :activity_is_not_already_assigned_to_village
	validate :village_is_active_in_system
	validate :activity_is_active_in_system

  #scopes
  scope :alphabetical_by_village, -> { joins(:village).order('name') }
  scope :alphabetical_by_activity, -> { joins(:activity).order('name') }

  	
  	def activity_is_not_already_assigned_to_village
    unless VillageActivity.where(activity_id: self.activity_id, village_id: self.village_id).to_a.empty?
      errors.add(:activity, "has already been assigned to this village")
      end
    end
      
  def village_is_active_in_system
    all_village_ids = Village.active.to_a.map(&:id)
    unless all_village_ids.include?(self.village_id)
      errors.add(:village, "is not an active village in the system")
    end
  end
  
  def activity_is_active_in_system
    all_activity_ids = Activity.active.to_a.map(&:id)
    unless all_activity_ids.include?(self.activity_id)
      errors.add(:activity, "is not an active activity in the system")
    end
  end

  def village_name
    return self.village.name
  end

  def activity_name
    return self.activity.name
  end

  
end
