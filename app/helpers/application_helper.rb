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
			html += "<a href='whatsapp://send?text=דיווח על תקלה&phone=972546621300' data-action='share/whatsapp/share' class='block bg-yellow-500 hover:bg-yellow-700 text-black apy-2 px-4 rounded'><i class='gg-pen'></i> דיווח על תקלה</a>"
		else
			html = mail_to 'yarden11111@gmail.com', '<i class="gg-pen"></i> דיווח על תקלה '.html_safe,class:'block w-32 bg-yellow-500 hover:bg-yellow-700 text-black apy-2 px-4 rounded', subject: 'דיווח על תקלה'
		end
		html.html_safe
	end

end
