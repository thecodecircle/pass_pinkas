module ApplicationHelper

	def mobile_device?
		 if session[:mobile_param]
			 session[:mobile_param] == "1"
		else
				request.user_agent =~ /Mobile|webOS/
		end
	end

	def error_btn
			html = mail_to 'yarden11111@gmail.com', "#{image_tag "bug.svg", size:"15"} #{I18n.t("home.report_btn")}".html_safe,class:'btn btn-default mt-2 block bg-yellow-500 text-black font-normal border-none py-2 h-6  w-full flex items-center', subject: "#{I18n.t("home.report_error")}"
		html.html_safe
	end

	def hello
	  "Hello"
	end

	def difficulties_hash
	  case current_user.locale
	  when "he", nil
			difficulties = {
					easy: "קל",
					medium: "בינוני",
					hard: "קשה",
					impossible: "כמעט בלתי אפשרי"
				}
		when "en"
			difficulties = {
					easy: "Easy",
					medium: "Medium",
					hard: "Hard",
					impossible: "Impossible"
				}
	  end
	end

	def ages_hash
		case current_user.locale
	  when "he", nil
			ages = {
				toddler: "קטנטנים",
				small: "ילדים קטנים",
				big: "ילדים גדולים",
				grownup: "מבוגרים"
				}
		when "en"
			ages = {
				toddler: "Toddlers",
				small: "Small Children",
				big: "Big Kids",
				grownup: "Grown Ups"
				}
	  end
	end

end
