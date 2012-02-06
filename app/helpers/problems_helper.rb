module ProblemsHelper

  def difficulty_options
    options = []
    Problem::DIFFICULTY_LEVELS.each_with_index do |difficulty, index|
      options << [difficulty, index]
    end
    return options
  end
end
