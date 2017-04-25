require_relative '../students'


describe 'create_learning_paths' do
  let (:student){Students.new('student_tests.csv')}

  describe 'students class' do
    it 'has a readable list of students' do
      expect(student.sort_test_scores).to be_an Array
    end

    it 'should initialize with at least five items' do
      expect(student.sort_test_scores.length).to be > 5
    end
  end
end