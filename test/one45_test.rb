require 'test_helper'

class One45Test < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::One45::VERSION
  end

  def test_is_module
    assert_kind_of Module, One45
  end

  def test_domains_exist
    assert One45::Evaluations
    assert One45::Forms
    assert One45::Groups
    assert One45::Questions
    assert One45::Rotations
    assert One45::Users
  end

  def test_config_set
    One45.api_host      = nil
    One45.client_key    = nil
    One45.client_secret = nil
    assert_raises One45::One45Error do
      One45::Users.list
    end
  end

  def test_it_generates_token
    VCR.use_cassette('generate_token') do
      response = One45.generate_token(One45.client_key, One45.client_secret)
      refute_nil response
      assert_equal String, response.class
      # puts response
    end
  end

  def test_it_retrieves_questions
    VCR.use_cassette('questions') do
      response = One45::Questions.list
      refute_nil response
      assert_equal Array, response.class
    end
  end

  def test_it_finds_question_by_id
    VCR.use_cassette('question') do
      response = One45::Questions.find(504)
      refute_nil response
      assert_equal Hash, response.class
      # puts response
    end
  end

  def test_it_retrieves_list_of_users
    VCR.use_cassette('users') do
      response = One45::Users.list
      refute_nil response
      assert_equal Array, response.class
      # puts response
    end
  end

  def test_it_list_users_matching_params
    VCR.use_cassette('users_paul') do
      response = One45::Users.list(firstname: "Paul")
      refute_nil response
      assert_equal Array, response.class
      # puts response
    end
  end

  def test_it_finds_user_by_id
    VCR.use_cassette('user') do
      response = One45::Users.find(706)
      refute_nil response
      assert_equal Hash, response.class
      # puts response
    end
  end

  def test_it_retrieves_user_preferences
    VCR.use_cassette('user_preferences') do
      response = One45::Users.preferences(706)
      refute_nil response
      assert_equal Hash, response.class
      # puts response
    end
  end

  def test_it_retrieves_user_todos
    VCR.use_cassette('user_todos') do
      response = One45::Users.todos(706)
      refute_nil response
      assert_equal Array, response.class
      # puts response
    end
  end

  def test_it_retrieves_user_evaluations
    VCR.use_cassette('user_evaluations') do
      response = One45::Users.evaluations(706)
      refute_nil response
      assert_equal Array, response.class
      # puts response
    end
  end

  def test_it_retrieves_list_of_rotations
    VCR.use_cassette('rotations') do
      response = One45::Rotations.list
      refute_nil response
      assert_equal Array, response.class
      # puts response
    end
  end

  def test_it_finds_rotation_by_id
    VCR.use_cassette('rotation') do
      response = One45::Rotations.find(504)
      refute_nil response
      assert_equal Hash, response.class
      # puts response
    end
  end

  def test_it_retrieves_list_of_groups
    VCR.use_cassette('groups') do
      response = One45::Groups.list(limit: 2)
      refute_nil response
      assert_equal Array, response.class
      assert_equal 2, response.length
      # puts response
    end
  end

  def test_it_finds_group_by_id
    VCR.use_cassette('group') do
      response = One45::Groups.find(32)
      refute_nil response
      assert_equal Hash, response.class
      # puts response
    end
  end

  def test_it_finds_group_children
    VCR.use_cassette('group_children') do
      response = One45::Groups.subgroups(32)
      refute_nil response
      assert_equal Array, response.class
      # puts response
    end
  end

  def test_it_retrieves_list_of_forms
    VCR.use_cassette('forms') do
      response = One45::Forms.list(limit: 2)
      refute_nil response
      assert_equal Array, response.class
      assert_equal 2, response.length
      # puts response
    end
  end

  def test_it_finds_form_by_id
    VCR.use_cassette('form') do
      response = One45::Forms.find(1)
      refute_nil response
      assert_equal Hash, response.class
      # puts response
    end
  end

  def test_it_finds_groups_the_form_is_shared_with
    VCR.use_cassette('form_groups') do
      response = One45::Forms.groups(1)
      refute_nil response
      assert_equal Array, response.class
      # puts response
    end
  end

  def test_it_finds_form_questions
    VCR.use_cassette('form_questions') do
      response = One45::Forms.questions(1)
      refute_nil response
      assert_equal Array, response.class
      # puts response
    end
  end

  def test_it_retrieves_list_of_evaluations
    VCR.use_cassette('evaluations') do
      response = One45::Evaluations.list(limit: "1")
      refute_nil response
      assert_equal Array, response.class
      assert_equal 1, response.length
      # puts response
    end
  end

  def test_it_filters_evaluations_being_completed
    VCR.use_cassette('evaluations_completed') do
      response = One45::Evaluations.list(status: "completed")
      refute_nil response
      assert_equal Array, response.class
      assert_equal "completed", response[0]["status"]
      # puts response
    end
  end

  def test_it_filters_evaluations_completed_on
    starting = "2015-05-23T05:30:00"
    ending   = "2015-05-25T05:30:00"
    VCR.use_cassette('evaluations_completed_on') do
      response = One45::Evaluations.list(limit: 1, completed_on: "#{starting}|#{ending}")
      refute_nil response
      assert_equal Array, response.class
      completed_on = response[0]["completed_on"]
      assert completed_on, (Time.new(starting)..Time.new(ending)).cover?(completed_on)
      # puts response
    end
  end

  def test_it_finds_evaluation_by_id
    VCR.use_cassette('evaluation') do
      response = One45::Evaluations.find(59)
      refute_nil response
      assert_equal Hash, response.class
      # puts response
    end
  end

  def test_it_finds_evaluation_answers
    VCR.use_cassette('evaluation_answers') do
      response = One45::Evaluations.answers(59)
      refute_nil response
      assert_equal Array, response.class
      # puts response
    end
  end

  def test_it_finds_evaluation_contributors
    VCR.use_cassette('evaluation_contributors') do
      response = One45::Evaluations.contributors(59)
      refute_nil response
      assert_equal Array, response.class
      # puts response
    end
  end

  def test_it_finds_answers_for_evaluation_question
    VCR.use_cassette('evaluation_questions') do
      response = One45::Evaluations.question_answers(59, 12915)
      refute_nil response
      assert_equal Hash, response.class
      # puts response
    end
  end
end
