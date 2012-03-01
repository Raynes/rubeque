module ProblemsHelper

  def difficulty_options
    options = []
    Problem::DIFFICULTY_LEVELS.each_with_index do |difficulty, index|
      options << [difficulty, index]
    end
    return options
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = params[:sort] && params[:direction] == 'asc' ? 'desc' : 'asc'
    link_to title, :sort => column, :direction => direction
  end
end
