require_relative 'students'


students = Students.new('student_tests.csv')

students.sort_test_scores

students.create_learning_paths

