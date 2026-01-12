module DocumentsHelper
  def sort_link(column, title)
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    icon = if column == params[:sort]
             params[:direction] == "asc" ? " ↑" : " ↓"
           else
             ""
           end
    
    link_to "#{title}#{icon}".html_safe, 
            documents_path(query: params[:query], sort: column, direction: direction), 
            data: { turbo_frame: "documents_list" },
            class: "hover:text-black transition-colors"
  end
end
