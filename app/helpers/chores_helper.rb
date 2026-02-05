module ChoresHelper
  def check_day(chore, day)
    return true if !chore.persisted? && chore.days.blank?
    chore.days.include?(day) ? "checked" : nil
  end
end
