require 'csv'

class Students

  def initialize(file)
    @domain_order = CSV.read('domain_order.csv', converters: :all)
    @students = CSV.read('student_tests.csv', headers: true, converters: :all)
  end
  
  def sort_test_scores
    @students_array = []
    @students.each do |x|
      @students_array << x.to_a
    end

    @student_sorted_scores = []
    @students_array.each do |student|      
      student_scores = []
      student_scores << student.shift
      student_arr = []

      student.each do |arr|
        arr[0], arr[1] = arr[1], arr[0]
        if arr[0] == "K"
          arr[0] = 0
        end
        student_arr << arr
      end

      student_sorted = student_arr.sort_by(&:first)
      
      i = 0 
      until i >= 6     
        student_sorted.each do |score|
          if score[0] == i
            lowest_score = student_sorted.shift
            student_scores << lowest_score
            ls = lowest_score.clone 
            augmented_lowest_score = ls.map!{|e| e == i ? (i + 1) : e}
            student_sorted = student_sorted.insert(0, augmented_lowest_score)
            student_sorted = student_sorted.sort_by(&:first)
          end   
        end
        i += 1     
      end 
      @student_sorted_scores << student_scores    
    end 
  end


  def create_learning_paths
    @order = []
    @domain_order.each do |scores| 
      i = 1 
      until i >= scores.length
        score = scores[0], scores[i]
        if score[0] == "K"
           score[0] = 0
        end
        @order << score
        i += 1
      end 
    end

    @student_sorted_scores.each do |student|
      learning_path = []
      learning_path << student.shift
      if student == []
        i = 0
        until i >= 5
          learning_path << @order[i]
        i += 1
        end
        learning_path.each do |path|
          if path[0] == 0
             path[0] = "K"
          end
        end 
      else
        @order.each do |score1|
          student.each do |score2|
            if score1 == score2
               learning_path << score2
            end         
          end 
          learning_path.slice!(6)
        end
          learning_path.each do |path|
            if path[0] == 0
               path[0] = "K"
            end
          end 
      end    
      p learning_path
    end    
  end


end

