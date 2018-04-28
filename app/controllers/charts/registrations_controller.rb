class Charts::RegistrationsController < Charts::AbstractChartController

def show
  @years = 2011..LATEST_YEAR
  @attendees = Attendee.yr(@year).with_planlessness(planlessness)
	# @attendees.each { |attendee| puts attendee.created_at.strftime("%b %-d %l:%M %p") }

	@chart_data = {}
	@years.each do |year|
		@chart_data[year] = {}
		total = 0
		Attendee.yr(year).with_planlessness(planlessness).each do |attendee|
			key = attendee.created_at.strftime("%m-%d")
			total += 1
			@chart_data[year][key] = total
		end
	end

  respond_to do |format|
    format.html do
      @attendee_count = @attendees.count
      @user_count = User.yr(@year).count
      @cancelled_attendee_count = Attendee.yr(@year).attendee_cancelled.count
      @planless_attendee_count = Attendee.yr(@year).planless.count
      @planful_attendee_count = Attendee.yr(@year).count - @planless_attendee_count
      render :show
    end
    format.csv do
      csv = AttendeesCsvExporter.render(@year, @attendees)
      send_data csv, filename: csv_filename, type: 'text/csv'
    end
  end
end

private

def csv_filename
  "usgc_attendees_#{Time.current.strftime("%Y-%m-%d")}.csv"
end

def planlessness
  p = params[:planlessness]
  %w[all planful planless].include?(p) ? p.to_sym : :all
end

end
