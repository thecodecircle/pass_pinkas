module ApplicationHelper

	def mobile_device?
		 if session[:mobile_param]
			 session[:mobile_param] == "1"
		else
				request.user_agent =~ /Mobile|webOS/
		end
	end

	def error_btn
		if mobile_device?
			html = "<hr>"
			html += "<a href='whatsapp://send?text=דיווח על תקלה&phone=972546621300' data-action='share/whatsapp/share' class='mt-2 block bg-yellow-500 hover:bg-yellow-700 text-black px-4 rounded flex items-center h-8'><span>#{image_tag "bug.svg", size:"15"}</span> <span class='mx-2'>דיווח על תקלה </span></a>"
		else
			html = mail_to 'yarden11111@gmail.com', "#{image_tag "bug.svg", size:"15"}".html_safe,class:'btn btn-default mb-2 lg:mr-2 lg:mb-0 block bg-yellow-500 text-black font-normal border-none py-2 h-10  w-12 flex items-center', subject: 'דיווח על תקלה'
		end
		html.html_safe
	end

end
