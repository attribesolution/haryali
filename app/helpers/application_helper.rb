module ApplicationHelper

	def notifications_update_now
    leads = Lead.where(status: :Planted)
    three_months_ago = DateTime.now - 90.days
    count = 0
    leads.each do |lead|
      if lead.updates.size > 0
        update = lead.updates.order(created_at: :DESC).first
        if update[:created_at] < three_months_ago
          # one more needs to be updated now 
          count = count + 1
        end
      else
        if lead[:updated_at] < three_months_ago
          # one more needs to be updated now 
          count = count + 1
        end
      end
    end
    return count
  end

  def notifications_update_reminder
    leads = Lead.where(status: :Planted)
    a_week_less_than_three_months_ago = DateTime.now - 83.days
    count = 0
    leads.each do |lead|
      if lead.updates.size > 0
        update = lead.updates.order(created_at: :DESC).first
        if update[:created_at] < a_week_less_than_three_months_ago
          # one more needs to be updated soon 
          count = count + 1
        end
      else
        if lead[:updated_at] < a_week_less_than_three_months_ago
          # one more needs to be updated soon 
          count = count + 1
        end
      end
    end
    return count
  end

  def notifications_plant_now
    leads = Lead.where(status: :Paid)
    one_week_ago = DateTime.now - 7.days
    count = 0
    leads.each do |lead|
      if lead.updates.size > 0
        update = lead.updates.order(created_at: :DESC).first
        if update[:created_at] < one_week_ago
          # one more needs to be planted now 
          count = count + 1
        end
      end
    end
    return count
  end

  def notifications_total
    notifications_update_reminder + notifications_update_now + notifications_plant_now
  end
end
