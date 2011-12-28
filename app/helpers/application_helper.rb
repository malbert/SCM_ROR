module ApplicationHelper
  
 def format_date(format, date)
      f = 'date.formats.' + format 
      format_date = t(f) 
      return date.strftime(format_date)
  end; 
  
   
end
